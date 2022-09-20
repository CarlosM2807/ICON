(deftemplate oav-u "Plantilla Hechos univaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)
(deftemplate oav-m "Plantilla Hechos multivaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(multislot valor)
)

(defrule garantizar-univaluados
    (declare (salience 10000))
    ?x <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v1))
    ?y <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v2))
    (test (> (fact-index ?x) (fact-index ?y)))
=>
(retract ?y)) 

(defrule pideEscenario
	;alta prioridad porque es lo primero que se debe hacer
	(declare (salience 5000))
=>
	(printout T "Introduce el escenario 1 o 2 o 3" crlf)
	(assert (escenario = (read T)))
)

(defrule movil "Datos del movil"
 (escenario 1)
=>
 (assert(oav-u (objeto movil)(atributo antiguedad)(valor 14)))
 (assert(oav-u (objeto movil)(atributo sop)(valor actual)))
 (assert(oav-m (objeto movil)(atributo fallos)(valor se_apaga_ines)))
)

(defrule tablet "Datos de la tablet"
 (escenario 2)
=>
 (assert(oav-u (objeto tablet)(atributo antiguedad)(valor 20)))
 (assert(oav-u (objeto tablet)(atributo sop)(valor actual)))
 (assert(oav-m (objeto tablet)(atributo fallos)(valor error_arranque)))
 (assert(oav-m (objeto tablet)(atributo fallos)(valor ficheros_corr)))
)

(defrule portatil "Datos del portatil"
 (escenario 3)
=>
 (assert(oav-u (objeto portatil)(atributo antiguedad)(valor 30)))
 (assert(oav-u (objeto portatil)(atributo sop)(valor no_actual)))
 (assert(oav-m (objeto portatil)(atributo fallos)(valor no_enciende)))
)

(defrule servicioTec1 "Tiene servicio tecnico"
	(declare (salience 5))
	(oav-u (objeto ?x)(atributo antiguedad)(valor ?v &:(<  ?v 24)))
	(oav-u (objeto ?x)(atributo sop)(valor actual))
=>
	(assert(oav-u (objeto ?x)(atributo serv)(valor true)))
)

(defrule servicioTec "Tiene servicio tecnico"
	(declare (salience 5))
	(or(oav-u (objeto ?x)(atributo antiguedad)(valor ?v &:(>=  ?v 24)))
	(oav-u (objeto ?x)(atributo sop)(valor no_actual)))
=>
	(assert(oav-u (objeto ?x)(atributo serv)(valor false)))
)

(defrule noServ "Si no tiene servicio"
	(oav-u (objeto ?x)(atributo serv)(valor false))
=>
	(printout T "El aparato no tiene servicio tecnico" crlf)
)

(defrule sistemaOp "Fallo del sistema operativo"
	(oav-u (objeto ?x)(atributo serv)(valor true))
	(or (oav-m(objeto ?x)(atributo fallos)(valor error_arranque))
	(oav-m(objeto ?x)(atributo fallos)(valor ficheros_corr)))
=>
	(assert(oav-u(objeto ?x)(atributo causa)(valor fallo_sistema_operativo)))
)

(defrule sistAli "Fallo del sistema de alimentacion"
	(oav-u (objeto ?x)(atributo serv)(valor true))
	(oav-m(objeto ?x)(atributo fallos)(valor fallo_bat))
	(or(oav-m (objeto ?x)(atributo fallos)(valor se_apaga_ines))
	(oav-m(objeto ?x)(atributo fallos)(valor no_enciende)))
=>
	(assert(oav-u(objeto ?x)(atributo causa)(valor fallo_alimentacion)))
)

(defrule malUso "Mal uso"
	(oav-u (objeto ?x)(atributo serv)(valor true))
	(oav-m(objeto ?x)(atributo fallos)(valor golpes))
	(oav-m(objeto ?x)(atributo fallos)(valor fallo_bat))
	(or(oav-m (objeto ?x)(atributo fallos)(valor se_apaga_ines))
	(oav-m(objeto ?x)(atributo fallos)(valor no_enciende)))
=>
	(assert(oav-u (objeto ?x)(atributo causa)(valor mal_uso)))
)

(defrule noDiag "Teiene servicio pero no rula"
	(declare (salience -5000))
	(oav-u (objeto ?x)(atributo serv)(valor true))
	(not(oav-u(objeto ?x)(atributo causa)(valor ?m)))
=>
	(assert(oav-u(objeto ?x)(atributo causa)(valor nada)))
)

(defrule imprimeFallo "Error"
	(declare (salience -5000))
	(oav-u(objeto ?x)(atributo causa)(valor ?causa))
=>
	(printout T "El objeto " ?x " esta mal debido a " ?causa "." crlf)
)