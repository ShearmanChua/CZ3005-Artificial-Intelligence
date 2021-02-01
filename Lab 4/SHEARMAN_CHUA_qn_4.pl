:- dynamic answered/1, have_symptom/1, pain/1, mood/1, ready_to_diagnose/1.

%%first question
ask(0):-nl,write('Hi, I am Dr Bot, let me help diagnose you today!'), reply_start.

%%first reply
reply_start:-
    nl,write('To help me begin,'),              % opening                    
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    write(QS), write(Human_question),write('?'),nl,write('Respond with yes. or no. (or press q to abort):'),read(Response),response(Question,Response),!.

%%function to ask user questions
reply_question:-
    opening(OP),                                % get Opening
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    write(OP),write(QS), write(Human_question),write('?'),nl,write('Respond with yes. or no. (or press q to abort): '),read(Response),response(Question,Response),!.

%% reply the diagnosis result page
reply_diagnose:-
    nl,write('With the answers you have provided me,'),                            % get Opening
    diagnose(X),
    sort(X, Result),
    human_diagnose(Result, Human_result),    % get diagnosis Result
    write('you might have: '), write(Human_result),write('.'),nl,retractall(answered(_)),retractall(have_symptom(_)),retractall(ready_to_diagnose(_)),retractall(pain(_)),retractall(mood(_)),ask(0),!.

%%handle user response
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

% Interface for answering question, eg. query answer(cough, yes) in prolog will tell the system you have cough
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

%% helper function for making diagnosis, determine whether one illness is satisfied
diagnose_h(X):-
    findall(A, have_symptom(A), Symptom_list),
    illness(X, L), 
    is_subset(Symptom_list,L).

% Interface for making diagnosis, collect all satisfied illnesses.
diagnose(L):-
    findall(A, diagnose_h(A), L).


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


human_symptom(physical_pain       ,'that you have localized external physical pain(e.g. abdominal, arm, head, stomach), excluding headaches and full body aches ').

human_symptom(insect       ,'that you have been stung by an insect or have been in an area around insects ').

human_symptom(swollen             ,'that there is swelling on affected area ').

human_symptom(stinging             ,'a stinging sensation on affected area ').

human_symptom(sting_area             ,'an instant, sharp burning pain at the pain site(if no open wound) ').

human_symptom(welt             ,'that there is a red welt at the pain area(if no open wound) ').

human_symptom(extreme_redness             ,'there is extreme redness at affected area(deep red colour on skin) ').

human_symptom(numb             ,'that there is localized numbness ').

human_symptom(skin_reactions             ,'there are skin reactions, including hives and itching and flushed or pale skin ').

human_symptom(difficulty_breathing             ,'that you have difficulty breathing ').

human_symptom(tongue_swell             ,'that you have swelling of the throat and tongue ').

human_symptom(weak_pulse             ,'that you have a weak, rapid pulse ').

human_symptom(nauseous              ,'that you are nauseous ').

human_symptom(diarrhea              ,'that you have diarrhea in the past few days ').

human_symptom(dizzy             ,'that you are dizzy ').

human_symptom(redness             ,'there is redness and no bleeding on affected area ').

human_symptom(bumps             ,'there are multiple small bumps on affected area ').

human_symptom(dry_skin             ,'there is dry, scaly, or crusted skin that might become thick and leathery from long-term scratching ').

human_symptom(blister             ,'there are formation of small, fluid-filled blisters that might ooze when scratched ').

human_symptom(itching             ,'there is itching on the skin ').

human_symptom(rash              ,'that you have a rash on your skin ').

human_symptom(runny_nose              ,'that you have a sneezing and an itchy, runny or blocked nose ').

human_symptom(red_eyes              ,'that you have itchy, red, watering eyes ').

human_symptom(stomach_ache             ,'that you have a stomach ache ').

human_symptom(little_to_no_blood             ,'little to no bleeding at affected area ').

human_symptom(moderate_blood             ,'that you are bleeding moderately at affected area ').

human_symptom(alot_blood             ,'that you are bleeding severely at affected area ').

human_symptom(open_wound             ,'that there is an open wound on skin ').

human_symptom(no_open_wound             ,'that there is NO open wound on skin(reply yes only if you have localized external physical pain, excluding headaches and full body aches) ').

human_symptom(weakness              ,'that you are more weak and have lesser energy than usual ').

human_symptom(chills             ,'that you are having chills ').

human_symptom(sweat             ,'that you have cold sweat ').

human_symptom(limited_mobility             ,'that there is limited mobility in your limbs ').

human_symptom(bone             ,'that there you bone is out of place or pain when touched ').

