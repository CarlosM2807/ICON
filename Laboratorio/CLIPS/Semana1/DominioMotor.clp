;Practica 1 CLIPS
;Alfredo Fernandez Guaza
;Oscar Aragon Esteban

;Mensaje de bienvenida y peticion de escenario al usuario
(defrule inicio "bienvenida"
	(declare (salience 1000)) 
=>
	(printout T crlf "Bienvenidos amigos" crlf)
	(printout T "¿Que escenario quiere utilizar?" crlf)
	(assert (escenario = (read T)))
)

;Imprime la(s) causa(s) del fallo
(defrule imprimir "imprimir"
	(declare (salience -1000))
	(causa fallo ?x)
=>
	(printout t crlf "La causa del fallo es: " ?x crlf)
)

;Escenario 1
(defrule escenario1 "escenario 1"
	(escenario 1)
=>
	(assert(bateria indicador 0))
	(assert(motor comportamiento "no arranca"))
)

;Escenario 2
(defrule escenario2 "escenario 2"
	(escenario 2)
=>
	(assert(combustible indicador 0))
	(assert(motor comportamiento "se para"))
)

;Reglas elaboradas
(defrule fusible "estado del fusible"
	(fusible inspeccion "roto")
	(motor potencia FALSE)
=>
	(assert(causa fallo "fusible-fundido"))
)

(defrule bateria "nivel de la bateria"
	(bateria indicador 0)
	(motor potencia FALSE)
=>
	(assert(causa fallo "bateria-baja"))
)

(defrule deposito "estado del deposito"
	(combustible indicador 0)
	(motor combustible FALSE)
=>
	(assert(causa fallo "deposito-vacio"))
)

(defrule potencia "estado de la potencia"
	(motor comportamiento "no arranca")
=>
	(assert(motor potencia FALSE))
)

(defrule combustibleNoArranca "estado del combustible del motor cuando no arranca"
	(motor comportamiento "no arranca")
=>
	(assert(motor combustible FALSE))
)
(defrule combustibleSePara "estado del combustible del motor cuando se para"
	(motor comportamiento "se para")
=>
	(assert(motor combustible FALSE))
)




