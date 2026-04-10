
# 🧰 Dotfiles Hyprland - Setup Arch Linux

Configuración personal de **Hyprland** optimizada para hardware Intel (HP EliteBook). Este repositorio automatiza el despliegue de un entorno de trabajo basado en Wayland, siguiendo principios de limpieza, escalabilidad y coherencia.

---

## 🚀 Instalación Full-Auto (Desde Arch Base)

Si acabas de instalar Arch Linux (mínimo), ejecuta este comando único para preparar el sistema y desplegar todo el entorno automáticamente:

```bash
sudo pacman -S --noconfirm git base-devel rust && git clone https://github.com/Alejandro0328/Miarch.git ~/Miarch && cd ~/Miarch && chmod +x packages.sh install.sh && ./packages.sh && ./install.sh
````

-----

## 🧠 ¿Qué incluye este setup?

Este repositorio automatiza la transición a un entorno de escritorio completo:

  * **Gestión de Paquetes:** Herramientas esenciales como `Kitty`, `Neovim`, `Waybar`, `Rofi` y `Dunst`.
  * **Soporte AUR:** Configuración de `yay` para paquetes de la comunidad (Google Chrome, etc.).
  * **Fondo de Pantalla:** Compilación e instalación de `swww` desde fuente para transiciones fluidas.
  * **Estética Dinámica:** Integración de `Pywal` para generar paletas de colores basadas en tu wallpaper.

-----

## ⚙️ Estructura del Proyecto

  * **`packages.sh`**: El motor del sistema. Instala dependencias oficiales y compila herramientas desde fuente.
  * **`install.sh`**: El arquitecto. Gestiona los enlaces simbólicos (symlinks) y la organización de carpetas en `~/.config`.
  * **`config/`**: Configuraciones modulares para cada componente (Hyprland, Mako, Waybar).
  * **`scripts/`**: Scripts de automatización para wallpapers y gestión de energía.

-----

## 🔄 Reset de Instalación

Si deseas limpiar el sistema para realizar una instalación desde cero nuevamente, utiliza este comando:

```bash
cd ~ && rm -rf ~/Miarch ~/.config/hypr ~/.config/kitty ~/.config/waybar ~/.config/swww ~/.config/neovim ~/.config/zsh ~/.cache/swww ~/.cache/wal /tmp/swww && sudo pacman -Rs --noconfirm rust
```

-----

## 🖼️ Personalización Visual

Para cambiar el fondo de pantalla y actualizar los colores del sistema instantáneamente:

```bash
bash ~/Miarch/scripts/wallpaper.sh
```

-----

## 📌 Requisitos

  * **Sistema:** Arch Linux (Instalación limpia).
  * **Usuario:** Permisos de `sudo` configurados.
  * **Hardware:** Probado en Intel Core i5 8th Gen.

-----

## 🔥 Filosofía

Desarrollado bajo los valores de **Coherencia, Lealtad y Respeto**. El objetivo es crear una arquitectura de software donde cada archivo de configuración tenga un propósito claro.

**Autor:** [Miguel Alejandro](https://www.google.com/search?q=https://github.com/Alejandro0328)

```



¡Cópialo, pégalo en tu `README.md` y dale ese `push` a GitHub! ¿Listo para la prueba de fuego en la otra PC?
```
