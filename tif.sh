#!/usr/bin/env bash

# ===== PALETA ARGENTINA =====
RESET="\e[0m"; BOLD="\e[1m"
CELESTE="\e[38;5;111m"
BLANCO="\e[38;5;15m"
SOL="\e[38;5;220m"
RED="\e[31m"; GREEN="\e[32m"

# ===== BANNER (solo en el menú principal) =====
banner() {
  clear
  echo -e "${BOLD}${CELESTE}"
  echo "██████████████████████████████████████████████████"
  echo -e "${BLANCO}█                                                █"
  echo -e "${BLANCO}█   ███████╗██╗███╗   ██╗ █████╗ ██╗             █"
  echo -e "${BLANCO}█   ██╔════╝██║████╗  ██║██╔══██╗██║             █"
  echo -e "${CELESTE}█   █████╗  ██║██╔██╗ ██║███████║██║             █"
  echo -e "${CELESTE}█   ██╔══╝  ██║██║╚██╗██║██╔══██║██║             █"
  echo -e "${CELESTE}█   ██║     ██║██║ ╚████║██║  ██║███████╗        █"
  echo -e "${CELESTE}█   ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝        █"
  echo -e "${BLANCO}█                                                █"
  echo -e "${BLANCO}█      SISTEMAS OPERATIVOS – TRABAJO FINAL       █"
  echo -e "${SOL}█                    ★  ★  ★                     █"
  echo -e "${CELESTE}██████████████████████████████████████████████████${RESET}"
}

# ===== helpers =====
press_enter(){ echo -e "${CELESTE}\nPresiona Enter para continuar...${RESET}"; read -r; }
REPORT_DIR="logs"; mkdir -p "$REPORT_DIR"
logfile(){ echo "$REPORT_DIR/tif_$(date +%Y%m%d_%H%M%S).log"; }

require_root(){
  if [[ "$EUID" -ne 0 ]]; then
    echo -e "${RED}Necesitas ejecutar con sudo${RESET}"
    return 1
  fi
}

# ===== OPCIÓN 1 =====
generar_informe(){
  out=$(logfile)
  {
    echo "===== INFORME DEL SISTEMA ====="
    echo "Fecha: $(date)"
    echo
    echo "---- CPU ----"
    lscpu | grep "Model name"
    echo
    echo "---- MEMORIA ----"
    free -h
    echo
    echo "---- DISCO ----"
    df -h
  } | tee "$out"
  echo -e "${GREEN}\n✅ Informe generado: $out${RESET}"
}

# ===== OPCIÓN 2 =====
crear_usuario(){
  require_root || { press_enter; return; }
  read -rp "Nombre de usuario a crear: " USERNAME
  if id "$USERNAME" &>/dev/null; then
    echo -e "${SOL}⚠ Ya existe ese usuario${RESET}"
    press_enter; return
  fi
  useradd -m "$USERNAME"
  echo "Ingresa contraseña para $USERNAME:"
  passwd "$USERNAME"
  echo -e "${GREEN}\n✅ Usuario creado: $USERNAME${RESET}"
}

# ===== OPCIÓN 3 =====
limpiar_temporales(){
  require_root || { press_enter; return; }
  rm -rf /tmp/* 2>/dev/null || true
  apt-get clean >/dev/null 2>&1 || true
  echo -e "${GREEN}\n✅ Temporales y cache limpiados${RESET}"
}

# ===== MENÚ =====
while true; do
  banner
  echo -e "${CELESTE}${BOLD}──────────────────────────────────────────────────${RESET}"
  echo -e "   ${CELESTE}[1]${RESET} ${BLANCO}Generar informe${RESET}"
  echo -e "   ${CELESTE}[2]${RESET} ${BLANCO}Crear usuario${RESET}"
  echo -e "   ${CELESTE}[3]${RESET} ${BLANCO}Limpiar temporales${RESET}"
  echo -e "   ${CELESTE}[0]${RESET} ${BLANCO}Salir${RESET}"
  echo -e "${CELESTE}${BOLD}──────────────────────────────────────────────────${RESET}"
  echo

  echo -ne "${BLANCO}Opción: ${RESET}"
  read -rsn1 op
  echo

  case "$op" in
    1) generar_informe; press_enter ;;
    2) crear_usuario;  press_enter ;;
    3) limpiar_temporales; press_enter ;;
    0) echo -e "${CELESTE}¡Hasta luego!${RESET}"; exit 0 ;;
    *) echo -e "${RED}Opción inválida${RESET}"; press_enter ;;
  esac
done

