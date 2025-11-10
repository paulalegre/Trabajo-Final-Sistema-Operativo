# TIF – Sistemas Operativos (Bash)  
Trabajo final de **Sistemas Operativos**: script en Bash con menú para tres funciones principales:  
1. Generar informe de **CPU / Memoria / Disco** (guarda log)  
2. **Crear usuarios** del sistema  
3. **Limpiar temporales y cachés**

Este proyecto cumple con los requisitos del TIF: script Bash, documentación técnica (PDF), README con descripción, uso, colaboración y licencia, y archivos de apoyo (logs).

---

## 📦 Requisitos  
- Sistema operativo Linux (probado en distros basadas en Debian/Ubuntu)  
- Bash instalado  
- Para las opciones 2 y 3 requieren ejecutar como usuario con privilegios `sudo`  

---

## ▶️ Instalación / Ejecución  
```bash
git clone https://github.com/paulalegre/Trabajo-Final-Sistema-Operativo.git
cd Trabajo-Final-Sistema-Operativo
chmod +x tif.sh
./tif.sh            # Ejecutar solo la opción “Generar informe”
sudo ./tif.sh       # Para acceder también a “Crear usuario” y “Limpiar temporales”
