package Sorter;
use strict;
use warnings;

require Sorter::QuickSorter;
require Sorter::QuickSorterNoSwap;
require Sorter::HeapSorter;

my %sort_funcs = (
  QuickSorter       => \&Sorter::QuickSorter::sort,
  QuickSorterNoSwap => \&Sorter::QuickSorterNoSwap::sort,
  HeapSorter        => \&Sorter::HeapSorter::sort,
);

sub new {
  my $class = shift;
  my $mode = shift // 'QuickSorter';
  my $self = {
    array => undef,
    mode  => $mode,
  };
  bless $self, $class;
}


sub sort {
  my $self = shift;
  $sort_funcs{$self->{mode}}->($self->{array});
}

sub set_values {
  my ($self, @array) = (shift, @_);
  $self->{array} = \@array;
}

sub get_values {
  my $self = shift;
  $self->{array};
}

1;
