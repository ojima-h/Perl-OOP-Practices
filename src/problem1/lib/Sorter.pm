package Sorter;
use strict;
use warnings;

sub new {
  my ($class, @args) = (shift, @_);
  my $self = {
    array => undef,
  };
  bless $self, $class;
}

sub _pivot {
  my $self = shift;
  my ($from, $to) = @_;
  $self->{array}[$from]
}
sub _swap { 
  my $arr = shift()->{array};
  my ($i, $j) = @_;
  ($arr->[$i], $arr->[$j]) = ($arr->[$j], $arr->[$i]);
}

sub _sort { 
}

sub sort {
  my $self = shift;
  $self->_sort(0, $#{ $self->{array} });
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
