:-op(40, xfy, &).
:-op(50, xfy, --->).

solve(true):-!.
solve((A & B)):-!, solve(A), solve(B).
solve(A):-(B ---> A), solve(B).


/* MODELO FONTANERIA*/

/* Presion en la tuberia principal*/
true ---> presion(p1).

/* Reglas que regulan si hay presion en las tuberias*/
presion(p1) & on(t1) ---> presion(p2).
presion(p1) & on(t1) ---> presion(p3).

/* Reglas que regulan cuando hay flujo en la ducha o el lavabo*/
presion(p2) & on(t2) ---> flujo(shower).
presion(p3) & on(t3) ---> flujo(sink).

/* Reglas que regulan cuando hay agua en el lavabo o banera*/
flujo(shower) ---> agua(bath).
flujo(sink) ---> agua(sink).

/* Reglas que regulan si el agua rebosa*/
agua(bath) & taponado(bath) ---> agua(floor).
agua(sink) & taponado(sink) ---> agua(floor).

/* Reglas que regulan los desagues*/
agua(bath) & notaponado(bath) ---> flujo(d2).
agua(sink) & notaponado(sink) ---> flujo(d3).

/* Reglas que regulan el flujo de los desagues*/
flujo(d2) ---> flujo(d1).
flujo(d3) ---> flujo(d1).

/* Situacion conocida de los grifos y tapones*/
true ---> notaponado(bath).
true ---> taponado(sink).
true ---> on(_).
