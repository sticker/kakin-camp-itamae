#!/bin/sh

# yumリポジトリ追加
yum install -y centos-release-SCL epel-release

# 依存ライブラリをインストール
yum -y groupinstall "Development Tools"
yum install -y wget rpm-build git readline-devel ncurses-devel gdbm-devel openssl-devel libyaml-devel libffi-devel zlib-devel

# rubyをパッケージインストール
rpm -Uvh https://github.com/feedforce/ruby-rpm/releases/download/2.2.4/ruby-2.2.4-1.el6.x86_64.rpm

cat << 'EOS' > ~/.gemrc 
gem: --no-document
EOS

# bundlerインストール
gem install bundler

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
