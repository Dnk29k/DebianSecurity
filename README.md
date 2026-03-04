# 🛠️ Arquitectura "Phoenix" - Debian Pentest Environment
> **High-Performance Security OS Deployment**

![Phoenix Banner](assets/banner.png) ## 📋 Contexto de Alto Rendimiento
Este repositorio contiene la configuración integral (Dotfiles + Arsenal) para una estación de trabajo de ciberseguridad basada en **Debian 12 "Naked"**. Optimizada específicamente para entornos virtualizados de alto rendimiento.

* **Host:** Ryzen 7 5800X | RTX 3060 Ti
* **Guest (MV):** Debian 12 | 8GB RAM | 6 Cores
* **Stack UI:** `bspwm` + `sxhkd` + `Polybar` (Islas) + `Picom` (GLX/Kawase)
* **Identidad:** Usuario `dnk29` con sincronización total en entorno `root`.

---

## 🏗️ 1. Ingeniería de Estructura (Modular)
La jerarquía del repositorio sigue estándares profesionales para permitir despliegues parciales o totales:

* **`core/`**: Scripts maestros de instalación y configuración del sistema base.
* **`configs/`**: Organización espejo de `~/.config/` (bspwm, polybar, kitty, etc.).
* **`scripts/`**: Inteligencia de la barra (VPN dinámica, IPs, gestión de energía).
* **`bin/`**: Herramientas personalizadas y ejecutables rápidos (`nxc`, `updog`).
* **`security/`**: Gestión de diccionarios, configs de BurpSuite y herramientas de hacking.
* **`assets/`**: Recursos visuales, fuentes (Hack Nerd Font) y wallpapers.

---

## 🚀 2. Despliegue Automático (setup.sh)
El script de instalación incluye lógica de autocuración y **Escudo contra Fallos**:

### Pre-flight Checks
* Verificación de conectividad, privilegios `sudo` y versión de Debian.
* Configuración de ramas `main`, `contrib` y `non-free-firmware`.

### Escudo de Dependencias (Anti-Errores)
* **Python VENV:** Crea un entorno virtual global en `~/tools/venv_pentest` para evitar el error de *"externally-managed environment"* de Debian 12.
* **BurpSuite Auto-Link:** Detección inteligente del binario en `/opt/` y creación del symlink en `/usr/local/bin/`.
* **Wordlists Manager:** Script de verificación y descarga automática de `rockyou.txt` en `/usr/share/wordlists/`.

---

## 📡 3. Networking Dinámico (Isla de Conectividad)
Módulos de Polybar 100% agnósticos al hardware (No más errores de `ens33`/`eth0`):

1.  **Módulo IP:** Extracción dinámica mediante `ip route get 1.1.1.1` para obtener la interfaz de salida real.
2.  **Isla VPN Triple (Priorizada):**
    * **Prioridad 1:** `tun0` (HackTheBox) -> Icono 󰆧 + IP.
    * **Prioridad 2:** `nordlynx`/`tun1` (NordVPN) -> Icono  + IP.
    * **Prioridad 3:** Red Local -> Icono 󰈀 + IP.
    * **Fallo:** "Disconnected" con estilo minimalista en color `%F{#f7768e}`.

---

## 💀 4. El "Inventario de Guerra" (Log de Supervivencia)
Tabla de soluciones aplicadas a errores críticos encontrados durante la fase de desarrollo:

| Herramienta | Error Conocido | Solución Phoenix Aplicada |
| :--- | :--- | :--- |
| **NetExec (nxc)** | Distribution not found / Repo 404 | Instalación directa via `pipx install git+https://github.com/Pennyw0rth/NetExec` |
| **BurpSuite** | Command not found | Symlink manual `/usr/local/bin/burpsuite -> /opt/BurpSuiteCommunity/` |
| **Polenum** | Obsoleto / Dependencias rotas | Sustitución por el módulo nativo de `nxc smb --pass-pol` |
| **Python 3.11** | Externally Managed Environment | Abstracción total mediante `pipx` y `venv` |

---

## 🔄 5. Sincronización Inversa (sync.sh)
Mantenimiento sencillo del repositorio mediante un script de "ida y vuelta":
1.  Detecta cambios locales en `~/.config/`.
2.  Actualiza las carpetas del repositorio local automáticamente.
3.  Prepara los archivos para un `git push` limpio.

---

## 🔐 Protección de Datos (Secrets)
Este repositorio utiliza un archivo `secrets.example`. 
> **IMPORTANTE:** Nunca subas tus tokens de HTB o credenciales de VPN. Renombra `secrets.example` a `.secrets` y el sistema lo ignorará mediante `.gitignore`.

---

## 🛠️ Instalación en un paso
```bash
curl -sS [https://raw.githubusercontent.com/Dnk29k/DebianSecurity/main/core/setup.sh](https://raw.githubusercontent.com/Dnk29k/DebianSecurity/main/core/setup.sh) | bash
