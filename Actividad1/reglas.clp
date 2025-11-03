;;reglas o rules

;; 1. Recomendar productos de la misma marca
(defrule recomendar-misma-marca                        
    (detalle-orden (cliente-id ?id) (n-producto ?np))   
    (cliente (cliente-id ?id) (nombre $?n))     
    (producto (n-producto ?np) (marca ?m))             
    (producto (marca ?m) (n-producto ?otro&~?np))       
    =>                                                 
    (printout t "El cliente " (implode$ $?n) " podría interesarse en más productos de la marca " ?m "." crlf))

;; 2. Recomendar productos de la misma categoría
(defrule recomendar-misma-categoria
    (detalle-orden (cliente-id ?id) (n-producto ?np))          
    (cliente (cliente-id ?id) (nombre $?n))                    
    (producto (n-producto ?np) (categoria $?cat))              
    (producto (n-producto ?otro) (categoria $?cat2))           
    (test (eq (nth$ 1 $?cat) (nth$ 1 $?cat2)))      
    =>
    (printout t "El cliente " (implode$ $?n) " podría interesarse en más productos de la categoría " (nth$ 1 $?cat) "." crlf))

;; 3. Recomendar descuento del 10% para productos con exceso de stock
(defrule recomendar-descuento-por-exceso-stock
    (producto (n-producto ?p) (stock ?s&:(> ?s 50)))
    =>
    (printout t "El producto " ?p " tiene un descuento del 10%." crlf))

;; 4. Recomendar productos de precio similar
(defrule recomendar-precio-similar
    (detalle-orden (cliente-id ?id) (n-producto ?np)) ;
    (cliente (cliente-id ?id) (nombre ?n)) 
    (producto (n-producto ?np) (precio ?pr)) 
    (producto (n-producto ?otro&~?np) (precio ?p2&:(and (> ?p2 (- ?pr 3000)) (< ?p2 (+ ?pr 3000)))) (modelo ?mod)) ; busca otro producto con precio similar
    =>
    (printout t "Al cliente " ?n " podría gustarle también el producto " ?mod " por tener un precio similar." crlf))

;; 5. Recomendar descuento a cliente mayorista
(defrule recomendar-descuento-mayorista
    (cliente (cliente-id ?id) (nombre ?n) (tipo mayorista)) ; identifica al cliente mayorista y obtiene su nombre
    =>
    (printout t "Descuento del 15% al cliente mayorista " ?n "." crlf))

;; 6. Recomendar productos económicos a menudistas
(defrule recomendar-menudista-economicos
    (cliente (cliente-id ?id) (nombre ?n) (tipo menudista))
    (producto (n-producto ?p) (modelo ?mod) (precio ?pr&:(< ?pr 25000))) 
    =>
    (printout t "Le ofrecemos al cliente " ?n " el producto " ?mod " por ser una opción económica." crlf))

;; 7. Ofrecer tarjeta de la tienda a clientes que no tienen una
(defrule ofrecer-tarjeta-tienda
    (cliente (cliente-id ?id) (nombre ?n) (n-tarjeta nil)) ; busca clientes sin número de tarjeta
    =>
    (printout t "Ofrecer la tarjeta de la tienda al cliente " ?n " para acceder a beneficios exclusivos." crlf))

;; 8. Recomendar productos nuevos a clientes frecuentes
(defrule recomendar-nuevos-clientes-frecuentes
    (cliente (cliente-id ?id) (nombre ?n) (tipo "frecuente"))
    (producto (n-producto ?p) (modelo ?mod) (nuevo SI))
    =>
    (printout t "Recomendar al cliente " ?n " el nuevo producto " ?mod "." crlf))

;; 9. Recomendar otro producto del mismo color que uno ya comprado
(defrule recomendar-por-color
    (detalle-orden (cliente-id ?id) (n-producto ?np))
    (cliente (cliente-id ?id) (nombre ?n))
    (producto (n-producto ?np) (color ?c))
    (producto (n-producto ?otro&~?np) (modelo ?mod) (color ?c))
    =>
    (printout t "Ofrecemos al cliente " ?n " el producto " ?mod " del color " ?c " como complemento a su compra." crlf))

;; 10. Recomendar productos complementarios
(defrule recomendar-productos-complementarios
    (detalle-orden (cliente-id ?id) (n-producto ?np))
    (cliente (cliente-id ?id) (nombre ?n))
    (producto (n-producto ?np) (modelo ?mod))
    (producto (n-producto ?comp&~?np) (modelo ?mod2))
    =>
    (printout t "Sugerimos al cliente " ?n " complementar su compra de " ?mod " con el producto " ?mod2 "." crlf))

