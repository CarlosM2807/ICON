light(l1).
light(l2).
down(s1).
up(s2).
up(s3).
ok(_).
connected_to(l1,w0).
connected_to(w0,w1):- up(s2), ok(s2).
connected_to(w0,w2):- down(s2), ok(s2).
connected_to(w1,w3):- up(s1), ok(s1).
connected_to(w2,w3):- down(s1), ok(s1).
connected_to(l2,w4).
connected_to(w4,w3):- up(s3), ok(s3).
connected_to(p1,w3).
connected_to(w3,w5):- ok(cb1).
connected_to(p2,w6).
connected_to(w6,w5):- ok(cb2).
connected_to(l1,outside).

lit(L):- light(L),ok(L),live(L).

live(outside).
live(W):- connected_top(W,W1), live(W1).

solve(true):-!.
solve((A , B)):-!, solve(A), solve(B).
solve(A):-!, clause(A,B), solve(B).