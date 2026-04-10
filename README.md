
# 🧰 Dotfiles Hyprland - Setup Arch Linux

Configuración personal de **Hyprland** en Arch Linux con un sistema de instalación automatizado diseñado para eficiencia y coherencia.

---

## 🚀 Instalación (una sola línea)

Si acabas de instalar Arch Linux, ejecuta este comando para desplegar todo tu entorno automáticamente:

```bash
git clone [https://github.com/Alejandro0328/Miarch.git](https://github.com/Alejandro0328/Miarch.git) ~/Miarch && cd ~/Miarch && chmod +x packages.sh install.sh && ./packages.sh && ./install.sh
```

---

## 🧠 ¿Qué hace este repositorio?

Este setup transforma una instalación base de Arch en un entorno de trabajo completo:

* **Instalación de paquetes base:** Herramientas esenciales de sistema y multimedia.
* **Gestión de AUR:** Configuración automática de `yay`, Google Chrome y Pywal.
* **Sincronización de configuraciones:**
  * **Hyprland:** El cerebro del entorno (compositor).
  * **Kitty:** Terminal configurada con soporte para colores dinámicos.
  * **Neovim:** Editor de texto optimizado (`init.vim`).
  * **Zsh:** Shell personalizada con integración de `pywal`.
* **Personalización Visual:** Gestión de wallpapers y animaciones con `swww`.

---

## 📦 Contenido del Sistema

### 🔹 Core & Multimedia
* **Terminal:** Kitty
* **Editor:** Neovim
* **Barra/Notificaciones:** Waybar, Dunst
* **Lanzador:** Rofi
* **Capturas:** Grim + Slurp (con soporte de área)

### 🔹 Automatización de Scripts
1. **`packages.sh`**: Maneja la instalación de paquetes desde los repositorios oficiales y AUR. Compila `swww` desde el código fuente para asegurar todas las transiciones.
2. **`install.sh`**: Distribuye tus archivos de configuración (`.config`, `.zshrc`) y prepara los scripts de usuario.

---

## 🖼️ Estructura de Archivos

El sistema se organiza bajo el siguiente árbol de directorios:

```text
~/Miarch/
├── config/           # Archivos de configuración (Hyprland, Kitty, Nvim, etc.)
├── home/             # Configuraciones del usuario (.zshrc)
├── scripts/          # Scripts personalizados (wallpaper.sh)
├── wallpapers/       # Galería de fondos personales
├── packages.sh       # Instalador de software
└── install.sh        # Instalador de configuraciones
```

---

## 🎨 Personalización y Colores

El sistema utiliza **Pywal** para generar esquemas de colores basados en el wallpaper actual. Para cambiar el fondo y los colores de la terminal simultáneamente, usa el script incluido:

```bash
bash ~/.config/hypr/scripts/wallpaper.sh
```

---

## 🔧 Notas de Hardware
* Optimizado para **HP EliteBook** (Gráficos Intel i5 8th Gen).
* Utiliza el formato `xrgb` en el daemon de `swww` para asegurar estabilidad en drivers Intel.

---

## ⚠️ Requisitos
* Instalación base de Arch Linux.
* Usuario con privilegios de **sudo**.
* Conexión a internet activa.

---

## 🔥 Autor

**Miguel Alejandro** *Arquitecto de soluciones en desarrollo.*

