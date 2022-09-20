% Base del conocimiento %

:-op(40, xfy, &).
:-op(50, xfy, --->).

solve_traza(true):-!.
solve_traza((A, B)) :-!, solve_traza(A), solve_traza(B).
solve_traza(A):- !,C1 is 0,C1 is C1+1,  write(C1), write(' '), write(A), nl,clause(A,B), solve_traza(B),write('Exit: '), write(A), nl.

a:-b,c.
a:-e,f.
b:-d.
b:-f,h.
c:-e.
d:-h.
e.
f:-g.
g:-c.