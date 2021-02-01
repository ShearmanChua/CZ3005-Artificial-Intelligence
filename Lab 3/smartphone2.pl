competitor(sumsum,appy).
competitor(mokia,sumsum).
develop(sumsum,galactica-s3).
develop(mokia,mokia-1).
smart_phone_technology(galactica-s3).
smart_phone_technology(mokia-1).
steal(stevey,mokia-1,mokia).
boss(stevey).
business(X):- smart_phone_technology(X).
rival(X) :- competitor(X,appy).
unethical(X):- boss(X),steal(X,Y,Z),business(Y),rival(Z).
