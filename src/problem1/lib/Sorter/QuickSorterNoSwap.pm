#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

package Sorter::QuickSorterNoSwap;

sub _pivot {
  my ($array, $from, $to) = @_;
  $array->[$from]
}

sub sort {
  my $array = shift;
  _sort($array, 0, $#{ $array });
}

sub _sort {
  my ($array, $from, $to) = @_;

  if ($from >= $to) {
    return;
  } else {
    my $pivot = _pivot($array, $from, $to);
    my ($s1, $s2);
    {
      my (@lt, @eq, @gt);
      for ($from .. $to) {
        my $x = $array->[$_];
        if ($x < $pivot) {
          push @lt, $x;
        } elsif ($x > $pivot) {
          push @gt, $x;
        } else {
          push @eq, $x;
        }
      }

    $DB::single = 1;
      $s1 = $from + @lt;
      $s2 = $s1 + @eq;
      @{ $array }[$from .. $s1 - 1] = @lt if @lt;
      @{ $array }[$s1 .. $s2 - 1] = @eq if @eq;
      @{ $array }[$s2 .. $to] = @gt if @gt;
    }
    _sort($array, $from, $s1 - 1);
    _sort($array, $s2, $to);
  }
}

1;
