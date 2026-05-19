# Despliegue de Infraestructura en AWS: VPC, EC2, RDS y WordPress con EFS

## 1. Configuración de la Red Virtual (VPC)

Para iniciar esta práctica, necesitamos crear una red virtual (VPC) que sirva como base para nuestra infraestructura, alojando dos subredes públicas y dos privadas. Como buena práctica y para evitar conflictos, es recomendable eliminar cualquier recurso previo en AWS para empezar desde cero.

Nos dirigimos al servicio de **VPC** en la consola de AWS y seleccionamos la opción **'VPC y más'** para que el asistente nos facilite la creación de los recursos asociados. Asignaremos el bloque CIDR IPv4 `10.8.0.0/16` y dejaremos desactivada la opción de IPv6.

<img width="2025" height="937" alt="image" src="https://github.com/user-attachments/assets/f5759c94-0daf-4530-be05-6f146e683819" />

A continuación, configuramos las zonas de disponibilidad para asegurar la redundancia. Elegiremos `us-east-1c` y `us-east-1a`:

<img width="591" height="357" alt="image" src="https://github.com/user-attachments/assets/692487cd-9397-469b-ba3a-80b2527336cc" />

Definimos la topología de la red estableciendo 2 subredes públicas y 2 subredes privadas, asegurándonos de asignar los bloques CIDR correspondientes a cada una:

<img width="576" height="667" alt="image" src="https://github.com/user-attachments/assets/41f9174e-738c-4055-ace3-3381105092be" />

Una vez que el proceso finaliza correctamente, el panel confirmará la creación de los recursos:

<img width="2050" height="811" alt="image" src="https://github.com/user-attachments/assets/7cd079ea-4ab7-4284-92eb-71c79150bd68" />

Podemos verificar la estructura final accediendo al mapa de recursos de nuestra nueva VPC:

<img width="2077" height="507" alt="image" src="https://github.com/user-attachments/assets/56779c31-710e-4a64-94b3-410e827f1c40" />

---

## 2. Lanzamiento de la Instancia EC2

El siguiente paso es desplegar el servidor web. Vamos a lanzar una instancia con sistema operativo Ubuntu 26.04 ubicada en nuestra primera subred pública. 

Navegamos al servicio **EC2** y pulsamos en **'Lanzar instancia'**:

Asignamos un nombre, seleccionamos el SO (Ubuntu 26.04) y elegimos el tipo de instancia `t3.micro`. 

<img width="1345" height="1011" alt="image" src="https://github.com/user-attachments/assets/b5b7fddb-7467-403b-832a-45c75af8c8a3" />

En el apartado de **'Configuraciones de red'**, es fundamental editar los valores por defecto para asegurarnos de seleccionar la VPC que acabamos de crear en el paso anterior, tambien debemos habilitar la asignación automática de la IP pública para poder acceder al servidor desde internet. Además, crearemos un Grupo de Seguridad (Security Group) que permita el tráfico SSH (puerto 22) para nuestra administración remota y el tráfico HTTP (puerto 80) para que la web sea accesible:

<img width="1350" height="1041" alt="image" src="https://github.com/user-attachments/assets/88a6050b-84bb-496f-b357-c493fa3be765" />

Revisamos la configuración y lanzamos la instancia. Veremos un mensaje de éxito:

<img width="750" height="180" alt="image" src="https://github.com/user-attachments/assets/101c8a60-df4c-462d-9b52-749541697dd1" />
<img width="2225" height="235" alt="image" src="https://github.com/user-attachments/assets/cc767aa6-2234-48b7-affb-047db62989c9" />

Finalmente, utilizamos nuestro cliente terminal para conectarnos a la instancia mediante SSH utilizando la IP pública asignada:

<img width="1208" height="793" alt="image" src="https://github.com/user-attachments/assets/da8642fb-8efd-4ff5-9ae7-bce76ebd826f" />

---

## 3. Instalación del Servidor Web (Apache y PHP)

Una vez dentro del servidor, el primer paso es actualizar los repositorios (`apt update`) e instalar el servidor web Apache:

<img width="1152" height="161" alt="image" src="https://github.com/user-attachments/assets/301b5f8d-9b97-4ea0-b94b-b307ffb6a5e0" />

