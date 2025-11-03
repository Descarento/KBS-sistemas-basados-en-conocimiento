;; templates

(deftemplate cliente
    (slot cliente-id)
    (multislot nombre);;guardar con comillas si es completo
    (slot tipo);;menudista o mayorista
    (slot n-tarjeta)
    (multislot direccion);;a esta tambien es combeniente usar comillas
    (slot frecuente);;si o no

)

(deftemplate producto
    (slot n-producto)
    (slot marca)
    (slot modelo);; si el modelo lleva espacios usar comillas
    (slot color)
    (slot precio (type FLOAT))
    (slot stock (type INTEGER))
    (multislot categoria)
    (slot nuevo (default "NO"));;si o no

)

(deftemplate tarjeta
    (slot banco)
    (slot n-tarjeta)
    (slot grupo)
    (slot vigencia)

)

(deftemplate orden
    (slot n-orden)
    (slot cliente-id)
    (slot fecha)
)

(deftemplate detalle-orden
    (slot n-orden)
    (slot n-producto)
    (slot n-tarjeta)
    (slot cliente-id)
    (slot cantidad (default 1))

) 

