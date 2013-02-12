#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

package Sorter::MergeSorter;

sub sort {
  my $array = shift;
  _sort($array, 0, @$array);
}

sub _sort {
  my ($array, $start, $end) = @_;

  if ($end - $start <= 1) {
    return;
  } else {
    my $mid = int($start / 2 + $end / 2);
    _sort($array, $start, $mid);
    _sort($array, $mid, $end);
    _merge($array, $start, $mid, $end);
  }
}

# $start, $middle, $end is given as follows.
#
# | a | b | c | d | e |
# |       |           |
# |start  |mid        |end
#
# Merge two arrays [a, b] and [c, d, e]
sub _merge {
  my $array = shift;
  my ($start, $mid, $end) = @_;
  my @buf;

  my ($fst, $snd) = ($start, $mid);
  my ($a, $b) = ($array->[$fst], $array->[$snd]);
  while ($fst < $mid and $snd < $end) {
    if ($a < $b) {
      push @buf, $a;
      $fst++;
      $a = $array->[$fst] if $fst < $mid;
    } elsif ($a > $b) {
      push @buf, $b;
      $snd++;
      $b = $array->[$snd] if $snd < $end;
    } else { # $a == $b
      push @buf, ($a, $b);
      $fst++; $snd++;
      $a = $array->[$fst] if $fst < $mid;
      $b = $array->[$snd] if $snd < $end;
    }
  }

  push @buf, @{ $array }[$fst .. $mid - 1] if ($fst < $mid);
  push @buf, @{ $array }[$snd .. $end - 1] if ($snd < $end);

  @{ $array }[$start..$end-1] = @buf;
  $array
}

1;
