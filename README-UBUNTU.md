# 前提条件をインストールする

```
sudo apt-get install wget xsltproc xmlto fonts-dejavu fonts-linuxlibertine unifont ruby-full zip unzip default-jdk`
gem install bundler
bundle install

#epub libをインストールします：
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
#Xvfb and xvfb-run (fake X for calibre) or a running X server session -- MAYBE NOT ACTUALLY NEEDED

sudo apt-get install python-pip
sudo apt-get install xvfb xserver-xephyr vnc4server
sudo pip install pyvirtualdisplay
# オプション
sudo apt-get install python-pil scrot
sudo pip install pyscreenshot

# プラットフォーム用のPrinceを https://www.princexml.com/download/ からインストールします
# 例：
wget https://www.princexml.com/download/prince_12.5-1_ubuntu18.04_amd64.deb
sudo apt install ./prince_12.5-1_ubuntu18.04_amd64.deb
```



他のライブラリが必要な場合があります。 問題を見つけたら、開いてください。

# 編纂

すべてのバージョンを作成するには以下のコマンドを打ちます：

`./cll_build`

最終結果は、さまざまな場所に散在する build/ ディレクトリの下に配置されます。
最終出力のみを別のディレクトリにコピーする場合は、-aオプションを使用できます。
たとえば、次のようなコマンドを打ちます：

`./cll_build -a output/`

とコマンドを打った場合、すべての出力を output/ ディレクトリに配置しますが、

`./cll_build -a ~/public_html/cll_build/`

とコマンドを打った場合、あなたの個人的なウェブスペースにそれらを置きます。

完全なビルドの実行にはかなりの時間がかかります（おそらく少なくとも1時間）。
迅速なテストのためにたった1つの章でそれを行うには以下のコマンドを打ちます：

`./cll_build -t chapters/05.xml`

以下のコマンドは本全体を行いますが、はるかに高速です：

`./cll_build -t`

以下のような、-Tで指定された多くのサブターゲットもあります：

`./cll_build -t -T pdf`

次の方法でターゲットの完全なリストを取得できます：

`./cll_build -h`
