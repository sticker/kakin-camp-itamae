Overview
========

課金キャンペーンチームのItamaeリポジトリです。

Repository Directories
======================

~~~
kakin-camp.itamae
  ├ cookbooks/          - クックブックを格納する
  │   └ non_base/       - NoN初期設定用
  │        └ templates  - NoN初期設定用テンプレートを格納する
  ├ nodes/              - 各ホストごとの設定情報をjson形式で格納する
  ├ roles/              - レシピをまとめたロールを格納する
  ├ entrypoint.rb       - Itamaeから実行されるレシピのエントリポイント
  ├ Gemfile             - Itamaeプラグインなどの依存が書かれたGemfile
  ├ install_itamae.sh   - Itamaeをインストールするスクリプト（install_itamae_rpm.shへのリンク）
  ├ install_itamae_rpm.sh     - Itamaeをインストールするスクリプト（バイナリRPMからインストール）
  └ install_itamae_rbenv.sh   - Itamaeをインストールするスクリプト（rbenvからインストール）
~~~
