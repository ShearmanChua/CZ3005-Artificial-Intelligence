:- dynamic answered/1, have_symptom/1, pain/1, mood/1, ready_to_diagnose/1.

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



%% mapping atoms in libraries to human string.
human_symptom(excruciating_pain   ,'excrutiating pain ').
human_symptom(severe_pain       ,'severe pain ').
human_symptom(moderate_pain   ,'moderate pain ').
human_symptom(mild_pain         ,'mild pain ').
human_symptom(no_pain           ,'no pain ').

human_symptom(angry             ,'angry ').
human_symptom(upset             ,'upset ').
human_symptom(frustrated          ,'frustrated ').
human_symptom(fatigued               ,'fatigued ').
human_symptom(calm              ,'calm ').

human_symptom(high_temperature       ,'that you have high temperature(above 38.5 degree celcius) ').
human_symptom(physical_pain       ,'that you have localized external physical pain(e.g. abdominal, arm, head) ').
human_symptom(insect       ,'that you have been stung by an insect or have been around insects ').
human_symptom(not_insect       ,'that you have NOT BEEN STUNG by an insect or have been around insects(reply yes if not stung) ').
human_symptom(swollen             ,'that there is swelling on affected area(reply no if mild swelling) ').
human_symptom(stinging             ,'a stinging sensation on affected area ').
human_symptom(itching             ,'an itch on affected area ').
human_symptom(redness             ,'there is redness and no bleeding on affected area ').
human_symptom(bumps             ,'there small bumps on affected area ').
human_symptom(skin_irritation             ,'that there is irritation on skin(but not painful) ').
human_symptom(open_wound             ,'that there is an open wound on skin ').
human_symptom(numb             ,'that there is localized numbness ').
human_symptom(bone             ,'that there you bone is out of place or pain when touched ').
human_symptom(limited_mobility             ,'that there is limited mobility in your limbs ').
human_symptom(mosquito             ,'that you have been bitten by a mosquito recently or live in a moquito infested area ').
human_symptom(body_ache              ,'that you have any body ache(full body) ').
human_symptom(weakness              ,'that you are more weak than usual ').
human_symptom(nauseous              ,'that you are nauseous ').
human_symptom(rash              ,'that you have a rash on your skin ').
human_symptom(mild_fever             ,'that you have a mild fever ').
human_symptom(fever             ,'that you have a fever(reply no if is mild fever) ').
human_symptom(stomach_ache             ,'that you have a stomach ache ').
human_symptom(diarrhea              ,'that you have diarrhea in the past few days ').
human_symptom(sneeze            ,'that you have been sneezing frequently as of recent ').
human_symptom(cough             ,'that you have a cough in the past few days ').
human_symptom(little_to_no_blood             ,'little to no bleeding ').
human_symptom(moderate_blood             ,'that you are bleeding moderately ').
human_symptom(alot_blood             ,'that you are bleeding severely ').
human_symptom(chills             ,'that you are having chills ').
human_symptom(sore_throat             ,'that you are having a sore throat ').
human_symptom(head             ,'that you are having localized pain around your head ').
human_symptom(localized_pain             ,'that you are having localized pain ').
human_symptom(tightness_head             ,'that you are having tightness around your head ').
human_symptom(dizzy             ,'that you are dizzy ').
human_symptom(dehydration             ,'that you are dehydrated ').
human_symptom(sweat             ,'that you have cold sweat ').
human_symptom(heavy_sweat             ,'that you are sweating heavily due to strenous activity within the past 30 minutes ').
human_symptom(exercise             ,'that you have been exercising streneously ').
human_symptom(cramps             ,'that you are having cramps ').

