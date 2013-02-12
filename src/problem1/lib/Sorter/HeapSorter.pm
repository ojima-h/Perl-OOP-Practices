#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

package Sorter::HeapSorter;

sub sort {
  my $array = shift;
  my $heap = 'Heap'->new;

  $heap->push($_)  while (defined($_ = pop @$array));
  push @$array, $_ while (defined ($_ = $heap->pop));

  return $array;
}

{
  package Heap;

  sub new { bless [ ]; }

  sub Heap::push {
    my ($self, $elm) = (shift, $_[0]);

    push @$self, $elm;

    my ($id, $parent_id) = ($#$self, $self->_parent($#$self));
    while (defined $parent_id and $self->[$parent_id] > $self->[$id]) {
      $self->_swap($id, $parent_id);
      ($id, $parent_id) = ($parent_id, $self->_parent($parent_id));
    }

    $elm;
  }
  sub Heap::pop {
    my $self = shift;

    if (@$self == 0) { return; }
    elsif (@$self == 1) { return pop @$self; }
    else {
      my $elm = $self->[0];

      # move last element to head
      $self->[0] = pop @$self;

      my ($id, $child_id) = (0, $self->_child_min(0));
      while (defined $child_id and $self->[$id] > $self->[$child_id]) {
        $self->_swap($id, $child_id);
        ($id, $child_id) = ($child_id, $self->_child_min($child_id));
      }

      $elm;
    }
  }

  # Private Methods
  sub _parent {
    my ($self, $child_id) = @_;
    if ($child_id > 0) {
      int ($child_id - 1) / 2
    } else {
      undef
    }
  }
  sub _children {
    my ($self, $parent_id) = @_;
    my @children_id = (2 * $parent_id + 1, 2 * $parent_id + 2);
    grep $_ < @{ $self }, @children_id;
  }
  sub _child_min {
    my ($self, $id) = (shift, @_);
    my @children = $self->_children($id);

    if (@children == 2) {
      $self->[$children[0]] < $self->[$children[1]] ? $children[0] : $children[1];
    } elsif (@children == 1) {
      $children[0];
    } else {
      undef;
    }
  }
  sub _swap { 
    my ($self, $i, $j) = (shift, @_);

    ($self->[$i], $self->[$j]) = ($self->[$j], $self->[$i]);
    $self;
  }
}

1;
