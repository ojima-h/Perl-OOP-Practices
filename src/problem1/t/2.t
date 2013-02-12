#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

use Test::More 'no_plan';
use Test::Deep;

require Sorter::MergeSorter;

my @cases = (
  [[0, 0, 0, 1, 3, 2, 4, 0, 0], 2, 5, 7, [0, 0, 0, 1, 2, 3, 4, 0, 0]],
  [[0, 2, 1, 0], 1, 2, 3, [0, 1, 2, 0]],
  [[0, 2, 1, 3], 0, 0, 4, [0, 2, 1, 3]],
);

for my $case (@cases) {
  my ($array, $start, $mid, $end, $expected) = @$case;
  Sorter::MergeSorter::_merge($array, $start, $mid, $end);
  cmp_deeply($array, $expected, 'collectly merged');
}
