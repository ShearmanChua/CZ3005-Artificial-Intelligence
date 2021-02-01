:-['question_answer.pl'].
:-['sentence_bank.pl'].

%%first question
ask(0):-write('Hi, I am Dr Bot, let me help diagnose you today!'), reply_start.

reply_start:-
    nl,write('To help me begin,'),              % opening                    
    question_start(QS),                         % get question start
    nextQuestion(Question),
    human_symptom(Question, Human_question),    % get next question
    write(QS), write(Human_question),write('?'),nl,write('Respond with yes or no:'),read(Response),response(Question,Response),!.

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
    write('you might have: '), write(Human_result),write('.'),nl,write('To ask again, close and reopen Prolog script'),nl,!.

response(Q, A):-
    answer(Q,A),
    (
        current_predicate(ready_to_diagnose/1) -> reply_diagnose;reply_question
    ).


?-ask(0).