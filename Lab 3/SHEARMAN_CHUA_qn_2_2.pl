queen(elizabeth).
monarch(elizabeth).
prince(charles).
prince(andrew).
prince(edward).
princess(ann).
offspring(elizabeth,charles).
offspring(elizabeth,ann).
offspring(elizabeth,andrew).
offspring(elizabeth,edward).

older(charles,ann).
older(ann,andrew).
older(andrew,edward).

male_heir(X,Y):-prince(Y),offspring(X,Y).
female_heir(X,Y):-princess(Y),offspring(X,Y).

is_older(X,Y):-older(X,Y).
is_older(X,Y):-older(X,Z),is_older(Z,Y).

birth_order([A|B],Sorted):-birth_order(B,SortedTail),insert(A,SortedTail,Sorted).
birth_order([],[]).

insert(A,[B|C],[B|D]):-not(is_older(A,B)),insert(A,C,D).
insert(A,C,[A|C]).

succession_list_new(X,SuccessionList):- findall(Y,offspring(X,Y),RoyalLine),
                                    birth_order(RoyalLine,SuccessionList).