;; 11. Recomendar smartphone a quien compró computadora
(defrule recomendar-smartphone-para-computadora
    (detalle-orden (cliente-id ?id) (n-producto ?np))
    (cliente (cliente-id ?id) (nombre ?n))
    (producto (n-producto ?np) (categoria $?cat&:(member$ "Computadora" $?cat)))
    (producto (n-producto ?sp) (modelo ?mod) (categoria $?cat2&:(member$ "Smartphone" $?cat2)))
    =>
    (printout t "Sugerir el smartphone " ?mod " al cliente " ?n " que compró una computadora." crlf))

;; 12. Recomendar marcas diferentes dentro de la misma categoría
(defrule recomendar-marcas-diferentes
    (detalle-orden (cliente-id ?id) (n-producto ?np))
    (cliente (cliente-id ?id) (nombre ?n))
    (producto (n-producto ?np) (categoria $?cat) (marca ?m))
    (producto (n-producto ?p2) (modelo ?mod) (categoria $?cat2) (marca ?m2&~?m))
    (test (eq (nth$ 1 $?cat) (nth$ 1 $?cat2)))
    =>
    (printout t "Mostrar al cliente " ?n " el producto " ?mod " de la marca " ?m2 " como alternativa dentro de la misma categoría." crlf))

;; 13. Recomendar renovación de modelo
(defrule recomendar-renovacion
    (detalle-orden (cliente-id ?id) (n-producto ?np))
    (cliente (cliente-id ?id) (nombre ?n))
    (producto (n-producto ?np) (modelo ?mod))
    =>
    (printout t "Ofrecer al cliente " ?n " una versión más reciente del modelo " ?mod "." crlf))

;; 14. Recomendar combos por múltiples órdenes
(defrule recomendar-combo
    (detalle-orden (cliente-id ?id) (n-orden ?o1))
    (detalle-orden (cliente-id ?id) (n-orden ?o2&~?o1))
    (cliente (cliente-id ?id) (nombre ?n))
    =>
    (printout t "Ofrecer combos o paquetes especiales al cliente " ?n " por realizar múltiples compras." crlf))

;; 15. Recomendar productos premium a mayoristas frecuentes
(defrule recomendar-premium-mayorista
    (cliente (cliente-id ?id) (nombre ?n) (tipo mayorista))
    (detalle-orden (cliente-id ?id))
    (producto (categoria $?cat&:(member$ "Premium" $?cat)) (n-producto ?p) (modelo ?mod))
    =>
    (printout t "Sugerir al cliente mayorista " ?n " el producto premium " ?mod " por su nivel de compras." crlf))

;; 16. Recomendar promociones del banco
(defrule recomendar-promocion-banco
    (cliente (cliente-id ?id) (nombre ?n) (n-tarjeta ?t))
    (tarjeta (n-tarjeta ?t) (banco ?b))
    =>
    (printout t "Ofrecer al cliente " ?n " promociones especiales del banco " ?b "." crlf))

;; 17. Ofrecer descuentos aleatorios a clientes frecuentes
(defrule recomendar-descuento-aleatorio
    (cliente (cliente-id ?id) (nombre ?n) (frecuente si))
    =>
    (printout t "Ofrecer un descuento sorpresa al cliente frecuente " ?n " en su próxima compra." crlf))

;; 18. Ofrecer promociones por volumen
(defrule recomendar-mayor-cantidad
    (detalle-orden (cliente-id ?id) (cantidad ?c&:(> ?c 1)))
    (cliente (cliente-id ?id) (nombre ?n))
    =>
    (printout t "Ofrecer promociones por volumen al cliente " ?n " por adquirir múltiples unidades." crlf))

;; 19. Contactar clientes por seguimiento de compra
(defrule recomendar-por-fecha
    (orden (cliente-id ?id) (fecha ?f))
    (cliente (cliente-id ?id) (nombre ?n))
    =>
    (printout t "Contactar al cliente " ?n " para darle seguimiento a su compra del " ?f "." crlf))


;; 20. test de clientes
(defrule mostrar-clientes
   (cliente (cliente-id ?id) (nombre ?n))
   =>
   (printout t "Cliente #" ?id ": " ?n crlf))
