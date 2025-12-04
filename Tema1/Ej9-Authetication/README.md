1. Crea cinco usuarios: usuario1, usuario2, usuario3, usuario4, usuario5.

- Usamos los siguientes comandos para añadir los usuario a un archivo htpasswd

<img width="756" height="344" alt="image" src="https://github.com/user-attachments/assets/a68075eb-00da-4b9c-844c-7ecbf17a52ca" />

2. Crea dos grupos de usuarios, el primero formado por usuario1 y usuario2; y el segundo por el resto de usuarios.

- Creamos el archivo de grupos "sudo nano /etc/apache2/.htgroups" y dentro, definimos a que grupo pertenece cada usuario

<img width="670" height="124" alt="image" src="https://github.com/user-attachments/assets/c4c74d02-f8b3-428f-9151-21dde2e768d6" />

3 y 4 Crea un directorio llamado privado1 que permita el acceso a todos los usuarios. Crea un directorio llamado privado2 que permita el acceso sólo a los usuarios del grupo1.

- Primero, creamos las carpetas en /var/www con los siguientes comandos:

<img width="593" height="70" alt="image" src="https://github.com/user-attachments/assets/da5b09b9-3d3c-4009-836c-12a80147cae7" />

- Creamos los index.html dentro de las carpetas privado1 y privado2

<img width="681" height="106" alt="image" src="https://github.com/user-attachments/assets/b7eeaf54-3032-49a4-b191-2cd3deed1a7e" />

- Modificamos el archivo 000-default.conf con las siguientes directivas

<img width="1175" height="988" alt="image" src="https://github.com/user-attachments/assets/0e140b5e-d473-4f6d-9cb4-b6f41c656c67" />

5. La directiva satisfy controla cómo se debe comportar el servidor cuando tenemos autorizaciones a nivel de host (order, allow, deny) y autorizaciones de usuarios (require)

*Caso A: Satisfy All (Comportamiento por defecto)*
Si en la configuración pones Satisfy All:

Lógica: El cliente debe cumplir TODAS las condiciones.

Resultado:

- El usuario debe conectarse desde el localhost Y ADEMÁS debe introducir un usuario/contraseña válido del grupo1.
- Si intentas entrar desde otro PC: Acceso denegado (aunque tengas la contraseña).
- Si entras desde localhost pero no tienes contraseña: Acceso denegado.
- Es la configuración más restrictiva.

*Caso B: Satisfy Any*
Si en la configuración pones Satisfy Any:

Lógica: Al cliente le basta con cumplir CUALQUIERA de las condiciones.

Resultado:

- Si estás en localhost: Apache te deja pasar sin pedir contraseña. (Porque ya cumpliste la condición de Host, así que no necesita la del Usuario).
- Si estás en otro PC (no localhost): Apache te pedirá contraseña. Si te validas como usuario1 (que es del grupo1), te dejará entrar.
- Es útil para permitir a los administradores entrar rápido desde la red interna, pero forzar contraseña a los que vienen de fuera.

