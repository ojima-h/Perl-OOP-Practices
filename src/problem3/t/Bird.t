#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More 'no_plan';
use Test::Deep;

BEGIN { use_ok 'Bird' }

new_ok('Bird');

my $b1 = Bird->new( name =>  'rejasupotaro');
my $b2 = Bird->new( name =>  'yuya_presto');
my $b3 = Bird->new( name =>  'ukayare');

can_ok($b1, qw( follow tweet friends_timeline));

$b1->follow($b2);
$b1->follow($b3);
$b3->follow($b1);

cmp_deeply($b1->followee, [ $b2, $b3 ], 'followee is collect');
cmp_deeply($b2->followee, [  ], 'followee is collect');
cmp_deeply($b3->followee, [ $b1 ], 'followee is collect');
cmp_deeply($b1->follower, [ $b3 ], 'follower is collect');
cmp_deeply($b2->follower, [ $b1 ], 'follower is collect');
cmp_deeply($b3->follower, [ $b1 ], 'follower is collect');

$b1->tweet('あなたもLispをはじめてみませんか？');
$b2->tweet('はじめてのつぶやき!');
$b2->tweet('9時58分か・・・いつも（の出社時間）より早い・・・');
$b3->tweet('彼女の為に働くための彼女がいない');

ok($b1->tweets->[0], 'あなたもLispをはじめてみませんか？');
ok($b2->tweets->[0], '9時58分か・・・いつも（の出社時間）より早い・・・');
ok($b3->tweets->[0], '彼女の為に働くための彼女がいない');

my $b1_timelines = $b1->friends_timeline;
can_ok($b1_timelines->[0], 'message');
cmp_ok($b1_timelines->[0]->message, 'eq', 'ukayare: 彼女の為に働くための彼女がいない');
cmp_ok($b1_timelines->[1]->message, 'eq', 'yuya_presto: 9時58分か・・・いつも（の出社時間）より早い・・・');
cmp_ok($b1_timelines->[2]->message, 'eq', 'yuya_presto: はじめてのつぶやき!', 'はじめてのつぶやき!');

my $b3_timelines = $b3->friends_timeline;
cmp_ok($b3_timelines->[0]->message, 'eq', 'rejasupotaro: あなたもLispをはじめてみませんか？');