human_symptom(exercise             ,'that you have been exercising streneously ').

human_symptom(high_temperature       ,'that you have high temperature(above 38.5 degree celcius) ').

human_symptom(mosquito             ,'that you have been bitten by a mosquito recently or live in a moquito infested area ').

human_symptom(head             ,'that you are having localized pain around your head (not due to external injuries) ').

human_symptom(tightness_head             ,'that you are having tightness around your head (not due to external injuries) ').

human_symptom(body_ache              ,'that you have any body ache(full body) ').

human_symptom(fever             ,'that you have a fever(reply no if is mild fever) ').

human_symptom(mild_fever             ,'that you have a mild fever ').

human_symptom(behind_eyes             ,'that you have pain behind the eyes ').

human_symptom(sneeze            ,'that you have been sneezing frequently as of recent ').

human_symptom(cough             ,'that you have a cough in the past few days ').

human_symptom(sore_throat             ,'that you are having a sore throat ').

human_symptom(chest_pain             ,'that you are having persistent pain or pressure in the chest or abdomen ').

human_symptom(tenderness_head             ,'that you are having tenderness on your scalp, neck and shoulder muscles (with no fever, mild fever) ').

human_symptom(fatigue             ,'that you are fatigued ').

human_symptom(dehydration             ,'that you are dehydrated ').

human_symptom(sensitive             ,'that you are sensitive to light, sound, or smell ').

human_symptom(heavy_sweat             ,'that you are sweating heavily due to strenous activity within the past 30 minutes ').

human_symptom(cramps             ,'that you are having muscle cramps ').

human_symptom(bruising             ,'that you have localized bruising on the skin ').

human_symptom(allergen             ,'that you have come into contact with unfamiliar plants, or ate food not usually eaten by you, or exposed to dust or pollen, or ate food that may possibily contain allergens like peanut, prawns etc, ').


human_illness(allergic_bee_sting              ,'an allergic reaction to bee sting (seek medical attention immediately)').

human_illness(moderate_bee_sting              ,'a moderate reaction to bee sting (do get some medication for it, seek medical attention if no improvements or if symptoms get worse)').

human_illness(mild_bee_sting              ,'a mild bee sting (do get some medication for it, seek medical attention if no improvements or if symptoms get worse)').

human_illness(eczema              ,'an eczema(do get some medication for it and do not scratch affected area, seek medical attention if no improvements or if symptoms get worse)').

human_illness(mild_allergic_reaction              ,'a mild allergic reaction (do seek medical attention)').

human_illness(allergic_reaction              ,'an allergic reaction (seek medical attention immediately)').

human_illness(cut              ,'a small cut, you will be fine(do get some medication for it)').

human_illness(moderate_cut              ,'a moderate cut(disinfect wound and put pressure and bandage the affected area, get medical attention if bleeding do not stop)').

human_illness(deep_cut              ,'a deep cut(seek medical attention immediately)').

human_illness(injury              ,'an injury(if symptoms worsen, get medical attention)').

human_illness(severe_injury              ,'a severe injury(seek medical attention immediately)').

human_illness(blunt_force_injury              ,'a blunt force injury(seek medical attention if conditions worsen)').

human_illness(severe_blunt_force_injury              ,'a severe blunt force injury(advised to seek medical attention)').

human_illness(fracture              ,'a fracture(seek medical attention immediately, isolated affected limb and restrict movement)').

human_illness(sprain              ,'a sprain(ice and rest affected area, seek medical attention if conditions do not improve)').

human_illness(dengue_fever              ,'dengue fever(seek medical attention immediately)').

human_illness(food_poisoning    ,'food poisoning(rest and hydrate well, seek medical attention if conditions worsen)').

human_illness(cold              ,'a cold(stay at home and avoid going to crowded areas in light of covid-19, seek medical attention if high fever or symptoms worsen)').

human_illness(flu              ,'a flu(stay at home and avoid going to crowded areas in light of covid-19, seek medical attention if high fever or symptoms worsen)').

human_illness(severe_flu       ,'a severe flu(seek medical attention immediately and avoid going to crowded areas in light of covid-19)').

human_illness(viral_fever              ,'a viral fever(seek medical attention immediately and avoid going to crowded areas in light of covid-19)').

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
openings(upset, 'Sweetie,I can see that you are visibly upset,I am here to help, ').
openings(upset, 'Sweetie,I can see that you are visibly upset,cheer up, we will get you beter soon, ').
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
            (Len>4 -> nl, write('there is not enough symptoms to make accurate diagnosis,please try to be more specific, ')              ;true),
            convlist([X,Y]>>human_illness(X,Y), L, HL),
            atomic_list_concat(HL, ',OR,', H)
        )
    ).



