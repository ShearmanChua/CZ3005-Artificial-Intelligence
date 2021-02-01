male(jerry).
male(stuart).
male(warren).
female(kathe).
female(maryalice).
female(ann).
brother(jerry,stuart).
brother(jerry,kather).
brother(peter, warren).
sister(ann, mayalice).
sister(kather,jerry).
parent_of(warren,jerry).
parent_of(maryalice,jerry).
spouse(X,Y) :- parent_of(X,SOME),parent_of(Y,SOME),X \= Y.


