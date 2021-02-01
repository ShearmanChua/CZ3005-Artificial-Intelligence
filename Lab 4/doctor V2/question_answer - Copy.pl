:-['illness_list - Copy.pl'].

:- dynamic answered/1, have_symptom/1, pain/1, mood/1, ready_to_diagnose/1.

pain.   % store selected pain, only one will be selected
mood.   % store selected mood, only one will be selected
ready_to_diagnose.   % flag setted when all questions are asked and answered
have_symptom.  % symptoms with positive answer, including symptoms, pain, and mood
answered.         % answered items, including symptoms, pain, and mood

%% determine whether all items form a library L have been answered. can be applied to pain_level, mood_level or symptom_library
list_finished(L, ValidChoices, If_finished):-
    findall(X, answered(X), History),
    list_to_set(L, P),
    list_to_set(History, S),
    subtract(P, S, ValidChoices),
    list_empty(ValidChoices, If_finished).

head([H|_], H).

%% Following 3 rules are interface nextQuestion/1, query nextQuestion(Next) in prolog will return the next item to be asked.
%% Cut operator has been used.

%% ask symptom
nextQuestion(Next):-
    % pain and mood has finished, should ask Symptom
    pain_level(Pain_level),
    mood_level(Mood_level),
    symptom_library(Symptom_library),
    list_finished(Pain_level, _, If_pain_finished),   % determine Pain_level has all been answered 
    list_finished(Mood_level, _, If_mood_finished),   % determine Mood_level has all been answered 
    list_finished(Symptom_library, ValidChoices, _), 
    (
        (pain_selected;If_pain_finished),   % if one of pain is selected or Pain_level is answered through
        (mood_selected;If_mood_finished)    % if one of mood is selected or Mood_level is answered through
    ),!,
    random_member(Next, ValidChoices).


%% ask mood
nextQuestion(Next):-
    % pain has finished, should ask mood
    pain_level(Pain_level),
    mood_level(Mood_level),
    list_finished(Pain_level, _, If_pain_finished),   % determine Pain_level has all been answered 
    list_finished(Mood_level, ValidChoices, _),
    (
        pain_selected; If_pain_finished     % if one of pain is selected or Pain_level is answered through
    ),!,
    random_member(Next, ValidChoices).

%% ask pain
nextQuestion(Next):-
    % pain have not been selected
    pain_level(Pain_level),
    list_finished(Pain_level, ValidChoices, _),!,     
    random_member(Next, ValidChoices).



%% helper function for positive answer of answer/2,  depending of answering a pain, mood or symptom, make different action
answer_h(Q):-
    pain_level(Pain_level),
    mood_level(Mood_level),
    symptom_library(Symptom_library),
    (
        member(Q, Pain_level)  -> (assert(pain(Q)),assert(have_symptom(Q)));    % if Q is a pain
        member(Q, Mood_level)  -> assert(mood(Q));    % if Q is a mood
        member(Q, Symptom_library)->assert(have_symptom(Q))                % otherwise Q is a symptom
    ).                            % add Q to have_symptom

% Interface for answering question, eg. query answer(headache, yes) in prolog will tell the system you have headache
answer(Q, Answer):-
    assert(answered(Q)),
    (   
        Answer == yes -> answer_h(Q); Answer == q -> abort; true
    ),
    % check whether wvery thing has been answered, in other words whether ready to make diagnos
    symptom_library(Symptom_library),
    (
        list_finished(Symptom_library, _, If_symptom_finished),         % whether symptom finished
	diagnose(Result),
	(same(Result) -> assert(ready_to_diagnose(yes));true),
        (If_symptom_finished -> assert(ready_to_diagnose(yes));true)
    ).

% check if all illnesses same
same([]).
same([_]).
same([X,X|T]) :- same([X|T]).

%% helper function for making diagnosis, determin whether one illness is satisfied
diagnose_h(X):-
    findall(A, have_symptom(A), Symptom_list),
    illness(X, L), 
    is_subset(Symptom_list,L).

% Interface for making diagnosis, collect all satisfied illnesses.
diagnose(L):-
    findall(A, diagnose_h(A), L),write(L).


%% determine whether a list is empty
list_empty([], true).
list_empty([_|_], false).

%% determine whether a list L1 is a subset of L2
% eg. is_subset(L1, L2).
is_subset([], _).
is_subset([H|T], L):-
    member(H,L), is_subset(T,L).

pain_selected:-
	pain(excruciating_pain);
	pain(severe_pain);
	pain(moderate_pain);
	pain(mild_pain);
	pain(no_pain).

mood_selected:-
	mood(angry);
	mood(upset);
	mood(frustrated);
	mood(fatigued);
	mood(calm).

check_diagnose:- ready_to_diagnose(yes).