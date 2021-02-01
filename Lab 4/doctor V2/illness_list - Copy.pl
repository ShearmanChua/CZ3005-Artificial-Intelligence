
%% Set of pains and moods
pain_level([excruciating_pain, severe_pain, moderate_pain, mild_pain, no_pain]).
mood_level([angry, upset, frustrated, fatigued, calm]).
symptom_library([physical_pain,insect,swollen,stinging,sting_area,welt,extreme_redness,numb,difficulty_breathing,skin_reactions,tongue_swell,weak_pulse,nauseous,diarrhea,dizzy,redness,bumps,dry_skin,blister,itching,rash,runny_nose,red_eyes,stomach_ache,little_to_no_blood,moderate_blood,alot_blood,open_wound,no_open_wound,weakness,chills,sweat,limited_mobility,bone,exercise,high_temperature,mosquito,head,tightness_head,body_ache,fever,mild_fever,behind_eyes,sneeze,cough,sore_throat,chest_pain,tenderness_head,fatigue,dehydration,sensitive,heavy_sweat,cramps]).


illness(allergic_bee_sting, [moderate_pain,severe_pain,excruciating_pain,physical_pain,insect,swollen,stinging,sting_area,welt,extreme_redness,numb,fatigue, skin_reactions,difficulty_breathing,tongue_swell,weak_pulse,nauseous,diarrhea,dizzy]).

illness(moderate_bee_sting, [moderate_pain,severe_pain,excruciating_pain,physical_pain,insect,swollen,stinging,sting_area,welt,extreme_redness,redness]).

illness(mild_bee_sting,[mild_pain,moderate_pain,severe_pain,excruciating_pain,physical_pain,insect,swollen,stinging,sting_area,welt]).

illness(allergic_reaction, [moderate_pain,severe_pain,excruciating_pain,physical_pain,runny_nose,red_eyes,difficulty_breathing,skin_reactions,tongue_swell,stomach_ache,diarrhea,weak_pulse,fatigue]).

illness(eczema, [no_pain,itching,redness,dry_skin,bumps,rash,blister]).

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

illness(blunt_force_injury, [mild_pain,physical_pain,little_to_no_blood,swollen,redness,no_open_wound]).

illness(severe_blunt_force_injury, [moderate_pain,physical_pain,little_to_no_blood,swollen,weakness,redness,numb,no_open_wound,weak_pulse]).

illness(severe_blunt_force_injury, [severe_pain,physical_pain,little_to_no_blood,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat,no_open_wound,weak_pulse]).

illness(severe_blunt_force_injury, [excruciating_pain,physical_pain,little_to_no_blood,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat,no_open_wound,weak_pulse]).

illness(fracture, [moderate_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,bone,no_open_wound,weak_pulse]).

illness(fracture, [severe_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,bone,no_open_wound,weak_pulse]).

illness(fracture, [excruciating_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,bone,no_open_wound,weak_pulse]).

illness(sprain, [mild_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,exercise,no_open_wound]).

illness(sprain, [moderate_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,exercise,no_open_wound]).

illness(dengue_fever,  [no_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,head,tightness_head,behind_eyes,fever,fatigue]).

illness(dengue_fever,  [mild_pain,high_temperature,chills,weak_pulse, mosquito,body_ache,weakness,nauseous,rash,insect,fever,head,tightness_head,behind_eyes,fatigue]).

illness(dengue_fever,  [moderate_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,fever,sweat,head,tightness_head,behind_eyes,fatigue]).

illness(dengue_fever,  [severe_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,head,tightness_head,behind_eyes,fatigue]).

illness(dengue_fever,  [excruciating_pain,high_temperature, mosquito,chills,weak_pulse, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,head,tightness_head,behind_eyes,fatigue]).

illness(food_poisoning, [mild_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound]).

illness(food_poisoning,[moderate_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound]).

illness(food_poisoning,[severe_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound]).

illness(food_poisoning, [excruciating_pain,physical_pain,weak_pulse,nauseous,diarrhea,dizzy,stomach_ache,weakness,chills,sweat,fever,mild_fever,dehydration,head,tightness_head,fatigue,no_open_wound]).

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





