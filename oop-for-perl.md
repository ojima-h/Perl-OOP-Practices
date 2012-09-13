# Perl によるオブジェクト指向プログラミング

# 問題集

## 問題1
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

## 問題2
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

## 問題3(オプション)
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
my $b1 = Bird->new( name =>  'rejasupotaro');
my $b2 = Bird->new( name =>  'yuya_presto');
my $b3 = Bird->new( name =>  'ukayare');

$b1->follow($b2);
$b1->follow($b3);

$b3->follow($b1);

$b1->tweet('あなたもLispをはじめてみませんか？');
$b2->tweet('9時58分か・・・いつも（の出社時間）より早い・・・');
$b3->tweet('彼女の為に働くための彼女がいない');

my $b1_timelines = $b1->friends_timeline;
print $b1_timelines->[0]->message; # ukayare: 彼女の為に働くための彼女がいない
print $b1_timelines->[1]->message; # yuya_presto: 9時58分・・・いつも（の出社時間）より早い・・・

my $b3_timelines = $b3->friends_timeline;
print $b3_timelines->[0]->message; # rejasupotaro: あなたもLispをはじめてみませんか？
```

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/2.1/jp/88x31.png" /></a><br />この 作品 は <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/2.1/jp/">クリエイティブ・コモンズ 表示 - 非営利 - 継承 2.1 日本 ライセンスの下に提供されています。</a>
