(deftemplate persona 
   (slot nombre)
   (slot direccion)
)

(deftemplate mudanza
   (slot nombre)
   (slot direccion))

(defrule procesar-informacion-mudanza
   ?x <- (mudanza (nombre ?nombre) (direccion ?direccion))
   ?y <- (persona (nombre ?nombre))
   =>
   (retract ?x)
   (modify ?y (direccion ?direccion))
   (printout T crlf "El nombre es: " ?x crlf)
   (printout T crlf "La calle es: " ?y crlf)
)

(deffacts informacion-mudanza
   (persona (nombre "Juan Rodrigo")
		(direccion "Paseo Zorrilla 37"))
   (mudanza (nombre "Juan Rodrigo")
		(direccion "Calle Gaviota 12"))
)