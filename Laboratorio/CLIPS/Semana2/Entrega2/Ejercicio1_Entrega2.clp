(deftemplate oav-u "Hechos Univaluados"
	(slot objeto (type SYMBOL))
	(slot atributo (type SYMBOL))
	(slot valor)
)

(defrule hechos_univaluados "Garantiza la semantica de los tripletes univaluados"
	(declare (salience 10000))
	?f <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
	?g <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
	(test (neq ?f ?g))
	=>
	(retract ?g)
)

(deffacts edad_hombre
	(oav-u (objeto Juan)(atributo edad)(valor 35))
	(oav-u (objeto Juan)(atributo edad)(valor 28))
	(oav-u (objeto Juan)(atributo edad)(valor 42))
)