<img width="1657" height="148" alt="image" src="https://github.com/user-attachments/assets/672f3279-2de7-419c-983f-7d08422715ed" />

Hhabilitamos el servicio apache2 para que arranque automáticamente cada vez que la instancia se reinicie:

<img width="1308" height="506" alt="image" src="https://github.com/user-attachments/assets/947f2114-1738-4f0b-bc4a-77f5ea9ba407" />

Accedemos desde la IP publica del EC dede un navegador web para comprobar su funcionamiento

<img width="1237" height="605" alt="image" src="https://github.com/user-attachments/assets/d06c2de5-1da8-4637-aafc-e82d22d8d5e2" />

A continuación, instalamos PHP junto con el módulo necesario para que se integre con Apache:

````
apt install php libapache2-mod-php php-cli
````

<img width="1231" height="145" alt="image" src="https://github.com/user-attachments/assets/46069d8a-328a-470a-abb9-4825ed127f82" />

- Comprobamos la version de php con ````php -v````

<img width="787" height="162" alt="image" src="https://github.com/user-attachments/assets/3acb9235-e0f8-4037-9d30-3330f5c58e85" />

Para que WordPress pueda comunicarse con la base de datos, también debemos instalar la extensión de MySQL para PHP y verificar que el módulo se ha cargado correctamente:

<img width="797" height="281" alt="image" src="https://github.com/user-attachments/assets/6e4ede3e-cca0-4356-b0ad-09e216d8b957" />

Por ultimo, reiniciamos apache2

````
systemctl restart apache2
````

<img width="705" height="47" alt="image" src="https://github.com/user-attachments/assets/7f11bd10-c5f1-4fd2-bdd0-f28e04f530d3" />

---

## 4. Despliegue de la Base de Datos (RDS)

En lugar de instalar una base de datos localmente, utilizaremos Amazon RDS para tener un servicio gestionado. Nos dirigimos a **RDS** y creamos una nueva base de datos usando el motor **MySQL**:

<img width="1807" height="707" alt="image" src="https://github.com/user-attachments/assets/71d2096d-15fa-40d7-9c67-a44563b8334b" />

Le asignamos el identificador 'bdwordpress' solicitado para la práctica y configuramos las credenciales maestras: usuario `admin` y una contraseña segura. Tambien debemos elejir la version de MySQL, yo usare justo la anterior a la mas nueva.

<img width="1602" height="767" alt="image" src="https://github.com/user-attachments/assets/c25adc0e-cbee-44ad-aac7-c159cb40f762" />

Ajustamos el tipo de instancia y el almacenamiento

<img width="1633" height="743" alt="image" src="https://github.com/user-attachments/assets/7cfb84c6-7727-4c12-aba2-c74b2f5dc766" />

En el apartado de **Conectividad**, es vital ubicar la base de datos en la VPC de nuestra práctica para que nuestra instancia EC2 pueda alcanzarla de forma segura:

<img width="1633" height="743" alt="image" src="https://github.com/user-attachments/assets/6e6fed4a-9a27-4f0f-8bee-2b27079cace4" />

Revisamos la configuración y finalizamos el proceso de creación:

<img width="1597" height="186" alt="image" src="https://github.com/user-attachments/assets/319dd6b2-e389-4f2f-a730-628376d2175c" />

Para vincular fácilmente nuestra instancia EC2 con esta nueva base de datos, utilizaremos el asistente de conexión de RDS. Esta herramienta ajusta automáticamente las reglas de los Grupos de Seguridad para permitir el tráfico en el puerto 3306 desde el servidor web hacia la base de datos:

<img width="1427" height="632" alt="image" src="https://github.com/user-attachments/assets/6c1efd3c-a62f-4970-9f2d-ee21e022586f" />

Seleccionamos la instancia EC2 destino y pulsamos en conectar:

<img width="1372" height="387" alt="image" src="https://github.com/user-attachments/assets/46f426a2-612a-47a3-b0da-421c53d5c116" />

<img width="1331" height="751" alt="image" src="https://github.com/user-attachments/assets/ac552ba3-e239-4262-807e-7b7cf8a03a59" />

---

## 5. Configuración del Almacenamiento Compartido (EFS)

