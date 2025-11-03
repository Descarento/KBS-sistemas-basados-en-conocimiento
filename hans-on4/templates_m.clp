;;templates

(deftemplate mono
    (slot pocicion)
    (slot altura)
)

(deftemplate caja
    (slot pocicion)
)

(deftemplate banana
    (slot pocicion (default "techo-centro"))
    (slot comido)
)