%% Set of pains and moods
pain_level([excruciating_pain, severe_pain, moderate_pain, mild_pain, no_pain]).
mood_level([angry, upset, frustrated, fatigued, calm]).
symptom_library([physical_pain,insect,swollen,stinging,sting_area,welt,extreme_redness,numb,difficulty_breathing,skin_reactions,tongue_swell,weak_pulse,nauseous,diarrhea,dizzy,redness,bumps,dry_skin,blister,itching,rash,runny_nose,red_eyes,stomach_ache,little_to_no_blood,moderate_blood,alot_blood,open_wound,no_open_wound,weakness,chills,sweat,limited_mobility,bone,exercise,high_temperature,mosquito,head,tightness_head,body_ache,fever,mild_fever,behind_eyes,sneeze,cough,sore_throat,chest_pain,tenderness_head,fatigue,dehydration,sensitive,heavy_sweat,cramps,bruising,allergen]).


illness(allergic_bee_sting, [severe_pain,excruciating_pain,physical_pain,insect,swollen,stinging,sting_area,welt,extreme_redness,numb,fatigue,little_to_no_blood,head,tightness_head,itching, skin_reactions,difficulty_breathing,tongue_swell,weak_pulse,nauseous,diarrhea,dizzy,redness,no_open_wound,weakness,sweat,rash,chills,bumps]).

illness(moderate_bee_sting, [moderate_pain,severe_pain,excruciating_pain,physical_pain,insect,swollen,stinging,sting_area,welt,extreme_redness,redness,numb,little_to_no_blood,no_open_wound]).

illness(mild_bee_sting,[mild_pain,physical_pain,insect,swollen,stinging,sting_area,welt,numb,extreme_redness,redness,little_to_no_blood,no_open_wound]).

illness(mild_allergic_reaction, [no_pain,mild_pain,physical_pain,runny_nose,red_eyes,skin_reactions,tongue_swell,stomach_ache,diarrhea,weak_pulse,itching,no_open_wound,little_to_no_blood,rash,nauseous,allergen,redness,bumps]).

illness(allergic_reaction, [moderate_pain,severe_pain,excruciating_pain,physical_pain,runny_nose,red_eyes,difficulty_breathing,skin_reactions,tongue_swell,stomach_ache,diarrhea,weak_pulse,fatigue,head,tightness_head,tenderness_head,itching,no_open_wound,little_to_no_blood,rash,nauseous,chills,sweat,dizzy,allergen,redness,bumps]).

illness(eczema, [no_pain,itching,redness,dry_skin,bumps,rash,blister,little_to_no_blood]).

illness(cut,[mild_pain,physical_pain,little_to_no_blood,stinging,open_wound]).

illness(moderate_cut, [moderate_pain,physical_pain,moderate_blood,stinging,open_wound]).

illness(moderate_cut, [severe_pain,physical_pain,moderate_blood,stinging,open_wound]).

illness(deep_cut, [moderate_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,dizzy,sweat,weak_pulse]).

illness(deep_cut, [severe_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,dizzy,sweat,weak_pulse]).

illness(deep_cut, [excruciating_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,dizzy,sweat,weak_pulse]).

illness(injury, [mild_pain,physical_pain,little_to_no_blood,open_wound,swollen,numb]).

illness(injury, [moderate_pain,physical_pain,little_to_no_blood,open_wound,swollen,numb]).

illness(injury, [moderate_pain,physical_pain,moderate_blood,open_wound,swollen,numb]).

illness(severe_injury, [excruciating_pain,physical_pain,alot_blood,open_wound,weakness,limited_mobility,chills,dizzy,sweat,swollen,numb,weak_pulse]).

illness(severe_injury, [severe_pain,physical_pain,alot_blood,open_wound,weakness,limited_mobility,chills,dizzy,sweat,swollen,numb,weak_pulse]).

illness(blunt_force_injury, [mild_pain,physical_pain,little_to_no_blood,swollen,redness,no_open_wound,bruising]).

illness(severe_blunt_force_injury, [moderate_pain,physical_pain,little_to_no_blood,swollen,weakness,redness,numb,no_open_wound,weak_pulse,bruising]).

illness(severe_blunt_force_injury, [severe_pain,physical_pain,little_to_no_blood,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat,no_open_wound,weak_pulse,bruising]).

illness(severe_blunt_force_injury, [excruciating_pain,physical_pain,little_to_no_blood,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat,no_open_wound,weak_pulse,bruising]).

illness(fracture, [moderate_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,bone,no_open_wound,weak_pulse,bruising]).

