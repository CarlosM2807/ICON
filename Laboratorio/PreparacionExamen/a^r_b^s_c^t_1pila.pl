mueve(q0,a,z,q0,[a|z]).
mueve(q0,a,H,q0,[a|H]).
mueve(q0,b,[a|H],q1,H).
mueve(q1,b,[a|H],q1,H).
mueve(q1,b,[z],q2,[b|z]).
mueve(q2,b,H,q2,[b|H]).
mueve(q2,c,[b|H],q3,H).
mueve(q3,c,[b|H],q3,H).

transita(q3,[],z,qf,[z]).
transita(Qi,[X|Y],Z,Qf,Zf):- mueve(Qi,X,Z,Qs,Zs), transita(Qs,Y,Zs,Qf,Zf).

valida(Ca,Re):- transita(q0,Ca,[z],Qf,_), Qf = qf, Re is 1,!.