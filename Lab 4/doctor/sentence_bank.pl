:-['illness_list.pl'].
:-['question_answer.pl'].

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