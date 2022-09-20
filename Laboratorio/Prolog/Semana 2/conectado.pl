:-op(40, xfy, &).
:-op(50, xfy, --->).
solve(true):-!.
solve((A & B)) :-!, solve(A), solve(B).
solve(A) :- !, (B ---> A), solve(B).
true ---> conectado(w2, w1).
true ---> conectado(w3, w2).
true ---> valor(w1, 1).
conectado(W,V) & valor(V,X) ---> valor(W,X).