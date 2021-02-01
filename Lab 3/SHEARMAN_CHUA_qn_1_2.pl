competitor(sumsum,appy).
develop(sumsum,galactica-s3).
smart_phone_technology(galactica-s3).
steal(stevey,galactica-s3,sumsum).
boss(stevey).
business(X):- smart_phone_technology(X).
rival(X) :- competitor(X,appy).
unethical(X):- boss(X),steal(X,Y,Z),business(Y),rival(Z).
