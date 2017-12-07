#!/bin/sh

# yumリポジトリにepel追加
yum install -y epel-release

# 依存ライブラリをインストール
yum -y groupinstall "Development Tools"
yum --enablerepo=epel -y install openssl-devel readline-devel zlib-devel libcurl-devel bzip2 tar

# anyenv / rbenvをインストール
git clone https://github.com/riywo/anyenv /usr/local/anyenv
echo 'export PATH="/usr/local/anyenv/bin:$PATH"' >> ~/.bash_profile
echo 'export ANYENV_ROOT=/usr/local/anyenv' >> ~/.bash_profile
echo 'eval "$(anyenv init -)"' >> ~/.bash_profile
. ~/.bash_profile

anyenv install rbenv
. ~/.bash_profile

# rubyダウンロードで失敗するため、libcurlをアップデート
rpm -ivh http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel6.noarch.rpm
yum -y update --enablerepo=city-fan.org libcurl

# rubyインストール
VERSION=$(rbenv install --list | grep 2 | grep -v r | grep -v mag | grep -v dev | tail -1)
rbenv install $VERSION
rbenv global $VERSION

# bundlerインストール
gem install bundler

# itamaeインストール
gem install itamae
