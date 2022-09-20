mueve(q0,x,[z],q0,[x|z]).
mueve(q0,x,H,q0,[x|H]).
mueve(q0,e,H,q1,H).
mueve(q1,e,H,q1,H).
mueve(q1,x,[x|H],q2,H).
mueve(q2,x,[x|H],q2,H).

transita(q2,[],z,qf,[z]).

transita(Qi,[X|Y],Z,Qf,Zf):- mueve(Qi,X,Z,Qs,Zs), transita(Qs,Y,Zs,Qf,Zf).

valida(Cad,Res):- transita(q0,Cad,[z],Qf,_), Qf = qf, Res is 1,!. 