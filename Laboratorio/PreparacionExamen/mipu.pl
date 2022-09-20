mueve(q0,a,[z],[z],q0,[a|z],[z]).
mueve(q0,a, H,[z],q0,[a|H],[z]).
mueve(q0,b,H,[z],q1,H,[b|z]).
mueve(q1,b,H,H1,q1,H,[b|H1]).
mueve(q1,c,[a|H],[b|H1],q2,H,H1).
mueve(q2,c,[a|H],[b|H1],q2,H,H1).

transita(q2,[],z,z,qf,[z],[z]).
transita(Qi,[X|Y],Z,Z1,Qf,Zf,Z1f):- mueve(Qi,X,Z,Z1,Qs,Zs,Z1s), transita(Qs,Y,Zs,Z1s,Qf,Zf,Z1f).

valida(Cad,Res):- transita(q0,Cad,[z],[Z1],Qf,_,_), Qf = qf, Res is 1,!. 
