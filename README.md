# 日本語版 CLL 1.1 （非公式）

このリポジトリは CLL 1.1 を日本語に翻訳するプロジェクトです。
割と自己満足でやっています。

## README

これは [README](README) を翻訳したものです。

### README / Requirements （前提条件）

必要なのは、Docker （[https://docs.docker.com/install/#supported-platforms](https://docs.docker.com/install/#supported-platforms)）
またはpodman （[https://podman.io/getting-started/installation](https://podman.io/getting-started/installation)）と、
bashスクリプトを実行するいくつかの手段だけです。
これは、Linuxビルドプロセスであるにもかかわらず、
MacOSボックスでこれを実行できることを意味します。
（bashを取得する必要があるため）多少の困難はありますが、Windowsも可能です。

実際には、少なくとも2GiBの空きRAMが必要です。
さもなくば、Princeは狂ったようにスワップします。

ビルドは、利用可能なものに応じて、podman（推奨）またはdockerコンテナーで実行されます。

### README / Usage （使用方法）

すべてのバージョンを作成するには以下のコマンドを入力します：

```sh
  ./run_container.sh
```

これには、使用可能な CPU に比例して時間がかかることに注意してください。
AWS t2.micro では、 RAM が不足しているため、2時間以上たって断念しました。
AWS t2.medium では、約1時間かかりました。
RAMは重要な考慮事項です。
少なくとも 2GiB の空き容量が必要です。

最終的な結果は `build/` ディレクトリの下にあり、
さまざまな場所に散らばっています。
最終出力のみを別のディレクトリにコピーする場合、
つまり Web ディスプレイの場合は、
`-a` オプションを使用できます。
たとえば、次のようにします。

```sh
  ./run_container.sh -a output/
```

はすべての出力を `output/` ディレクトリに配置しますが、

```sh
  ./run_container.sh -a ~/public_html/cll_build/
```

はそれらを個人のウェブスペースに配置します。

完全なビルドを実行するにはかなりの時間がかかります（おそらく少なくとも1時間程度）。
テストを高速化するために、1つの章でそれを行うには次のコマンドを入力します：

```sh
  ./run_container.sh -t chapters/05.xml
```

これは本全体を行いますが、はるかに高速です：

```sh
  ./run_container.sh -t
```

以下のように、 `-T` で指定される多くの可能なサブターゲットもあります。

```sh
  ./run_container.sh -t -T pdf
```

次の方法でターゲットの完全なリストを取得できます。

```sh
  ./run_container.sh -h
```
