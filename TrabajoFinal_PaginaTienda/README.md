# README
Para que funcione el proyecto necesitas:
* Tener instalado previamente Ruby 3.2.0
* Ruby on Rails 8.0.0
* Base de datos SQLite

Tenes que ejecutar los siguientes comandos para instalar:
* bundle install (Para instalar dependencias)
* rails db:create db:migrate db:seed (Para crear y cargar la base de datos con la información de prueba)

Para ejecutar el sistema:
* Terminal 1: rails server
* Terminal 2: rails tailwindcss:watch
* Corre en: http://127.0.0.1:3000/
* Control + c para finalizar ambas terminales

Usuarios de prueba:
* username: empleadouser, contraseña: password123 (Rol empleado)
* username: gerenteuser, contraseña: password123 (Rol gerente)
* username: adminuser, contraseña: password123 (Rol administrador)
* email: cliente@gmail.com, contraseña: password123 (Rol cliente)



Arreglos pendientes:
* al haber dos tipos de autenticación no se valida que no esté activa una antes de permitir usar otra (Usuario y empleado).
* persisten archivos sobrantes de pruebas con tailwind


Notas para mi yo futura:
* Si no funciona db:drop, cerrá todo el proyecto y reintentá. Si sigue sin funcionar, borrá a mano en \storage
* rails console
* rails tailwindcss:build