human_illness(allergic_insect_sting              ,'an allergic reaction to insect sting or bite(seek medical attention immediately)').
human_illness(insect_sting              ,'an insect sting or bite(do get some medication for it, seek medical attention if no improvements or if symptoms get worse)').
human_illness(rash              ,'a rash(do get some medication for it and do not scratch affected area, seek medical attention if no improvements or if symptoms get worse)').
human_illness(abrasion              ,'an abrasion, nothing to worry much about(do get some medication for it)').
human_illness(cut              ,'a small cut, you will be fine(do get some medication for it)').
human_illness(moderate_cut              ,'a moderate cut(disinfect wound and put pressure and bandage the affected area, get medical attention if bleeding do not stop)').
human_illness(deep_cut              ,'a deep cut(seek medical attention immediately)').
human_illness(injury              ,'an injury(if symptoms worsen, get medical attention)').
human_illness(severe_injury              ,'a severe injury(seek medical attention immediately)').
human_illness(blunt_force_injury              ,'a blunt force injury(advised to seek medical attention, especially if pain is above moderate pain level)').
human_illness(fracture              ,'a fracture(seek medical attention immediately, isolated affected limb and restrict movement)').
human_illness(sprain              ,'a sprain(ice and rest affected area, seek medical attention if conditions do not improve)').
human_illness(dengue_fever              ,'dengue fever(seek medical attention immediately)').
human_illness(food_poisoning    ,'food poisoning(rest and hydrate well, seek medical attention if conditions worsen)').
human_illness(cold              ,'a cold(stay at home and avoid going to crowded areas in light of covid-19, seek medical attention if high fever or symptoms worsen)').
human_illness(flu              ,'a flu(stay at home and avoid going to crowded areas in light of covid-19, seek medical attention if high fever or symptoms worsen)').
human_illness(viral_fever              ,'a viral fever(seek medical attention immediately and avoid going to crowded areas in light of covid-19)').
human_illness(fever              ,'a fever(do seek medical attention and avoid going to crowded areas in light of covid-19)').
human_illness(headache              ,'a headache(rest well, if no improvements go see a doctor)').
human_illness(migraine              ,'a migraine(rest well, if no improvements go see a doctor)').
human_illness(heat_exhausion              ,'heat exhaustion(remove excess clothings, hydrate adequately, rest in shaded area, if no improvements go see a doctor)').
human_illness(no_illness        ,'no illness or that I am not able to provide you a diagnosis based on the symptoms you have provided').

% greeting part of a interrogative sentence

openings(no_pain, 'Ok understood,in that case, ').
openings(mild_pain, 'Ok understood,in that case, ').
openings(moderate_pain, 'Ok understood,in that case, ').
openings(no_pain, 'I will take note of that, ').
openings(mild_pain, 'I will take note of that, ').
openings(moderate_pain, 'I will take note of that, ').
openings(no_pain, 'I see,if thats the case, ').
openings(mild_pain, 'I see,if thats the case, ').
openings(moderate_pain, 'I see,if thats the case, ').
openings(excruciating_pain, 'Alright,just bear with me a little longer, ').
openings(severe_pain, 'Alright,just bear with me a little longer, ').
openings(excruciating_pain, 'I can see that you are in pain,but to help me diagnose you better, ').
openings(severe_pain, 'I can see that you are in pain,but to help me diagnose you better, ').
openings(excruciating_pain, 'Poor thing,bear with the pain just a little longer, ').
openings(severe_pain, 'Poor thing,bear with the pain just a little longer, ').
openings(excruciating_pain, 'My dear,we will help you ease the pain soon, ').
openings(severe_pain, 'My dear,we will help you ease the pain soon, ').

openings(angry, 'I know that you are feeling angry,take a deep breath and stay calm, I will get your diagnosis in no time, ').
openings(angry, 'I can see that you are angry,take a deep breath and stay calm, I will get your diagnosis in no time, ').
openings(angry, 'I can see your visible anger,just bear with me a moment, ').
openings(upset, 'My dear,I can see that you are visibly upset,I will get you better soon, ').
openings(frustrated, 'My dear,I understand your frustration,I am here for you, ').
openings(frustrated, 'My dear,I see your frustration,I am here for you, ').
openings(frustrated, 'My dear,I understand your frustration,we will get you better soon, ').

% get a random one from openings
opening(OP):- (
	current_predicate(pain/1)->pain(Q),findall(A, openings(Q,A), PainList),
	current_predicate(mood/1)->mood(Y),findall(A, openings(Y,A), MoodList),
	append(PainList,MoodList,OpeningsList)
    ),!,
    random_member(OP, OpeningsList).
opening(OP):- (
	current_predicate(pain/1)->pain(Q),findall(A, openings(Q,A), OpeningsList)
    ),!,
    random_member(OP, OpeningsList).
