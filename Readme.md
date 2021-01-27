Viernes de código abierto
El código abierto está hecho por personas como tú. Este viernes, invierta unas horas contribuyendo al software que usa y ama.

Qué es esto
Este repositorio es el código fuente de https://opensourcefriday.com .

Open Source Friday es un movimiento para alentar a las personas, empresas y mantenedores a contribuir unas horas al software de código abierto todos los viernes.

El software de código abierto (OSS) es la columna vertebral de la mayoría de software, herramientas, aplicaciones, electrónica y más que usamos todos los días. Open Source Friday no solo se trata de alentar a las personas a contribuir, sino que también se trata de alentar a las empresas a retribuir al software que utilizan al reservar tiempo para que nuestros colegas trabajen en OSS en el reloj.

Al registrarse en el sitio web, puede ver y compartir sus contribuciones de viernes y las de sus amigos. También encontrará una serie de guías para comenzar con el código abierto y ser un buen mantenedor.

Que no es esto
No somos un lugar donde obtendrás camisetas u otro tipo de obsequios gratis por tus contribuciones. Esto tiende a sacar a relucir el mal comportamiento, como los RP que cambian una sola línea de espacio en blanco, lo que hace que los mantenedores pierdan tiempo y energía, las recompensas deberían ser menos tangibles.

Traducción
Transifex
Ayude a traducir "Open Source Friday" en Transifex.

Solicitud de extracción de GitHub
Consulte CONTRIBUTING.md # Traducción .

Desarrollo
Fuente alojada en GitHub . Informar problemas / solicitudes de funciones sobre problemas de GitHub .

Empezando
Registre una nueva aplicación GitHub OAuth .

Establezca la página de inicio en http://localhost:3000.
Establezca la URL de devolución de llamada de autorización en http://localhost:3000/users/auth/github/callback.
Cree el archivo de configuración para el ID de cliente y el secreto generado para su aplicación GitHub OAuth:

cp config / application.example.yml config / application.yml
Actualice config/application.yml, establezca github_client_idy github_client_secret.

Las variables de entorno se gestionan mediante figaro .

Bootstrapping de la aplicación
Si está en macOS, tenga Homebrew instalado y haya configurado las variables de entorno anteriores para comenzar a ejecutar:

./script/bootstrap 
./script/setup 
./script/server
Esto debería ayudarlo a comenzar con este proyecto en su máquina. De lo contrario, ¡no te preocupes! Puede utilizar las siguientes instrucciones para instalar todas las dependencias y configurar un servidor local.

Primero, necesitará instalar Ruby. Recomendamos utilizar el excelente rbenv y ruby-build

instalación de rbenv
A continuación, deberá asegurarse de tener instalado PostgreSQL. En las distribuciones de Linux basadas en Debian, puede usar apt-get para instalar Postgres:

sudo apt-get install postgresql postgresql-contrib libpq-dev
En Windows, puede usar el administrador de paquetes Chocolatey para instalar Postgres:

choco instalar postgresql
Ahora, instalemos las gemas del Gemfile("Gems" son sinónimos de bibliotecas en otros idiomas).

gema install bundler && rbenv rehash 
bundle install
Una vez que todas las gemas estén instaladas, necesitaremos crear las bases de datos y las tablas. Rails lo hace fácil.

./bin/setup
Ahora todo lo que tenemos que hacer es iniciar el servidor Rails y apuntar nuestro navegador a http: // localhost: 3000

./script/server
Nota sobre parches / solicitudes de extracción
Bifurca el proyecto.
Clona tu tenedor en tu máquina.
Cree una nueva rama para su característica / corrección.
Haga su adición de funciones o corrección de errores.
Agregue pruebas para ello. Esto es importante para no romperlo en una versión futura sin querer.
Envíe una solicitud de extracción.
Código de Conducta
Tenga en cuenta que este proyecto se publica con un Código de conducta para colaboradores . Al participar en este proyecto, acepta cumplir sus términos.

Derechos de autor
Copyright (c) Colaboradores de Open Source Friday. Consulte LICENCIA para obtener más detalles.
