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

<img width="760" height="207" alt="image" src="https://github.com/user-attachments/assets/3ad97f88-951e-4ff7-9025-a9fc187741e1" />

Por ultimo, habiltamos el sitio con "sudo a2ensite centro.conf" y una vez hecho, recargamos apache2 con "sudo systemctl reload apache2"

<img width="784" height="129" alt="image" src="https://github.com/user-attachments/assets/3a6f0516-bf59-4bdd-9046-148c62497dda" />

