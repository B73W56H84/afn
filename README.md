# あふん






## セットアップ

出題用の画像ファイルを JSON ファイルに追加する。

### pngquant のインストール

`pngquant` をインストールする。

    $ brew install pngquant

### 元画像の配置

`images/` ディレクトリに `[0-9]{4}_●●.(jpg|png)` ファイルを配置する。

### 画像サイズ変更

100x100 ピクセルの PNG ファイルが `images/temp/` にできる。

    $ bash bin/000.image.sh

### JSON ファイル出力

出題用のJSONファイルを生成

    $ node bin/010.image.js > data/ico.json
