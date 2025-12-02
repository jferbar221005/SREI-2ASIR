1. Crea un directorio llamado "dir1" y otro llamado "dir2"

Primero, creamos los directorios dir1 y dir2 en /var/www/ 

<img width="608" height="89" alt="image" src="https://github.com/user-attachments/assets/abcb0659-83c5-49b4-bbd6-ba06e6813e27" />

2. Explica qué diferencia existe entre ambos y muestra su equivalencia con la directiva Require:
   
<Directory /var/www/example1>
   Order Deny,Allow
   Deny from All
   Allow from 192.168.1.100
</Directory>

<Directory /var/www/example1>
   Order Allow,Deny
   Deny from All
   Allow from 192.168.1.100
</Directory

Esta directiva establece el orden en que se evalúan las reglas y determina el comportamiento por defecto. La regla que se evalúa al final es la que prevalece si hay conflicto.

3. Para dir1

- Permite el acceso de las peticiones provenientes de 10.3.0.100
- Permite el acceso desde "marisma.intranet"
- Permite el acceso desde cualquier subdominio de "marisma.intranet"
- Permite el acceso de las peticiones provenientes de "10.3.0.100" con máscara "255.255.0.0"

<img width="433" height="158" alt="image" src="https://github.com/user-attachments/assets/18d80b39-203e-420a-93d1-97a49ee640ef" />

4. Modifica la configuración de forma que el acceso a dir1:
   
- Se permita a "marisma.intranet" y no se permita desde 10.3.0.101"

<img width="408" height="133" alt="image" src="https://github.com/user-attachments/assets/9590096f-4106-41bb-8a78-53a64d266c95" />

5. Modifica la configuración de forma que el acceso a dir2:

- Se permita a "10.3.0.100/8" y no a "marisma.intranet"

<img width="450" height="120" alt="image" src="https://github.com/user-attachments/assets/e8688486-625f-40ee-9d1a-207e902f64fd" />