opening(OP):-
    findall(A, openings(no_pain,A), OpeningsList),
    random_member(OP, OpeningsList).

% asking part of a interrogative sentence
question_starts('do you feel ').
question_start(QS):-question_starts(QS).

% map diagnosis result list to human string
human_diagnose(L, H):-
    length(L, Len),
    (
        Len==0 -> human_illness(no_illness,H);
        (
            convlist([X,Y]>>human_illness(X,Y), L, HL),
            atomic_list_concat(HL, ',OR,', H)
        )
    ).



%% Set of pains and moods
pain_level([excruciating_pain, severe_pain, moderate_pain, mild_pain, no_pain]).
mood_level([angry, upset, frustrated, fatigued, calm]).
symptom_library([high_temperature,physical_pain,insect,swollen,stinging,itching,redness,bumps,skin_irritation,open_wound,numb,bone,limited_mobility,mosquito,body_ache,weakness,nauseous,rash,mild_fever,fever,stomach_ache,diarrhea,sneeze,cough,little_to_no_blood,moderate_blood,alot_blood,chills,sore_throat,head,localized_pain,tightness_head,dizzy,dehydration,sweat,heavy_sweat,exercise,cramps,not_insect]).


illness(allergic_insect_sting, [excruciating_pain,weakness,bumps,localized_pain,sweat,dizzy,chills,mild_fever, physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood,body_ache,nauseous,tightness_head,cramps,fever,high_temperature]).

illness(allergic_insect_sting, [severe_pain,weakness,bumps,localized_pain,sweat,dizzy,chills,mild_fever, physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood,body_ache,nauseous,tightness_head,cramps,fever,high_temperature]).

illness(insect_sting, [moderate_pain,bumps,localized_pain,sweat,dizzy,chills, physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood]).

illness(insect_sting,[mild_pain,bumps,localized_pain,physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood]).


illness(rash, [no_pain,itching,redness,skin_irritation,bumps,little_to_no_blood,rash,not_insect]).


illness(abrasion, [mild_pain,physical_pain,little_to_no_blood,redness,stinging,localized_pain,skin_irritation,not_insect]).


illness(cut, [mild_pain,physical_pain,little_to_no_blood,stinging,open_wound,localized_pain,not_insect]).

illness(moderate_cut, [moderate_pain,physical_pain,moderate_blood,stinging,open_wound,localized_pain,not_insect]).

illness(moderate_cut, [severe_pain,physical_pain,moderate_blood,stinging,open_wound,localized_pain,not_insect]).

illness(deep_cut, [moderate_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,localized_pain,dizzy,sweat,not_insect]).

illness(deep_cut, [severe_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,localized_pain,dizzy,sweat,not_insect]).

illness(deep_cut, [excruciating_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,localized_pain,dizzy,sweat,not_insect]).

illness(injury, [mild_pain,physical_pain,little_to_no_blood,localized_pain,open_wound,swollen,not_insect]).

illness(injury, [moderate_pain,physical_pain,little_to_no_blood,localized_pain,open_wound,swollen,not_insect]).

illness(injury, [moderate_pain,physical_pain,moderate_blood,localized_pain,open_wound,swollen,not_insect]).

illness(severe_injury, [excruciating_pain,physical_pain,alot_blood,localized_pain,open_wound,weakness,limited_mobility,chills,dizzy,sweat,swollen,not_insect]).

illness(severe_injury, [severe_pain,physical_pain,alot_blood,localized_pain,open_wound,weakness,limited_mobility,chills,dizzy,sweat,swollen,not_insect]).

illness(blunt_force_injury, [mild_pain,physical_pain,little_to_no_blood,localized_pain,swollen,redness,not_insect]).
illness(blunt_force_injury, [moderate_pain,physical_pain,little_to_no_blood,localized_pain,swollen,weakness,redness,not_insect,numb]).
illness(blunt_force_injury, [severe_pain,physical_pain,little_to_no_blood,localized_pain,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat,not_insect]).
illness(blunt_force_injury, [excruciating_pain,physical_pain,little_to_no_blood,localized_pain,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat,not_insect]).

