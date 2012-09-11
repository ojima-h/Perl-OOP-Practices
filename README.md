# Perlでオブジェクト指向を勉強するための課題

Perlを使ってオブジェクト指向開発をしてみましょう。

## 問題を解くための手順
0. （まだ持っていなかったら）githubのアカウントを作成する！
  * [こちら](http://d.hatena.ne.jp/shim0mura/20111212/1323660740)を参考にアカウントを設定をしてみて下さい
  * SSHの公開鍵設定はコードをgithub上に公開するために必要です
1. githubのこのプロジェクトをforkする
  * 以下のスクリーンショットにあるようなForkボタンを押せばフォーク終了です
![fork me](http://gyazo.com/aca6f59e81fe8086006b67af1f80055f.png?1347283698)
2. ローカルにgit cloneする！ 
![git clone](http://gyazo.com/7bcb121a773a6b29a99b81d1e596cfc3.png?1347284185)
3. 問題を解く！
4. $ perl main.pl を実行してみる！
5. 問題を解いたらgit commitする！
6. git pushする！
![git push](http://gyazo.com/eec8ba6e0543c482f5e12909d5f6c637.png)

## 問題一覧

### 問題1 : [アルゴリズムを変更可能なSorterクラス](https://github.com/ainame/Perl-OOP-Practices/blob/master/oop-for-perl.md#問題1)
### 問題2 : [オブジェクト指向版連結リスト](https://github.com/ainame/Perl-OOP-Practices/blob/master/oop-for-perl.md#問題2)
### 問題3 : [OOPでTwitterのようなモデル](https://github.com/ainame/Perl-OOP-Practices/blob/master/oop-for-perl.md#問題3オプション)

## 問題に取り組む際の注意点
* cdコマンドでsrcディレクトリ以下の書く問題のディレクトリに移動してから作業をして下さい
  * perl main.pl と実行する際に、lib/ディレクトリ以下に書いたクラスが読み込まれます
* ファイルを編集をしたらgitを活用して少しづつcommitしていきましょう
* 余裕があったら機能追加してみましょう
* ディレクトリ構成は以下のようになっています

``` text
|-- README.md
|-- oop-for-perl.md
`-- src
    |-- problem1     # 問題1のディレクトリ
    |   |-- lib      # 問題1のライブラリのpmファイルを書いて保存する場所
    |   `-- main.pl  # ライブラリをuseして実行するためのファイル
    |-- problem2     # 以下同様
    |   |-- lib
    |   `-- main.pl
    `-- problem3
        |-- lib
        `-- main.pl
```

## 参考資料
### Perl
* [perldoc.jp](http://perldoc.jp/)

### Git
* [イラストでわかる！git入門の入門 : アシアルブログ](http://blog.asial.co.jp/894)
* [デザイナのためのGit](https://github.com/hatena/Git-for-Designers)
* [try Git](http://try.github.com/): Web上でGitを体験できるサイトです


## 引用元
この問題集は、[はてなの教科書](https://github.com/hatena/Hatena-Textbook) から引用させていただいています。

## ライセンス
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/2.1/jp/88x31.png" /></a><br />この 作品 は <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/">クリエイティブ・コモンズ 表示 - 非営利 - 継承 2.1 日本 ライセンスの下に提供されています。</a>
