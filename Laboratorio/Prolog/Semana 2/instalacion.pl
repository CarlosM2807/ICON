% OPERADORES %

:-op(40, xfy, &).
:-op(50, xfy, --->).

% BASE CONOCIMIENTO %


% FUNCIONA BOMBILLA %

light(L)& ok(L) & live(L)---> lit(L).

% CABLE CONECTADO A OTRO %

connected_to(W,W1) & live(W1)---> live(W).

% TENSION EXTERNA %

true ---> live(outside).

% BOMBILLAS %

true ---> light(l1).
true ---> light(l2).

% INTERRUPTORES %

true ---> down(s1).
true ---> up(s2).
true ---> up(s3).

% COMPROBAR QUE TODO VA CORRECTO %

true ---> ok(l1).
true ---> ok(l2).
true ---> ok(s1).
true ---> ok(s2).
true ---> ok(s3).
true ---> ok(cb1).
true ---> ok(cb2).

% CONEXIONES INTERRUPTORES %

up(s2) & ok(s2) ---> connected_to(w0,w1).
down(s2) & ok(s2) ---> connected_to(w0,w2).

up(s3) & ok(s3) ---> connected_to(w4,w3).

up(s1) & ok(s1) ---> connected_to(w1,w3).
down(s1) & ok(s1) ---> connected_to(w2,w3).

% CONEXIONES CB %

ok(cb1) ---> connected_to(w3,w5).
ok(cb2) ---> connected_to(w6,w5).

% CONEXIONES ENCHUFES %

true ---> connected_to(p2,w6).
true ---> connected_to(p1,w3).

% CONEXIONES BOMBILLAS %

true ---> connected_to(l1,w0).
true ---> connected_to(l2,w4).

% CONEXION EXTERNA %

true ---> connected_to(w5,outside).

% METAINTERPRETE %

solve(true):-!.
solve((A & B)) :-!, solve(A), solve(B).
solve(A) :- !, (B ---> A), solve(B).
