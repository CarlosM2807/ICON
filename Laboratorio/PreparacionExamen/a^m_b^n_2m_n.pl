mueve(q0,a,[z],q0,[a,a|z]).
mueve(q0,a,H,q0,[a,a|H]).
mueve(q0,b,[a|H],q1,H).
mueve(q1,b,[a|H],q1,H).

transita(q1,[],z,qf,[z]).

transita(Qi,[X|Y],Z,Qf,Zf):- mueve(Qi,X,Z,Qs,Zs), transita(Qs,Y,Zs,Qf,Zf).

valida(Cad,Res):- transita(q0,Cad,[z],Qf,_), Qf=qf, Res is 1,!.
