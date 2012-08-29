# Perl によるオブジェクト指向プログラミング

# 課題

## 課題1
この講義をふまえて、事前課題で作成したSorterクラスを改良・完成させてください。

### 以下再掲
以下のようなインターフェースをもつ、整数値を昇順にソートするソート器クラスをPerlを用いて実装してください。余裕がある人は、アルゴリズム別のSorterのサブクラスを実装してみてください。

``` perl
my $sorter = Sorter->new;
$sorter->set_values(5,4,3,2,1);
$sorter->sort;
$sorter->get_values # (1,2,3,4,5) が返ってくる
```

実装に際しては、以下の条件を守ってください。

* Perl組み込みのsort関数やソートを行うためのCPANモジュール を利用しない
* アルゴリズムはクイックソートを用いる

## 課題2
オブジェクト指向連結リスト My::List を作成してください。(C言語で良く使われる連結リストデータ構造を、オブジェクト指向Perlで書いた物、と思ってください。)

リストの各要素には任意のデータ (スカラー、オブジェクト、リファレンス etc) を保存できるものとします。連結リストはオブジェクト指向インタフェースを持ちます。リストの要素を先頭から手繰る(たぐる)のにイテレータを用意してください。

My::List のプログラムインタフェースは以下のようになるでしょう。例は、リストに "Hello" "World" "2008" という 3 つの文字列を保存して、イテレータでそれらを取り出し出力するコードです。

``` perl
my $list = My::List->new;

$list->append("Hello");
$list->append("World");
$list->append(2008);

my $iter = $list->iterator;
while ($iter->has_next) {
    print $iter->next->value;
}
```

リストの各要素は My::List 内に配列として保持するのではなく、ハッシュベースなリスト要素のオブジェクトをリファレンスで繋いだ連結リストとして保持する、という点に注意してください

* 連結リストがどのようなデータ構造か分からない場合は『定本 Cプログラマのためのアルゴリズムとデータ構造 (SOFTBANK BOOKS)』 P.50 - 66 を参照してください。(なお、連結リストなどはアルゴリズムとデータ構造の基礎ですので、その知識がない場合は本書籍を通読することをお薦めします。)
* イテレータについては『増補改訂版Java言語で学ぶデザインパターン入門』の第一章を参照してください。

両書籍とも、会社の本棚にあります。

## 課題3(オプション)
twitterもどきをつくろう。

以下のようなことができる小鳥オブジェクトを実装してください。

* 小鳥はつぶやくことができる
* 小鳥は他の小鳥をfollowできる
* 小鳥はfollowしている小鳥のつぶやきを見ることができる

いろいろな設計方法が考えられます。すっきりしたかっこいいのを考えてみましょう。
余裕があれば、mentions(@記法)やunfolllow や block、 lists などの機能も実装してみてください。

プログラムのインターフェースは自由です。例えば以下のようなインターフェースが考えられます。下の例では、SmallBirdクラスしか存在していませんが、つぶやき全体を管理するクラスがあっても良いかもしれません。Observerパターンを使ってみてもよいでしょう。

``` perl
use Bird;
my $b1 = Bird->new( name => 'jkondo');
my $b2 = Bird->new( name => 'reikon');
my $b3 = Bird->new( name => 'onishi');

$b1->follow($b2);
$b1->follow($b3);

$b3->follow($b1);

$b1->tweet('きょうはあついですね！');
$b2->tweet('しなもんのお散歩中です');
$b3->tweet('烏丸御池なう！');

my $b1_timelines = $b1->friends_timeline;
print $b1_timelines->[0]->message; # onishi: 烏丸御池なう!
print $b1_timelines->[1]->message; # reikon: しなもんのお散歩中です

my $b3_timelines = $b3->friends_timeline;
print $b3_timelines->[0]->message; # jkondo: 今日はあついですね！
```

## 課題に取り組む際の注意点

* できるだけテストスクリプトを書く
  * 少くとも動かして試してみることができないと、採点できません
  * 課題の本質的なところさえ実装すれば、CPANモジュールで楽をするのはアリ
  * 何が本質なのかを見極めるのも課題のうち
* 余裕があったら機能追加してみましょう
* 課題については以下の通り、ディレクトリを作成してコミットしてください。
  * pushするのを忘れずに!

``` text
intern/username/100802/exercise1
                      /exercise2
                      /exercise3
               /100803/exercise1
                      /exercise2
                      /  ...
                      /  ...
```
Perlの慣習として、以下のディレクトリ構成でコミットするといろいろ良いです。

``` text
.
|-- lib
|   `-- MyClass
|       `-- Foo.pm
`-- t
    `-- 00_base.t
```
* ライブラリを置くディレクトリはlib
* テストファイルを置くディレクトリはt
* テストスクリプトは prove -Ilib t で実行できます
* あるいはテストスクリプト単体を perl -Ilib t/00_base.t で実行します。

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/2.1/jp/88x31.png" /></a><br />この 作品 は <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/">クリエイティブ・コモンズ 表示 - 非営利 - 継承 2.1 日本 ライセンスの下に提供されています。</a>
