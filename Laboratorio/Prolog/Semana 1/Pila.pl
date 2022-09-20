palindromo(X):- name(X,L),longitud(L,T), W is T//2, pila(L,W,M), comparar(L,M).
longitud([],0).
longitud([L|L1],T):- longitud(L1,T1), T is T1+1.
pila([_|Xs],0,M).
pila([X|Xj],W,[M|Ms]):- W is W1-1, pila(Xj,W1,X).
comparar([],[]):- true.
comparar([L|Ls],[M|Ms]):- L =:= M, comparar(Ls,Ms).