illness(fracture, [severe_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,bone,no_open_wound,weak_pulse,bruising]).

illness(fracture, [excruciating_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,bone,no_open_wound,weak_pulse,bruising]).

illness(sprain, [mild_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,exercise,no_open_wound]).

illness(sprain, [moderate_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,exercise,no_open_wound]).

illness(dengue_fever,  [no_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,head,tightness_head,behind_eyes,fever,fatigue]).

illness(dengue_fever,  [mild_pain,high_temperature,chills,weak_pulse, mosquito,body_ache,weakness,nauseous,rash,insect,fever,head,tightness_head,behind_eyes,fatigue]).

illness(dengue_fever,  [moderate_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,fever,sweat,head,tightness_head,behind_eyes,fatigue]).

illness(dengue_fever,  [severe_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,head,tightness_head,behind_eyes,fatigue]).

illness(dengue_fever,  [excruciating_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,head,tightness_head,behind_eyes,fatigue]).

illness(food_poisoning, [mild_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound,little_to_no_blood]).

illness(food_poisoning,[moderate_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound,little_to_no_blood]).

illness(food_poisoning,[severe_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound,little_to_no_blood]).

illness(food_poisoning, [excruciating_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound,little_to_no_blood]).

illness(cold, [no_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,fatigue]).

illness(cold, [mild_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,fatigue]).

illness(cold, [moderate_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,fatigue]).

illness(flu, [no_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,fatigue]).

illness(flu, [mild_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,fatigue]).

illness(flu, [moderate_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,fatigue]).

illness(severe_flu, [moderate_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,difficulty_breathing,chest_pain,fatigue,behind_eyes]).

illness(severe_flu, [severe_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,difficulty_breathing,chest_pain,fatigue,behind_eyes]).

illness(severe_flu, [excruciating_pain,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,difficulty_breathing,chest_pain,fatigue,behind_eyes]).

illness(headache, [mild_pain,head,tightness_head,dizzy,behind_eyes,tenderness_head]).

illness(headache, [moderate_pain,head,tightness_head,dizzy,behind_eyes,tenderness_head]).

illness(headache, [severe_pain,head,tightness_head,dizzy,behind_eyes,tenderness_head]).

illness(migraine, [moderate_pain,head,tightness_head,dizzy,behind_eyes,tenderness_head,fatigue,dehydration,sensitive]).

illness(migraine, [severe_pain,head,tightness_head,dizzy,behind_eyes,tenderness_head,fatigue,dehydration,sensitive]).

illness(migraine, [excruciating_pain,head,tightness_head,dizzy,behind_eyes,tenderness_head,fatigue,dehydration,sensitive]).

illness(viral_fever, [moderate_pain,high_temperature,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,fatigue,behind_eyes,difficulty_breathing,chest_pain]).

illness(viral_fever, [severe_pain,high_temperature,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,fatigue,behind_eyes,difficulty_breathing,chest_pain]).

illness(viral_fever, [excruciating_pain,high_temperature,runny_nose,sore_throat,cough,sneeze,fever,mild_fever,weak_pulse,dizzy,weakness,chills,sweat,body_ache,head,tightness_head,fatigue,behind_eyes,difficulty_breathing,chest_pain]).

illness(heat_exhausion, [no_pain,physical_pain,difficulty_breathing,weak_pulse,nauseous,dizzy,weakness,chills,sweat,exercise,head,tightness_head,body_ache,fever,mild_fever,fatigue,heavy_sweat,cramps]).

illness(heat_exhausion, [mild_pain,physical_pain,difficulty_breathing,weak_pulse,nauseous,dizzy,weakness,chills,sweat,exercise,head,tightness_head,body_ache,fever,mild_fever,fatigue,heavy_sweat,cramps]).

illness(heat_exhausion, [moderate_pain,physical_pain,difficulty_breathing,weak_pulse,nauseous,dizzy,weakness,chills,sweat,exercise,head,tightness_head,body_ache,fever,mild_fever,fatigue,heavy_sweat,cramps]).

illness(heat_exhausion, [severe_pain,physical_pain,difficulty_breathing,weak_pulse,nauseous,dizzy,weakness,chills,sweat,exercise,head,tightness_head,body_ache,fever,mild_fever,fatigue,heavy_sweat,cramps]).

illness(heat_exhausion, [excruciating_pain,physical_pain,difficulty_breathing,weak_pulse,nauseous,dizzy,weakness,chills,sweat,exercise,head,tightness_head,body_ache,fever,mild_fever,fatigue,heavy_sweat,cramps]).


?-ask(0).