(deftemplate oav-u "Hechos Univaluados"
    (slot objeto (type SYMBOL))
    (slot atributo (type SYMBOL))
    (slot valor)
)

(deftemplate oav-m "Hechos Multivaluados"
    (slot objeto (type SYMBOL))
    (slot atributo (type SYMBOL))
    (slot valor)
)

;Datos pacientes, hecho

(deffacts datos_Maria "Datos Maria"
    (oav-u (objeto Maria)(atributo sexo)(valor mujer))
    (oav-u (objeto Maria)(atributo edad)(valor 10))
    (oav-m (objeto Maria)(atributo sintomas)(valor dolor_de_cabeza))
    (oav-m (objeto Maria)(atributo sintomas)(valor fiebre))
    (oav-m (objeto Maria)(atributo evidencia)(valor rumor_diastolico))
    (oav-u (objeto Maria)(atributo presionSis)(valor 130))
    (oav-u (objeto Maria)(atributo presionDia)(valor 60))
)

(deffacts datos_Pedro "Datos Pedro"
    (oav-u (objeto Pedro)(atributo sexo)(valor hombre))
    (oav-u (objeto Pedro)(atributo edad)(valor 80))
    (oav-m (objeto Pedro)(atributo sintomas)(valor dolor_abdominal))
    (oav-m (objeto Pedro)(atributo evidencia)(valor rumor_sistolico))
    (oav-m (objeto Pedro)(atributo evidencia)(valor dilatacion_corazon))
    (oav-u (objeto Pedro)(atributo presionSis)(valor 150))
    (oav-u (objeto Pedro)(atributo presionDia)(valor 95))
)

(deffacts enfermedades "Datos enfermedades a que afecta"
    (oav-u (objeto aneurisma_arteria_abdominal)
           (atributo afectan )
           (valor vasos_sanguineos)
    )
    
    (oav-u (objeto estenosis_arterial)
           (atributo afectan)
           (valor vasos_sanguineos)
    )

    (oav-u (objeto arterioesclerosis)
           (atributo afectan)
           (valor vasos_sanguineos)
    )
    
    (oav-u (objeto regurgitacion_aortica)
           (atributo afectan)
           (valor corazon)
    )
)

;Semantica hechos univaluados

(defrule hechos_univaluados "Garantiza la semantica de los tripletes univaluados"
    (declare (salience 1000))
    ?f <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
    ?g <- (oav-u (objeto ?obj) (atributo ?atr) (valor ?))
    (test (neq ?f ?g))
    =>
    (retract ?g)
)

(defrule 15enfermedad "Detecta aneurisma en la arteria abdominal"
    (oav-m(objeto ?persona)(atributo sintomas)(valor dolor_abdominal))
    (oav-m(objeto ?persona)(atributo evidencia)(valor rumor_abdomminal))
    (oav-m(objeto ?persona)(atributo evidencia)(valor masa_pulsante))
	=>
    (assert (oav-m(objeto ?persona)(atributo enfermedad)(valor 	aneurisma_arteria_abdominal)))
)

(defrule 16pulso "Calcula la presion del pulso"
	(declare (salience 10))
	(oav-u(objeto ?persona)(atributo presionSis)(valor ?sistolica))
	(oav-u(objeto ?persona)(atributo presionDia)(valor ?diastolica))
	=>
	(assert(objeto ?persona)(atributo presionPulso)(valor (- ?sistolica ?diastolica)))
)

(defrule 16enfermedad "Detecta regurgitacion aortica"
	(oav-u(objeto ?persona)(atributo presionSis)(valor ?sistolica &:(>= ?sistolica 130 )))
    	(oav-u(objeto ?persona)(atributo presionPulso)(valor ?pulso &:(>= ?pulso 50 )))
    	(oav-m(objeto ?persona)(atributo evidencia)(valor rumor_sistolico | dilatacion_corazon))
	=>
    	(assert (oav-m(objeto ?persona)(atributo enfermedad)(valor regurgitacion_aortica)))
)

(defrule 17enfermedad "Detecta regurgitacion aortica"
	(oav-u(objeto ?persona)(atributo sintomas)(valor calambre))
	=>
    	(assert (oav-m(objeto ?persona)(atributo enfermedad)(valor estenosis_arterial)))
)

(defrule 17riesgo "Detecta si un paciente es de riesgo"
	(declare (salience 5))
	(or(oav-u(objeto ?persona)(atributo obeso)(valor true))
	(oav-u(objeto ?persona)(atributo fumador_tiempo)(valor ?tiempo &:(> ?tiempo 10)))
	(oav-u(objeto ?persona)(atributo edad)(valor ?edad &:(> ?edad 55))))
	=>
    	(assert (oav-u (objeto ?persona)(atributo Paciente_riesgo)(valor true)))
)

(defrule 17enf "Si es de riesgo y arterioesclerosis"
	(oav-u(objeto ?persona)(atributo Paciente_riesgo)(valor true))
	(oav-m(objeto ?persona)(atributo enfermedad)(valor estenosis_arterial))
	=>
	(assert (oav-m (objeto ?persona)(atributo enfermedad)(valor arterioesclerosis)))
)

(defrule imprime1 "Imprime por salida estandar a que afecta la enfermedad
padecida"
	(oav-m (objeto ?persona)(atributo padece)(valor ?enfermedad))
	(oav-u (objeto ?enfermedad)(atributo afecta)(valor vasos_sanguineos))
=>
	(printout t ?persona " padece " ?enfermedad ", una enfermedad que afecta a los vasos sanguineos." crlf)
)

(defrule imprime2 "Imprime por salida estandar a que afecta la enfermedad
padecida"
	(oav-m (objeto ?persona)(atributo padece)(valor ?enfermedad))
	(oav-u (objeto ?enfermedad)(atributo afecta)(valor corazon))
=>
	(printout t ?persona " padece " ?enfermedad ", una enfermedad que afecta al corazon." crlf)
)