Para gestionar los archivos multimedia de WordPress de manera escalable, utilizaremos Amazon Elastic File System (EFS). Nos dirigimos al servicio **EFS** y creamos un nuevo sistema de archivos. Importante unir este EFS a el vpc donde se encuentra el EC

<img width="816" height="832" alt="image" src="https://github.com/user-attachments/assets/015f0383-5cbd-452f-8815-54262e629f1a" />

Verificamos en el panel que el estado del EFS indique que está disponible:

<img width="1591" height="353" alt="image" src="https://github.com/user-attachments/assets/d529f163-97ef-43d2-b86f-2f213edace4f" />

Para poder montar este disco de red en nuestra máquina, necesitamos editar el Grupo de Seguridad de nuestra instancia EC2, añadiendo una regla que permita el tráfico NFS (puerto 2049) hacia/desde el EFS.

<img width="1647" height="456" alt="image" src="https://github.com/user-attachments/assets/be5a3909-9a6c-4534-9483-59b5078f79d2" />

Con el acceso garantizado, volvemos al panel de EFS y copiamos el comando de montaje utilizando la opción de DNS proporcionada por AWS:

<img width="1270" height="491" alt="image" src="https://github.com/user-attachments/assets/ce1f3b99-bec0-48d1-a419-b0ed78f647e6" />

Ejecutamos el comando en nuestro servidor por SSH para montarlo. 

<img width="1452" height="76" alt="image" src="https://github.com/user-attachments/assets/dc6e93a8-0c03-4d27-b6f1-32713b2c22b0" />

Para comprobar que se ha montado correctamente, utilizamos el comando `df -h`:

<img width="1428" height="388" alt="image" src="https://github.com/user-attachments/assets/6e237e66-d7b5-49fd-8012-0a52f53a1ac9" />

---

## 6. Instalación y Configuración de WordPress

Nos situamos en la raíz del servidor web (`/var/www/html`) y descargamos la última versión de WordPress:

> 📷 **[Captura 37: Descarga de WordPress mediante `wget`]**
> <img width="963" height="331" alt="image" src="https://github.com/user-attachments/assets/0bfea48a-dba7-48f1-a984-49c1ffe9bd04" />

Descomprimimos el archivo descargado:

> 📷 **[Captura 38: Extracción de los archivos de WordPress con `tar`]**
> <img width="577" height="144" alt="image" src="https://github.com/user-attachments/assets/48d78d76-83c7-4cfb-86ff-84e8425cd86e" />

Para interactuar con nuestra base de datos RDS desde la terminal de la instancia, instalamos el cliente de MySQL (`mariadb-client` o similar):

> 📷 **[Captura 39: Instalación del cliente MySQL en la instancia]**
> <img width="998" height="324" alt="image" src="https://github.com/user-attachments/assets/24df98c0-3c75-41e5-9108-0a70c8dce4a6" />

*Nota de resolución de problemas:* Al intentar conectar a la base de datos arrojaba un error de certificado SSL. Para solucionarlo, tuvimos que descargar el certificado global de Amazon RDS y apuntar a él en nuestra cadena de conexión MySQL:

> 📷 **[Captura 40: Descarga del certificado RDS y conexión exitosa a MySQL]**
> <img width="1101" height="577" alt="image" src="https://github.com/user-attachments/assets/0e2d8762-5d95-4950-ab06-dca346ffe6df" />

Ya dentro de MySQL, preparamos el entorno para WordPress creando su base de datos dedicada, su usuario y otorgándole los permisos necesarios:

> 📷 **[Captura 41: Comandos SQL para crear la DB y el usuario de WordPress]**
> <img width="721" height="268" alt="image" src="https://github.com/user-attachments/assets/68aeec18-c85d-46d9-954a-9742c69d3deb" />

*Segunda nota de resolución de problemas:* En este punto, no era posible acceder mediante el navegador. Revisando la infraestructura, detecté que el Grupo de Seguridad de RDS no estaba correctamente configurado para permitir las peticiones de la instancia. Una vez editado, el problema quedó solucionado:

> 📷 **[Captura 42: Corrección en las reglas del Grupo de Seguridad de RDS]**
> <img width="1629" height="497" alt="image" src="https://github.com/user-attachments/assets/f7e18172-3e1b-424d-ab28-11525114378f" />

