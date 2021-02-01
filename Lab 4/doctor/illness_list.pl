
%% Set of pains and moods
pain_level([excruciating_pain, severe_pain, moderate_pain, mild_pain, no_pain]).
mood_level([angry, upset, frustrated, fatigued, calm]).
symptom_library([high_temperature,physical_pain,insect,swollen,stinging,itching,redness,bumps,skin_irritation,open_wound,numb,bone,limited_mobility,mosquito,body_ache,weakness,nauseous,rash,mild_fever,fever,stomach_ache,diarrhea,sneeze,cough,little_to_no_blood,moderate_blood,alot_blood,chills,sore_throat,head,localized_pain,tightness_head,dizzy,dehydration,sweat,heavy_sweat,exercise,cramps]).


illness(allergic_insect_sting, [excruciating_pain,weakness,bumps,localized_pain,sweat,dizzy,chills,mild_fever, physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood,body_ache,nauseous,tightness_head,cramps,fever,high_temperature]).

illness(allergic_insect_sting, [severe_pain,weakness,bumps,localized_pain,sweat,dizzy,chills,mild_fever, physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood,body_ache,nauseous,tightness_head,cramps,fever,high_temperature]).

illness(insect_sting, [moderate_pain,bumps,localized_pain,sweat,dizzy,chills, physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood]).

illness(insect_sting,[mild_pain,bumps,localized_pain,physical_pain,insect,swollen,stinging,redness,skin_irritation,numb,rash,little_to_no_blood]).


illness(rash, [no_pain,itching,redness,skin_irritation,bumps,little_to_no_blood,rash]).


illness(abrasion, [mild_pain,physical_pain,little_to_no_blood,redness,stinging,localized_pain,skin_irritation]).


illness(cut, [mild_pain,physical_pain,little_to_no_blood,stinging,open_wound,localized_pain]).

illness(moderate_cut, [moderate_pain,physical_pain,moderate_blood,stinging,open_wound,localized_pain]).

illness(moderate_cut, [severe_pain,physical_pain,moderate_blood,stinging,open_wound,localized_pain]).

illness(deep_cut, [moderate_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,localized_pain,dizzy,sweat]).

illness(deep_cut, [severe_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,localized_pain,dizzy,sweat]).

illness(deep_cut, [excruciating_pain,physical_pain,alot_blood,stinging,open_wound,weakness,chills,localized_pain,dizzy,sweat]).

illness(injury, [mild_pain,physical_pain,little_to_no_blood,localized_pain,open_wound,swollen]).

illness(injury, [moderate_pain,physical_pain,little_to_no_blood,localized_pain,open_wound,swollen]).

illness(injury, [moderate_pain,physical_pain,moderate_blood,localized_pain,open_wound,swollen]).

illness(severe_injury, [excruciating_pain,physical_pain,alot_blood,localized_pain,open_wound,weakness,limited_mobility,chills,dizzy,sweat,swollen]).

illness(severe_injury, [severe_pain,physical_pain,alot_blood,localized_pain,open_wound,weakness,limited_mobility,chills,dizzy,sweat,swollen]).

illness(blunt_force_injury, [mild_pain,physical_pain,little_to_no_blood,localized_pain,swollen,redness]).
illness(blunt_force_injury, [moderate_pain,physical_pain,little_to_no_blood,localized_pain,swollen,weakness,redness,numb]).
illness(blunt_force_injury, [severe_pain,physical_pain,little_to_no_blood,localized_pain,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat]).
illness(blunt_force_injury, [excruciating_pain,physical_pain,little_to_no_blood,localized_pain,swollen,weakness,redness,numb,limited_mobility,chills,dizzy,sweat]).

illness(fracture, [moderate_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,localized_pain,bone]).
illness(fracture, [severe_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,localized_pain,bone]).
illness(fracture, [excruciating_pain,physical_pain,little_to_no_blood,swollen,numb,limited_mobility,redness,weakness,chills,dizzy,sweat,localized_pain,bone]).

illness(sprain, [mild_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,localized_pain,exercise]).
illness(sprain, [moderate_pain,physical_pain,little_to_no_blood,swollen,limited_mobility,redness,localized_pain,exercise]).

