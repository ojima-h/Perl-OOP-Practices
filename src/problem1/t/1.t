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

for my $mode (qw( QuickSorter QuickSorterNoSwap HeapSorter PacketSorter )) {
  my $sorter = Sorter->new($mode);

  can_ok($sorter, qw(set_values sort get_values));
  $sorter->set_values(5, 4, 1, 3, 2);
  $sorter->sort;

  cmp_deeply($sorter->get_values, [1, 2, 3, 4, 5], "Sorting by $mode");
}

done_testing;
