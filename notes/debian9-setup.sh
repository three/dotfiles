#!/usr/bin/env bash

set -e
set -u

# Update and install packages
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install vim htop rtorrent sudo tmux git zsh

# Setup User "eric"
useradd eric -m
cat <<EOT >>/etc/sudoers

# From debian-setup.sh
eric    ALL=(ALL) NOPASSWD:ALL
EOT
chsh -s /usr/bin/zsh eric
pushd /home/eric
sudo -u eric git clone https://github.com/three/dotfiles.git dotfiles
cd dotfiles
sudo -u eric git submodule update --init --recursive
cd ..
sudo -u eric tee /home/eric/.zshrc <<EOT
export DOTFILES="\$HOME/dotfiles"
source "\$DOTFILES/shell/zsh.sh"
EOT
sudo -u eric mkdir -p /home/eric/.ssh
chmod 700 /home/eric/.ssh
sudo -u eric ssh-keygen -t rsa -b 4096 -N "" -f /home/eric/.ssh/id_rsa
sudo -u eric tee -a /home/eric/.ssh/authorized_keys <<EOT
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEA3mhRZhv00bxA7iZ09bZRtFZEHNlKZaz5jixqLftEQt2F/THmD4Z4c3WVTCb2QqOrPU0JJANxwwrqno9UewxmbcItwCZr5d9/hgHtpmeNKn0MOecURY95UQCxuIyhHFyIL6n9szQcCNWowbTZgMS1792zwrhWg0MQDz0TLZibg0uB74w6Z3JzCigf8lFjn3BpwabyotuBiciZ89Gdax83/XmiWepuB9SsnlcXCaGTfomDCvG7hdbI/5kEAOXaWFOPpkbIIUrp+lpJOdc3TSAr2hbIqaoyFZ94Z9UH5xfcpNQff63fTTVCUyuuYpRZ3j1kfw3XWeiQNEHXNpdcWo87ilbyK3WxOiFfS4bX7/rvgTl2hUdb6HaMhWI0OHfbo2/e06AwSoWQlyU5Noc9bzfIyji3ou0uydGfY5F6umDvO4HMEiAO4K8qNHEPNrZAXdPxuZtQIaV9mAHoNzEWX5aE3/YOWPBoimAqX9JDNfzLDiE7h1sFfzNBgOGvEaV+yd5mpDiNjya0zDn+klb/ZFqvcPoZsmUYXRw/VzXtMv9bg5oVOWkv/BhVVdGXmEdLwrLGrvQYNfJhjh5eQAkdFJz8WVGJblpqRVAqoRNIwB2jaBlnnx3ZJQhx6nr+GKOCi8h3+eOCHNaDBC8s1OJuPq9P/bGmF/vSg+EK2xAZkgQ8DaM= imported-openssh-key
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCmdieVaws+QxU/MMvGAtJBtYuqbK+ysngRJC8lgmGwkI/z90DJUzy6xv020q0V+ZBQXIxu0ZhLeLZCtKTax4F9lL76QQ1mV0RAuHrbpNh1BYtXJgqhw/OlxU9jDoggnShj7avjRNS6wl0wJQl6sQ0E3UFsTP0UNZFCuktrkpL7GuX/+w6u/r3KDPJRBu2NG65YIVIW3xwMfWS3f3nn8iZO4WEduOHEc3NvI+U6ript5c7lTVrqMmAz8yLA9SHbiV3BZ4DBuNM95Qpx2L9kr3KRUz8rs3BRFIZUefuJhxAMy3+yx6BvKerT7SM3imCY1f0WGcukULMsK4vsaI0/zJlk59yeJlw/zFC56UzGneHnQVlpj6D5G2GjubUoP69+AXGiBI3JGRwKThynElLNgbD3LaCCuooePPEhPqN4FHRvljby8bgsEOgCqjMALU3LLbHQBzQSXY6ONGLFccll0livabtDNd75cYjPK+KQ1La3d0RyT6AodChgTutLqZLvOPhqM2839BlvCC5f2ss693kffGGZuSq0CbWRfD0iJCmXnPalVqTvDD3Mfk0KMrnS6u6GGZdrgtdBA+27+TeRSAEQ8/NuZlQVypz63DYf73iuPtg30beQ2XrD2SjeJRSBahu5QYe5iQFrgYe/tXGcPpYxlVH5uTvqDkMyfXSQwvo9tw== eric@threedot14.com
EOT
chmod 640 /home/eric/.ssh/authorized_keys
sudo -u eric ln -s dotfiles/tmux/tmux2.conf .tmux.conf
sudo -u eric ln -s dotfiles/vim/ .vim
