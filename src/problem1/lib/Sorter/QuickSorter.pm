#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

package Sorter::QuickSorter;

sub _pivot {
  my ($array, $from, $to) = @_;
  $array->[$from]
}
sub _swap {
  my ($array, $i, $j) = @_;
  ($array->[$i], $array->[$j]) = ($array->[$j], $array->[$i]);
}

sub sort {
  my $array = shift;
  _sort($array, 0, $#{ $array });
}

sub _sort {
  my ($array, $from, $to) = @_;

  if ($from == $to) {
    return;
  } else {
    my $pivot = _pivot($array, $from, $to);

    my $split;
    # find $split such that
    #   $array->[$from  .. $split-1] -- not greater than $pivot
    #   $array->[$split .. $to     ] -- not less than $pivot
    {
      my ($f, $t) = ($from, $to);
      my ($pivot_index_left, $pivot_index_right);
      while (1) {
        while ($array->[$f] <= $pivot and $f < $t) {
          $pivot_index_left = $f if $array->[$f] == $pivot;
          $f++;
        }

        if ($f == $t) {
          if ($array->[$t] < $pivot) {
            _swap($array, $pivot_index_left, $t);
          }
          $split = $f;
          last;
        }

        # when $array->[$f] > $pivot and $f < $t
        while ($array->[$t] >= $pivot and $f < $t) {
          $pivot_index_right = $t if $array->[$t] == $pivot;
          $t--;
        }

        if ($f == $t) {
          if ($pivot_index_right) {
            _swap($array, $pivot_index_right, $f);
            $split = $f + 1;
          } else {
            # When $pivot_index_right is undefined, $pivot must appear in the left side of the array.
            # So, $from < $f.
            $split = $f;
          }
          last;
        }

        # when $array->[$f] > $pivot and $array->[$t] > $pivot
        _swap($array, $f, $t);    # this does not affect pivot_index_*.
      }
    }

    # proccess each sub array
    _sort($array, $from, $split - 1);
    _sort($array, $split, $to);
 }
}

1;
