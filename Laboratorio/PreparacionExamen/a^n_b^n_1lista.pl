mueve(q0,a,[z],q0,[a|z]).
mueve(q0,a,H,q0,[a|H]).
mueve(q0,b,[a|H],q1,H).
mueve(q1,b,[a|H],q1,H).

transita(q1,[],[z],qf,[z]).
transita(Qi,[X|Y],Z,Qf,Zf):- mueve(Qi,X,Z,Qs,Zs), transita(Qs,Y,Zs,Qf,Zf).

valida(Ca,Re):- transita(q0,Ca,[z],Qf,_), Qf = qf, Re is 1, !.