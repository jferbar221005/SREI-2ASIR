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

<img width="1406" height="437" alt="image" src="https://github.com/user-attachments/assets/a330306a-76c1-47f4-9ad1-dfeac97bb77a" />

Descomprimimos el archivo descargado:

<img width="690" height="92" alt="image" src="https://github.com/user-attachments/assets/aec87abc-4953-4de2-abac-255eae2e5253" />

Para interactuar con nuestra base de datos RDS desde la terminal de la instancia, instalamos el cliente de MySQL (`mariadb-client` o similar):

<img width="1212" height="147" alt="image" src="https://github.com/user-attachments/assets/b0d89d93-55c8-4889-a92e-aa008165ee4c" />

*Nota de resolución de problemas:* Al intentar conectar a la base de datos arrojaba un error de certificado SSL. Para solucionarlo, tenemos que descargar el certificado global de Amazon RDS y apuntar a él en nuestra cadena de conexión MySQL:

<img width="1451" height="142" alt="image" src="https://github.com/user-attachments/assets/fd1da00a-f1b4-4cda-b894-c38aa6f4ae69" />

Conectamos el cliente mysql a la BD:

<img width="1450" height="365" alt="image" src="https://github.com/user-attachments/assets/06c14115-1cc0-4f36-802f-45d9774e6d9b" />

Ya dentro de MySQL, preparamos el entorno para WordPress creando su base de datos dedicada, su usuario y otorgándole los permisos necesarios:

<img width="952" height="357" alt="image" src="https://github.com/user-attachments/assets/29d7355e-cc77-46fd-8af4-48639d7b25ed" />

Con la red y la base de datos funcionando, accedemos a la IP de la máquina por el navegador y nos recibe el asistente de configuración de WordPress:

<img width="972" height="817" alt="image" src="https://github.com/user-attachments/assets/e1835a81-c2e5-48bd-bc94-f673d984a650" />

Al introducir las credenciales de la base de datos, es muy importante recordar que **no usaremos 'localhost'**. Debemos introducir el *Endpoint* (DNS) que nos proporciona nuestra base de datos RDS:

<img width="1100" height="878" alt="image" src="https://github.com/user-attachments/assets/447ae775-7c9c-4f47-81d5-bb539b810752" />

WordPress puede solicitarnos crear el archivo `wp-config.php` manualmente si no tiene permisos de escritura. Una vez creado en el servidor con el código proporcionado, la instalación puede continuar. Rellenamos los datos del sitio y finalizamos:

<img width="1053" height="677" alt="image" src="https://github.com/user-attachments/assets/7c2cb16a-aa4b-49a9-a5a9-4ce044fd8874" />

<img width="1143" height="686" alt="image" src="https://github.com/user-attachments/assets/f8989327-d09a-4468-b2c1-2f6b6b43fcab" />

---

## 7. Integración de EFS con el directorio WP-Content

El último paso arquitectónico es asegurar que los archivos subidos a la web (imágenes, temas, plugins) se guarden en nuestro disco compartido EFS y no en el almacenamiento local de la instancia.

Nos desplazamos al directorio de WordPress (`cd /var/www/html/wordpress`). Como medida de seguridad, renombramos la carpeta actual `wp-content` para hacer una copia de seguridad:

<img width="900" height="52" alt="image" src="https://github.com/user-attachments/assets/8f03d213-d5c9-4aa8-ad3a-a502ec900347" />

Creamos un nuevo directorio `wp-content` totalmente vacío:

<img width="761" height="48" alt="image" src="https://github.com/user-attachments/assets/9c84fd24-56a9-42f4-9277-999502e52bd7" />

A continuación, ejecutamos el comando de montaje de EFS (el mismo que probamos en el paso 5), pero esta vez apuntándolo específicamente a nuestro nuevo directorio `/var/www/html/wordpress/wp-content`: 
*Importante antes desmontar EFS del sistema, para luego montar en la carpeta wp-content*

<img width="1456" height="462" alt="image" src="https://github.com/user-attachments/assets/683be723-49cb-4ec6-b7b2-a825b883c2db" />

Una vez montado, debemos restaurar los datos copiando todo el contenido de nuestra carpeta de respaldo (`wp-content-old`) a la nueva carpeta montada. Finalmente, aplicamos los permisos correctos (`chown -R www-data:www-data`) para que Apache pueda leer y escribir sin problemas:

<img width="993" height="75" alt="image" src="https://github.com/user-attachments/assets/4dff9c4d-04a4-481e-9e5b-af392b88091b" />

Podemos ejecutar `df -h` una vez más para verificar que el punto de montaje está trabajando correctamente sobre la carpeta designada:

<img width="1432" height="395" alt="image" src="https://github.com/user-attachments/assets/3452474f-4931-4dc7-b088-2f412ccd3db1" />
