#!/bin/sh

echo "\n================== Git =================="

echo "\nEnter username for git config such as 홍길동_T4321:"
read name
git config --global user.name ${name}

echo "\nEnter email for git config:"
read email
git config --global user.email ${email}

echo "\n================== Ubuntu Package =================="

echo "apt-get update"
apt-get update -y

echo "Install zsh & set zsh as default shell"
apt-get install -y zsh

echo "Set zsh as default shell"
chsh -s `which zsh`

echo "Install Oh-my-zsh"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "Install libgl1-mesa-glx to fix ImportError on opencv library"
apt-get install -y libgl1-mesa-glx
apt-get install -y python3-opencv

echo "Install systemd"
apt-get install -y systemd
update-locale LANG="ko_KR.UTF-8"

echo "Install Korean language pack and fonts"
apt-get install -y language-pack-ko fonts-nanum fonts-nanum-coding fonts-nanum-extra

echo "Open zsh"
zsh

echo "Set LANG and LANGUAGE to ko_KR.UTF-8 on ~/.zshrc"
sed -i '1i export LANGUAGE=ko_KR.UTF-8' ~/.zshrc
sed -i '2i export LANG=ko_KR.UTF-8' ~/.zshrc
sed -i '3i \\' ~/.zshrc  # one line-break

echo "Set zsh theme with spaceship"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -e '/ZSH_THEME="robbyrussell"/ s/^#*/#/' -i ~/.zshrc   # Comment default theme
sed -i '4i ZSH_THEME="spaceship"' ~/.zshrc
sed -i '5i SPACESHIP_HOST_SHOW=false' ~/.zshrc
sed -i '6i SPACESHIP_DIR_TRUNC=0' ~/.zshrc
sed -i '7i SPACESHIP_DIR_PREFIX=' ~/.zshrc
sed -i '8i SPACESHIP_USER_PREFIX=' ~/.zshrc
sed -i '9i SPACESHIP_TIME_SHOW=true' ~/.zshrc
sed -i '10i SPACESHIP_PYTHON_SHOW=true' ~/.zshrc
sed -i '11i SPACESHIP_CONDA_SHOW=true' ~/.zshrc
sed -i '12i SPACESHIP_CONDA_COLOR=green' ~/.zshrc
sed -i '13i SPACESHIP_CONDA_PREFIX=' ~/.zshrc
sed -i '14i \\' ~/.zshrc  # one line-break

echo "\n================== Conda =================="

echo "Conda init zsh"
conda init zsh

echo "Update conda"
conda update -y -n base -c defaults conda

echo "Create conda environment named 'boostcamp'"
conda env create -f environment.yml

echo "Activate conda environment"
conda activate "boostcamp"

echo "Set boostcamp as default conda environment"
lineNum=`awk '/<<< conda initialize <<</{ print NR; exit }' ~/.zshrc`
sed -i "$((lineNum+1))i \\" ~/.zshrc  # one line-break
sed -i "$((lineNum+2))i # Set boostcamp as default conda environment" ~/.zshrc
sed -i "$((lineNum+3))i source activate boostcamp" ~/.zshrc

echo "\n================== Done =================="
