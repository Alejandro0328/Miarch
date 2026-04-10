# 🧰 Dotfiles Hyprland - Setup Arch Linux

Configuración personal de **Hyprland** en Arch Linux con instalación automatizada.

---

## 🚀 Instalación rápida

```bash
git clone https://github.com/Alejandro0328/Miarch.git
cd Miarch
chmod +x packages.sh install.sh
./packages.sh
./install.sh
```

---

## 🧠 ¿Qué hace este repositorio?

Este setup automatiza completamente:

* Instalación de paquetes base
* Instalación de AUR (yay, google-chrome, pywal)
* Configuración de:

  * Hyprland
  * Kitty
  * Neovim
  * Zsh
* Aplicación de wallpapers con `swww`
* Gestión de scripts personalizados

---

## 📦 Requisitos

* Instalación mínima de Arch Linux
* Conexión a internet
* Usuario con permisos sudo

---

## ⚙️ Scripts

### 🔹 packages.sh

Instala todo el entorno:

* Pacman packages:

  * neovim
  * zsh
  * kitty
  * waybar
  * rofi
  * dunst
  * git
  * base-devel
  * grim
  * slurp

* AUR:

  * yay
  * google-chrome
  * python-pywal
  * swww

---

### 🔹 install.sh

Aplica la configuración:

* Crea symlinks en `~/.config`
* Hace backup de archivos existentes
* Aplica `.zshrc`
* Da permisos a scripts
* Ejecuta wallpaper automáticamente

---

## 🖼️ Wallpapers

Ubicados en:

```bash
~/dotfiles/wallpapers/
```

Script:

```bash
~/dotfiles/scripts/wallpaper.sh
```

Puedes cambiar el fondo editando ese archivo.

---

## 🧪 Testing

Ejecutar manualmente:

```bash
bash ~/dotfiles/scripts/wallpaper.sh
```

Verificar symlinks:

```bash
ls -l ~/.config
```

---

## 🔧 Personalización

Edita:

```bash
config/
home/.zshrc
scripts/
wallpapers/
```

---

## ⚠️ Notas

* Este setup está pensado para uso personal
* Puede requerir ajustes según hardware
* Se recomienda revisar scripts antes de ejecutar

---

## 🧠 Filosofía

* Simplicidad
* Reproducibilidad
* Control total del sistema

---

## 📌 Uso en nueva instalación

```bash
cd ~/Miarch && chmod +x packages.sh install.sh && ./packages.sh && ./install.sh
```

---

## 🔥 Autor

Configuración personalizada para flujo de trabajo en Hyprland + Arch Linux
