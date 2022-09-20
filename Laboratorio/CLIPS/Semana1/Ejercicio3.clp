(defrule empezar "PresentacionEjercicio"
	(declare (salience 1800)) 
=>
	(printout T "Este es el ejercicio 3 de la entrega" crlf)
	(printout T "¿Que escenario quiere utilizar?" crlf)
	(assert (escenario =  (read T)))
)

(defrule diceerror "Imprime la causa del error"
	(declare (salience -1000))
	(donde fallo ?x)
=>
	(printout T crlf "La causa es: " ?x crlf)
)

(defrule escenario1 "No arranca y Bateria a cero"
	(escenario 1)
=>
	(assert(bateria indicador "cero"))
	(assert(motor comportamiento "no arranca"))
)
(defrule escenario2 "Se para y Combustible a cero"
	(escenario 2)
=>
	(assert(combustible indicador "cero"))
	(assert(motor comportamiento "se para"))
)

(defrule fusible "Inspeccion fusible"
	(fusible inspeccion "roto")
	(motor potencia "desconectada")
=>
	(assert(donde fallo "fusible fundido"))
)

(defrule bateria "Inspeccion bateria"
	(bateria indicador "cero")
	(motor potencia "desconectada")
=>
	(assert(donde fallo "bateria baja"))
)

(defrule deposito "Indicador combustible"
	(combustible indicador "cero")
	(motor combustible "cero")
=>
	(assert(donde fallo "deposito vacio"))
)

(defrule potencia "Estado potencia"
	(motor comportamiento "no arranca")
=>
	(assert(motor potencia "desconectada"))
)

(defrule combustibleNoA "Nivel combustible, si no arranca"
	(motor comportamiento "no arranca")
=>
	(assert(motor combustible "cero"))
)

(defrule combustibleSePara "Nivel combustible, si se para"
	(motor comportamiento "se para")
=>
	(assert(motor combustible "cero"))
)