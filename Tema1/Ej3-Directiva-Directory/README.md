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










