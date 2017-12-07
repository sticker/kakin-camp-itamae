#!/bin/sh

# yumリポジトリにepel追加
rpm -ivh http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm

# 依存ライブラリをインストール
yum -y groupinstall "Development Tools"
yum --enablerepo=epel -y install libyaml libyaml-devel readline-devel ncurses-devel gdbm-devel tcl-devel openssl-devel db4-devel libffi-devel wget

# rbenvをインストール
cd /usr/local
git clone https://github.com/sstephenson/rbenv.git rbenv
mkdir rbenv/shims rbenv/versions rbenv/plugins
groupadd rbenv
chgrp -R rbenv rbenv
chmod -R g+rwxX rbenv

# ruby-build のインストール
cd /usr/local/rbenv/plugins
git clone https://github.com/sstephenson/ruby-build.git ruby-build
chgrp -R rbenv ruby-build
chmod -R g+rwxs ruby-build

# rbenv-default-gems のインストール
git clone https://github.com/sstephenson/rbenv-default-gems.git rbenv-default-gems
chgrp -R rbenv rbenv-default-gems
chmod -R g+rwxs rbenv-default-gems

# 環境変数設定
cat << 'EOS' > /etc/profile.d/rbenv.sh
export RBENV_ROOT="/usr/local/rbenv" 
export PATH="$RBENV_ROOT/bin:$PATH" 
eval "$(rbenv init -)" 
EOS

# デフォルトでインストールするgemの指定
cat << 'EOS' > /usr/local/rbenv/default-gems
bundler
rbenv-rehash
EOS

# 設定の反映
source /etc/profile.d/rbenv.sh

# rubyインストール
rbenv install -s 2.2.4
rbenv global -s 2.2.4

# itamaeインストール
mkdir -p /var/itamae
cd /var/itamae
cat << 'EOS' > /var/itamae/Gemfile
source 'https://rubygems.org'

gem 'json_pure'
gem 'json'
gem 'itamae'
EOS

bundle install --gemfile=/var/itamae/Gemfile --path /var/itamae/vendor/bundle
gem install itamae