Con la red y la base de datos funcionando, accedemos a la IP de la máquina por el navegador y nos recibe el asistente de configuración de WordPress:

> 📷 **[Captura 43: Pantalla de bienvenida de la instalación de WordPress]**
> <img width="1101" height="689" alt="image" src="https://github.com/user-attachments/assets/666a18b3-fad0-4a45-bbe5-acc5c82c8da1" />

Al introducir las credenciales de la base de datos, es muy importante recordar que **no usaremos 'localhost'**. Debemos introducir el *Endpoint* (DNS) que nos proporciona nuestra base de datos RDS:

> 📷 **[Captura 44: Formulario de credenciales con el Endpoint de RDS]**
> <img width="741" height="525" alt="image" src="https://github.com/user-attachments/assets/0ba76886-b84b-4673-b275-c3dc41332117" />

WordPress puede solicitarnos crear el archivo `wp-config.php` manualmente si no tiene permisos de escritura. Una vez creado en el servidor con el código proporcionado, la instalación puede continuar. Rellenamos los datos del sitio y finalizamos:

> 📷 **[Captura 45: Configuración manual de wp-config.php e instalación del sitio]**
> <img width="828" height="883" alt="image" src="https://github.com/user-attachments/assets/b45711bf-4a01-40bb-bec2-be388b648007" />
>
> 📷 **[Captura 46: Mensaje de "¡Lo lograste!" de WordPress]**
> <img width="744" height="292" alt="image" src="https://github.com/user-attachments/assets/77f761b7-3ba7-4b28-bf27-1e26683c4a34" />
>
> 📷 **[Captura 47: Panel de control del administrador de WordPress (Dashboard)]**
> <img width="1232" height="718" alt="image" src="https://github.com/user-attachments/assets/bc15e2de-4256-4094-99ec-9e3f1097d0d2" />

---

## 7. Integración de EFS con el directorio WP-Content

El último paso arquitectónico es asegurar que los archivos subidos a la web (imágenes, temas, plugins) se guarden en nuestro disco compartido EFS y no en el almacenamiento local de la instancia.

Nos desplazamos al directorio de WordPress (`cd /var/www/html/wordpress`). Como medida de seguridad, renombramos la carpeta actual `wp-content` para hacer una copia de seguridad:

> 📷 **[Captura 48: Comando de renombrado/backup de wp-content a wp-content-old]**
> <img width="733" height="57" alt="image" src="https://github.com/user-attachments/assets/9c79b8a0-ce43-4f22-ac29-dba5fa2b53d3" />

Creamos un nuevo directorio `wp-content` totalmente vacío:

> 📷 **[Captura 49: Creación del nuevo directorio wp-content con `mkdir`]**
> <img width="649" height="498" alt="image" src="https://github.com/user-attachments/assets/482f4ae2-47ad-4d4e-b951-3baee59d23f4" />

A continuación, ejecutamos el comando de montaje de EFS (el mismo que probamos en el paso 5), pero esta vez apuntándolo específicamente a nuestro nuevo directorio `/var/www/html/wordpress/wp-content`:

> 📷 **[Captura 50: Montaje del EFS sobre la ruta de wp-content]**
> <img width="1101" height="72" alt="image" src="https://github.com/user-attachments/assets/d07e4222-9470-480c-be12-3c331f01d285" />

Una vez montado, debemos restaurar los datos copiando todo el contenido de nuestra carpeta de respaldo (`wp-content-old`) a la nueva carpeta montada. Finalmente, aplicamos los permisos correctos (`chown -R www-data:www-data`) para que Apache pueda leer y escribir sin problemas:

> 📷 **[Captura 51: Copia de archivos y asignación de propietario www-data]**
> <img width="811" height="76" alt="image" src="https://github.com/user-attachments/assets/2d01601a-827f-43eb-8102-3441d0385c33" />

Podemos ejecutar `df -h` una vez más para verificar que el punto de montaje está trabajando correctamente sobre la carpeta designada:

> 📷 **[Captura 52: Verificación final del sistema de archivos con `df -h`]**
> <img width="1076" height="436" alt="image" src="https://github.com/user-attachments/assets/bd53c26c-4db9-4888-9560-e986355af36d" />
