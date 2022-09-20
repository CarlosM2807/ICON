transiciones(q0,b,q1).
transiciones(q0,a,q2).
transiciones(q1,a,q0).
transiciones(q1,b,q3).
transiciones(q2,a,q2).
transiciones(q2,b,q3).
transiciones(q3,b,q3).
transiciones(q3,a,q0).

transita(X,[],X):-!.
transita(X,[A|B],Y):-transiciones(X,A,P),transita(P,B,Y),!.
acepta(X):- transita(q0,X,Y), y=q1.