illness(fracture, [moderate_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,localized_pain,bone,not_insect]).
illness(fracture, [severe_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,localized_pain,bone,not_insect]).
illness(fracture, [excruciating_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,localized_pain,bone,not_insect]).

illness(sprain, [mild_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,localized_pain,exercise,not_insect]).
illness(sprain, [moderate_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,localized_pain,exercise,not_insect]).

illness(dengue_fever,  [no_pain,high_temperature, mosquito,chills,insect, body_ache,weakness,nauseous,rash,insect,mild_fever,little_to_no_blood,not_insect]).
illness(dengue_fever,  [mild_pain,high_temperature,chills,insect, mosquito,body_ache,weakness,nauseous,rash,insect,fever,little_to_no_blood,not_insect]).
illness(dengue_fever,  [moderate_pain,high_temperature, mosquito,chills,insect, body_ache,weakness,nauseous,rash,insect,fever,sweat,little_to_no_blood,not_insect]).
illness(dengue_fever,  [severe_pain,high_temperature, mosquito,chills,insect, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,little_to_no_blood,not_insect]).
illness(dengue_fever,  [excruciating_pain,high_temperature, mosquito,chills,insect, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,little_to_no_blood,not_insect]).

illness(food_poisoning, [mild_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dehydration,sweat,physical_pain,localized_pain,little_to_no_blood,cramps,not_insect]).
illness(food_poisoning,[moderate_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dizzy,dehydration,sweat,physical_pain,localized_pain,little_to_no_blood,cramps,not_insect]).
illness(food_poisoning,[severe_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dizzy,dehydration,sweat,physical_pain,localized_pain,little_to_no_blood,cramps,not_insect]).
illness(food_poisoning, [excruciating_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dizzy,dehydration,sweat,physical_pain,high_temperature,localized_pain,little_to_no_blood,cramps,not_insect]).

illness(cold, [sneeze, cough, mild_fever, chills, no_pain,weakness,dizzy,sweat,little_to_no_blood,not_insect]).
illness(cold, [sneeze, cough, fever, chills, mild_pain,weakness,body_ache,dizzy,sweat,tightness_head,little_to_no_blood,not_insect]).

illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,no_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,no_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,mild_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,mild_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,moderate_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,moderate_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,severe_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,severe_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,excruciating_pain,little_to_no_blood,not_insect]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,excruciating_pain,little_to_no_blood,not_insect]).

illness(headache, [head, tightness_head,dizzy, mild_pain,physical_pain,localized_pain,little_to_no_blood,not_insect]).
illness(headache, [head, tightness_head,dizzy, moderate_pain,physical_pain,localized_pain,little_to_no_blood,not_insect]).
illness(migraine, [head, tightness_head,dizzy, moderate_pain,physical_pain,localized_pain,little_to_no_blood,not_insect]).
illness(migraine, [head, tightness_head,dizzy, severe_pain,physical_pain,localized_pain,weakness,little_to_no_blood,not_insect]).
illness(migraine, [head, tightness_head,dizzy, excruciating_pain,physical_pain,localized_pain,weakness,little_to_no_blood,not_insect]).

illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,excruciating_pain,little_to_no_blood,not_insect]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,severe_pain,little_to_no_blood,not_insect]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,moderate_pain,little_to_no_blood,not_insect]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,mild_pain,little_to_no_blood,not_insect]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,no_pain,little_to_no_blood,not_insect]).

illness(fever, [chills, sweat, head, weakness, body_ache, dehydration,fever,moderate_pain,little_to_no_blood,not_insect]).
illness(fever, [chills, sweat, head, weakness, body_ache, dehydration,fever,mild_pain,little_to_no_blood,not_insect]).
illness(fever, [chills, sweat, head, weakness, body_ache, dehydration,fever,no_pain,little_to_no_blood,not_insect]).

illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,no_pain,little_to_no_blood,high_temperature,fever,mild_fever,not_insect]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,mild_pain,little_to_no_blood,high_temperature,fever,mild_fever,not_insect]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,moderate_pain,little_to_no_blood,high_temperature,fever,mild_fever,not_insect]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,severe_pain,little_to_no_blood,high_temperature,fever,mild_fever,not_insect]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,excruciating_pain,little_to_no_blood,high_temperature,fever,mild_fever,not_insect]).



?-ask(0).