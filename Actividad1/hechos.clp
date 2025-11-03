(deffacts hechos-iniciales
   ;; Clientes
   (cliente (cliente-id 1) (nombre "Miguel Fuentes") (tipo mayorista) (n-tarjeta "****1234") (direccion "Av. Juárez 123, Guadalajara"))
   (cliente (cliente-id 2) (nombre "Ana López") (tipo menudista) (n-tarjeta "****5678") (direccion "Calle Reforma 456, Guadalajara"))
   (cliente (cliente-id 3) (nombre "Carlos Pérez") (tipo menudista) (n-tarjeta "****9101") (direccion "Av. Vallarta 789, Guadalajara"))

   ;; Productos
   (producto (n-producto P001) (marca Apple) (modelo "iPhone16") (color rojo) (precio 27000.50) (stock 50) (categoria "Smartphone" "Gama Alta"))
   (producto (n-producto P002) (marca Samsung) (modelo Note21) (color negro) (precio 22000.00) (stock 30) (categoria "Smartphone" "Gama Media"))
   (producto (n-producto P003) (marca Apple) (modelo MacBookAir) (color gris) (precio .00) (stock 20) (categoria "Computadora" "Portátil"))

   ;; Tarjetas
   (tarjeta (banco Banamex) (n-tarjeta "****1234") (grupo oro) (vigencia "12-2025"))
   (tarjeta (banco Liverpool) (n-tarjeta "****5678") (grupo VISA) (vigencia "05-2024"))

   ;; Órdenes
   (orden (n-orden 1001) (cliente-id 1) (fecha "25-10-2025"))
   (orden (n-orden 1002) (cliente-id 2) (fecha "25-10-2025"))

   ;; Detalle de orden
   (detalle-orden (n-orden 1001) (n-producto P001) (n-tarjeta "****1234") (cliente-id 1) (cantidad 2))
   (detalle-orden (n-orden 1001) (n-producto P003) (n-tarjeta "****1234") (cliente-id 1) (cantidad 1))
   (detalle-orden (n-orden 1002) (n-producto P002) (n-tarjeta "****5678") (cliente-id 2) (cantidad 1))
)
