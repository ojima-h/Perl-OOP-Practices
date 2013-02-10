#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

use Test::More;
use Test::Deep;

BEGIN { use_ok 'Sorter' }

#
# Sorter
#
new_ok('Sorter');
my $sorter = Sorter->new;

can_ok($sorter, $_) for qw/set_values sort get_values/;
$sorter->set_values(5, 4, 1, 3, 2);
$sorter->sort;

cmp_deeply($sorter->get_values, [1, 2, 3, 4, 5]);

done_testing;
