#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

use Test::More 'no_plan';

BEGIN { use_ok 'My::List' }

new_ok('My::List');
my $list = My::List->new;

can_ok($list, qw( append iterator ));

$list->append("Hello");
$list->append("World");
$list->append(2008);

my $iter = $list->iterator;

can_ok($iter, qw( has_next next ));

ok($iter->has_next);

my $next = $iter->next;
can_ok($next, 'value');

is($next->value, "Hello");

for my $value ("World", 2008) {
  $next = $iter->next;
  is($next->value, $value);
}

ok(not $iter->has_next);
