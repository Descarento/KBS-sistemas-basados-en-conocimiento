;;reglas

;; El mono camina hacia la caja
(defrule mover-hacia-caja
    ?m <- (mono (pocicion "ventana") (altura "bajo"))
    (caja (pocicion "puerta"))
    =>
    (retract ?m)
    (assert (mono (pocicion "puerta") (altura "bajo")))
    (printout t "El mono camina desde la ventana hacia la caja que está junto a la puerta." crlf)
)

;; El mono empuja la caja al centro
(defrule empujar-caja-centro
    ?m <- (mono (pocicion "puerta") (altura "bajo"))
    ?c <- (caja (pocicion "puerta"))
    =>
    (retract ?m ?c)
    (assert (mono (pocicion "centro") (altura "bajo")))
    (assert (caja (pocicion "centro")))
    (printout t "El mono empuja la caja desde la puerta hasta el centro de la habitación." crlf)
)

;; El mono empuja la caja debajo de las bananas
(defrule empujar-caja-banana
    ?m <- (mono (pocicion "centro") (altura "bajo"))
    ?c <- (caja (pocicion "centro"))
    (banana (pocicion "techo-centro"))
    =>
    (retract ?m ?c)
    (assert (mono (pocicion "debajo-banana") (altura "bajo")))
    (assert (caja (pocicion "debajo-banana")))
    (printout t "El mono empujo la caja hasta quedar justo debajo de las bananas." crlf)
)

;; El mono se sube a la caja
(defrule subir-caja
    ?m <- (mono (pocicion "debajo-banana") (altura "bajo"))
    (caja (pocicion "debajo-banana"))
    =>
    (retract ?m)
    (assert (mono (pocicion "debajo-banana") (altura "alto")))
    (printout t "El mono se sube a la caja." crlf)
)

;; El mono come las bananas
(defrule comer-banana
    ?m <- (mono (pocicion "debajo-banana") (altura "alto"))
    ?b <- (banana (pocicion "techo-centro") (comido "no"))
    =>
    (retract ?b)
    (assert (banana (pocicion "techo-centro") (comido "si")))
    (printout t "El mono alcanza y come las bananas. ¡Lo logró!" crlf)
)