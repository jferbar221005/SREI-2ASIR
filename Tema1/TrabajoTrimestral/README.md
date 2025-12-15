- Fase 1: Preparación del Entorno y DNS Local

1ero editamos el archivo hosts con "sudo nano /etc/hosts" y añadimos los dominios que queremos montar

<img width="646" height="133" alt="image" src="https://github.com/user-attachments/assets/0d63d706-fa9e-4a7a-91ca-c8d8ae1cdd85" />

- Fase 2: Instalación de Apache y LAMP Stack

Instalamos Apache, la base de datos y PHP con los módulos necesarios. "sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc"
**Antes de realizar este paso, hacemos un "sudo apt update"**

<img width="1108" height="234" alt="image" src="https://github.com/user-attachments/assets/5401b5bf-d0ae-4803-98ea-92572f18ab54" />
<img width="721" height="89" alt="image" src="https://github.com/user-attachments/assets/397185bf-cdf4-40e5-8470-4261282fac67" />

Ahora, configuramos la BD con el comando "sudo mysql_secure_installation"

-Seleccionamos que si queremos camboar a unix_socket authentication y que no queremos cambiar las contrasña de root

<img width="711" height="508" alt="image" src="https://github.com/user-attachments/assets/26e8542c-66be-4847-85a5-d6c0e36504c5" />

-Terminamos de configurar los siguientes parametros:

<img width="696" height="621" alt="image" src="https://github.com/user-attachments/assets/f37de9fa-b1a2-418f-b306-4a4ca92af101" />

- Fase 3: Instalacion y Configuración de WordPress (centro.intranet)

Accedemos a MariaDB y creamos la BD de wordpress, el usuario para acceder y asignamos los permisos necesarios 

<img width="759" height="474" alt="image" src="https://github.com/user-attachments/assets/c1c5e6fa-64f8-442f-9ecb-19768b18c912" />

A continuacion, nos descargamos wordpress en la carpeta temp

<img width="1223" height="270" alt="image" src="https://github.com/user-attachments/assets/dcbd0804-c609-4b61-94cf-a30cd0ac9c42" />

El siguiente paso es descomprimir el latest.tar.gz de wp

<img width="521" height="174" alt="image" src="https://github.com/user-attachments/assets/59ed3ad4-6473-454e-8b28-de58a039e681" />

Ahora, crearemos la carpeta donde se alojara, en este caso "/var/www/centro" y movemos la carpeta que hemos descomprido "wordpress" a la carpeta /var/www/centro

<img width="545" height="39" alt="image" src="https://github.com/user-attachments/assets/c16d2f85-e533-4ef6-9702-30273f21002d" />
<img width="594" height="42" alt="image" src="https://github.com/user-attachments/assets/02b0902f-79dc-4a9f-abae-eac9f125c85c" />

Asignamos el propietario a www-data con "sudo chown -R www-data:www-data /var/www/centro" y asignamos permisos 755 "sudo chmod -R 755 /var/www/centro" (propietario tiene permisos completos (lectura, escritura y ejecución), mientras que el grupo y los otros (usuarios restantes) solo tienen permisos de lectura y ejecución (no escritura))

<img width="743" height="42" alt="image" src="https://github.com/user-attachments/assets/23b0d3f5-cb6d-4608-b4b3-77071b6bd4a0" />

Lo siguiente es crear su VirtualHost, para ello, nos vamos a "cd /etc/apache2/sites-available/" y creamos el archivo centro.conf en el que se incluira lo siguiente "sudo nano centro.conf":

<img width="747" height="204" alt="image" src="https://github.com/user-attachments/assets/16622778-82ac-4d96-972b-81de2853ed4c" />

Por ultimo, habiltamos el sitio con "sudo a2ensite centro.conf" y una vez hecho, recargamos apache2 con "sudo systemctl reload apache2"

<img width="784" height="129" alt="image" src="https://github.com/user-attachments/assets/3a6f0516-bf59-4bdd-9046-148c62497dda" />

Como podemos ver, wordpress estara instalado correctamente

<img width="1918" height="812" alt="image" src="https://github.com/user-attachments/assets/3aeb116e-95b6-4cb4-91a1-f26f9fac7a2a" />

Ahora, procedemos a configurar Wordpress, en el paso anterior elegimos el idioma, ahora, conectamos Wordpress con la BD

<img width="799" height="741" alt="image" src="https://github.com/user-attachments/assets/39eefe45-295b-4c3b-9592-5ddc067118ab" />

Una vez hemos conectado la BD, pinchamos en "Realizar la instalacion"

<img width="831" height="320" alt="image" src="https://github.com/user-attachments/assets/54defd9f-5779-491d-92d2-e7a9e4d49606" />

Configuramos nuestro sitio

<img width="720" height="811" alt="image" src="https://github.com/user-attachments/assets/afb31b18-0557-4573-9829-d8475891d7aa" />

Ahora, accedemos a wordpress con las credenciales configuradas

<img width="392" height="555" alt="image" src="https://github.com/user-attachments/assets/83ac062e-9660-409f-9759-aaecdc0bcad9" />

Ya tendremos WP instalado y confiugurado correctamente

<img width="1911" height="910" alt="image" src="https://github.com/user-attachments/assets/36e61bb0-a6b7-48e5-8281-8ef0f3fd8618" />

- Fase 4: Aplicación Python con WSGI (departamentos.centro.intranet)

Primero, instalamos el modulo WSGI "sudo apt install libapache2-mod-wsgi-py3" 

<img width="738" height="138" alt="image" src="https://github.com/user-attachments/assets/83c8a7bc-f1a0-4b26-81b5-ad73dcc05060" />

Ahora, creamos el directorio de la app web, se alojara en /var/ww/departamentos "sudo mkdir -p /var/www/departamentos"

sudo mkdir -p /var/www/departamentos

A continuacion, dentro del directorio departamentos, creamos el archivo app.py donde estara nuestra app de python "sudo nano app.py"

<img width="889" height="183" alt="image" src="https://github.com/user-attachments/assets/5712a2d0-88ca-43f2-a572-c27864584919" />

Lo siguiente es proteger la app con un htpasswd, en mi caso, añadire al htpasswd el usuario profe y contraseña Temporal01 "sudo htpasswd -c /etc/apache2/.htpasswd profe"

<img width="879" height="111" alt="image" src="https://github.com/user-attachments/assets/25f1340b-1c64-4020-8073-129f6c275b5c" />

Creamos el archivo VirtualHost dentro del directorio departamentos "sudo nano /etc/apache2/sites-available/departamentos.conf"

<img width="747" height="394" alt="image" src="https://github.com/user-attachments/assets/d7faff24-01db-4d19-97ff-8ba2ad623b96" />

Por ultimo habilitamos el sitio y recargamos apache "sudo a2ensite departamentos.conf /// sudo systemctl reload apache2"

Fase
<img width="795" height="121" alt="image" src="https://github.com/user-attachments/assets/65848906-61e8-4dbe-98c7-42b6f915a195" />

Como podemos ver, el servicio, esta funcioanando plenamente

<img width="642" height="186" alt="image" src="https://github.com/user-attachments/assets/ebdd4685-f307-4df0-bc59-f0d99efa5968" />