illness(dengue_fever,  [no_pain,high_temperature, mosquito,chills, body_ache,weakness,nauseous,rash,insect,mild_fever,little_to_no_blood]).
illness(dengue_fever,  [mild_pain,high_temperature,chills, mosquito,body_ache,weakness,nauseous,rash,insect,fever,little_to_no_blood]).
illness(dengue_fever,  [moderate_pain,high_temperature, mosquito,chills, body_ache,weakness,nauseous,rash,insect,fever,sweat,little_to_no_blood]).
illness(dengue_fever,  [severe_pain,high_temperature, mosquito,chills, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,little_to_no_blood]).
illness(dengue_fever,  [excruciating_pain,high_temperature, mosquito,chills, body_ache,weakness,nauseous,rash,insect,fever,dizzy,sweat,little_to_no_blood]).

illness(food_poisoning, [mild_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dehydration,sweat,physical_pain,localized_pain,little_to_no_blood,cramps]).
illness(food_poisoning,[moderate_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dizzy,dehydration,sweat,physical_pain,localized_pain,little_to_no_blood,cramps]).
illness(food_poisoning,[severe_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dizzy,dehydration,sweat,physical_pain,localized_pain,little_to_no_blood,cramps]).
illness(food_poisoning, [excruciating_pain,mild_fever,fever,stomach_ache,nauseous,diarrhea,weakness,chills,dizzy,dehydration,sweat,physical_pain,high_temperature,localized_pain,little_to_no_blood,cramps]).

illness(cold, [sneeze, cough, mild_fever, chills, no_pain,weakness,dizzy,sweat,little_to_no_blood]).
illness(cold, [sneeze, cough, fever, chills, mild_pain,weakness,body_ache,dizzy,sweat,tightness_head,little_to_no_blood]).

illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,no_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,no_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,mild_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,mild_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,moderate_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,moderate_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,severe_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,severe_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, fever, chills, sore_throat,body_ache,high_temperature,weakness,tightness_head,dizzy,sweat,excruciating_pain,little_to_no_blood]).
illness(flu, [sneeze, cough, mild_fever, chills, sore_throat,body_ache,tightness_head,sweat,excruciating_pain,little_to_no_blood]).

illness(headache, [head, tightness_head,dizzy, mild_pain,physical_pain,localized_pain,little_to_no_blood]).
illness(headache, [head, tightness_head,dizzy, moderate_pain,physical_pain,localized_pain,little_to_no_blood]).
illness(migraine, [head, tightness_head,dizzy, moderate_pain,physical_pain,localized_pain,little_to_no_blood]).
illness(migraine, [head, tightness_head,dizzy, severe_pain,physical_pain,localized_pain,weakness,little_to_no_blood]).
illness(migraine, [head, tightness_head,dizzy, excruciating_pain,physical_pain,localized_pain,weakness,little_to_no_blood]).

illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,excruciating_pain,little_to_no_blood]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,severe_pain,little_to_no_blood]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,moderate_pain,little_to_no_blood]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,mild_pain,little_to_no_blood]).
illness(viral_fever, [high_temperature,chills, dehydration, head, weakness, body_ache,nauseous,fever,sneeze,cough,tightness_head,dizzy,sweat,no_pain,little_to_no_blood]).

illness(fever, [chills, sweat, head, weakness, body_ache, dehydration,fever,moderate_pain,little_to_no_blood]).
illness(fever, [chills, sweat, head, weakness, body_ache, dehydration,fever,mild_pain,little_to_no_blood]).
illness(fever, [chills, sweat, head, weakness, body_ache, dehydration,fever,no_pain,little_to_no_blood]).

illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,no_pain,little_to_no_blood,high_temperature,fever,mild_fever]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,mild_pain,little_to_no_blood,high_temperature,fever,mild_fever]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,moderate_pain,little_to_no_blood,high_temperature,fever,mild_fever]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,severe_pain,little_to_no_blood,high_temperature,fever,mild_fever]).
illness(heat_exhausion, [exercise, heavy_sweat, weakness, chills, dehydration,cramps,dizzy,excruciating_pain,little_to_no_blood,high_temperature,fever,mild_fever]).



