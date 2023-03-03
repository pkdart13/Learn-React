#!/bin/bash
echo "Adding User"
PIN="123456"
createuser ()
{
    useradd -m user
    useradd user sudo
    echo 'user:root' | sudo chpasswd
    sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
    echo "create user completed"
}
createuser
install ()
{
    sudo apt update
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    apt install --assume-yes xfce4 desktop-base xfce4-terminal
    bash -c 'echo \"exec /etc/X11/Xsession /usr/bin/xfce4-session\" > /etc/chrome-remote-desktop-session'
    apt remove --assume-yes gnome-terminal
    apt install --assume-yes xscreensaver
    systemctl disable lightdm.service
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg --install google-chrome-stable_current_amd64.deb
    apt install --assume-yes --fix-broken
}
install
echo "install comple enter crd"
read CRD
adduser user chrome-remote-desktop
CRDI="$CRD --pin=$PIN"
su - user -c '$CRDI'
