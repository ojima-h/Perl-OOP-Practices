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
  my $self = shift;
  my ($from, $to) = @_;

  if ($from == $to) {
    return;
  } else {
    my $arr = $self->{array};
    my $pivot = $self->_pivot($from, $to);

    my $split;
    # find $split such that
    #   $arr->[$from  .. $split-1] -- not greater than $pivot
    #   $arr->[$split .. $to     ] -- not less than $pivot
    {
      my ($f, $t) = ($from, $to);
      my ($pivot_index_left, $pivot_index_right);
      while (1) {
        while ($arr->[$f] <= $pivot and $f < $t) {
          $pivot_index_left = $f if $arr->[$f] == $pivot;
          $f++;
        }

        if ($f == $t) {
          if ($arr->[$t] < $pivot) {
            $self->_swap($pivot_index_left, $t);
          }
          $split = $f;
          last;
        }

        # when $arr->[$f] > $pivot and $f < $t
        while ($arr->[$t] >= $pivot and $f < $t) {
          $pivot_index_right = $t if $arr->[$t] == $pivot;
          $t--;
        }

        if ($f == $t) {
          if ($pivot_index_right) {
            $self->_swap($pivot_index_right, $f);
            $split = $f + 1;
          } else {
            # When $pivot_index_right is undefined, $pivot must appear in the left side of the array.
            # So, $from < $f.
            $split = $f;
          }
          last;
        }

        # when $arr->[$f] > $pivot and $arr->[$t] > $pivot
        $self->_swap($f, $t);    # this does not affect pivot_index_*.
      }
    }

    # proccess each sub array
    $self->_sort($from, $split - 1);
    $self->_sort($split, $to);
  }
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
