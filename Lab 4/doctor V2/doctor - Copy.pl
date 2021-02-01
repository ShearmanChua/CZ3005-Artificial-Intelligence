:-['question_answer - Copy.pl'].
:-['sentence_bank - Copy.pl'].

%%first question
ask(0):-nl,write('Hi, I am Dr Bot, let me help diagnose you today!'), reply_start.

reply_start:-
    nl,write('To help me begin,'),              % opening                    
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    write(QS), write(Human_question),write('?'),nl,write('Respond with yes or no (or press q to abort):'),read(Response),response(Question,Response),!.

reply_question:-
    opening(OP),                                % get Opening
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    write(OP),write(QS), write(Human_question),write('?'),nl,write('Respond with yes or no'),read(Response),response(Question,Response),!.

%% reply the diagnosis result page
reply_diagnose:-
    nl,write('With the answers you have provided me,'),                            % get Opening
    diagnose(X),
    sort(X, Result),
    human_diagnose(Result, Human_result),    % get diagnosis Result
    write('you might have: '), write(Human_result),write('.'),nl,retractall(answered(_)),retractall(have_symptom(_)),retractall(ready_to_diagnose(_)),retractall(pain(_)),retractall(mood(_)),ask(0),!.

response(Q, A):-
    answer(Q,A),
    (
        check_diagnose -> reply_diagnose;reply_question
    ).


?-ask(0).