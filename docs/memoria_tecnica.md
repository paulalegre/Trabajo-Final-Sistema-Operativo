# Memoria Técnica – Trabajo Final / Sistemas Operativos

## 1. Introducción
Este proyecto consiste en el desarrollo de un script en Bash para automatizar tres tareas concretas dentro de un sistema operativo Linux.  
Se implementa un menú interactivo que permite seleccionar las opciones del trabajo final sin necesidad de recordar los comandos manuales.

Las tareas solicitadas fueron:
1) Generar un informe del estado del sistema (CPU – Memoria – Disco)  
2) Crear usuarios en el sistema  
3) Limpiar temporales y cachés

Este script se ejecuta en terminal y puede utilizarse tanto como usuario común (solo opción 1) como con permisos `sudo` (para todas las opciones).

---

## 2. Objetivo del Proyecto
- Automatizar tareas de administración de sistema usando Bash scripting.
- Cumplir con los lineamientos del TIF de Sistemas Operativos.
- Aplicar conceptos de terminal, permisos, ejecución como root y estructura organizativa de scripts.

---

## 3. Descripción de las funciones implementadas

### 3.1 Menú principal
Se utiliza un bucle `while true` que:
- Muestra opciones numeradas
- Captura una tecla para seleccionar opción (sin necesidad de Enter)
- Ejecuta la función asociada

### 3.2 Generar informe del sistema
Comandos utilizados:
- `lscpu` → Extrae datos del procesador
- `free -h` → Muestra memoria RAM
- `df -h` → Muestra almacenamiento en disco

Salida:  
Se guarda automáticamente un archivo `.log` dentro de `./logs/` con fecha y hora del informe.

### 3.3 Crear usuarios
Comandos utilizados:
- `useradd -m <usuario>`
- `passwd <usuario>`

Esta función requiere permisos de `sudo`.  
Si el usuario ya existe → se muestra advertencia y no se repite la creación.

### 3.4 Limpiar temporales / cachés
Comandos utilizados:
- `rm -rf /tmp/*`
- `apt-get clean`

Esta opción también requiere permisos de `sudo`.

---

## 4. Estructura del script

- Se definen colores (paleta bandera Argentina)
- Se muestra banner con ASCII art
- Se usa `read -rsn1` para capturar una tecla sin Enter
- Se generan logs con timestamp automático

Carpeta `logs/` es creada automáticamente por el script si no existe.

---

## 5. Pruebas realizadas

| Prueba | Resultado esperado | Resultado obtenido |
|--------|--------------------|-------------------|
| Ejecutar Opción 1 sin sudo | Debe funcionar | OK |
| Ejecutar Opción 2 sin sudo | Debe pedir privilegios | OK |
| Crear usuario existente | Debe advertir | OK |
| Generar múltiples informes | Debe crear varios logs | OK |

Capturas de funcionamiento fueron observadas en terminal ejecutando script.

---

## 6. Conclusiones personales
El proyecto permitió practicar:
- uso de comandos de administración real
- gestión de permisos
- estructura de scripts Bash
- interacción con usuario

Además se entendió la importancia de:
- registrar logs
- manejar errores
- validar permisos de ejecución

El trabajo final cumple la consigna y puede ampliarse fácilmente agregando más opciones de mantenimiento del sistema.

---

## 7. Trabajo Futuro / Mejoras posibles
- Agregar archivo de configuración externo (`tif.conf`)
- Incluir más limpiezas (snap cache / journal logging)
- Agregar backup automático previo a borrar temporales
- Exportar informe a JSON / CSV

---

## 8. Licencia y Referencias
Este proyecto se distribuye bajo Licencia MIT (ver archivo LICENSE).  
La documentación oficial consultada fue manpages de Linux (`man lscpu`, `man free`, `man df`, etc.).
