use strict;
use warnings;

# ライブラリのロードパスを設定
use File::Basename;
use lib dirname(__FILE__).'/lib';
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
