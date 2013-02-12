package My::List;
use strict;
use warnings;

{
  package ListCore;
  use base 'Class::Accessor::Fast';
  ListCore->mk_accessors(qw(value tail));

  sub null {
    my $class = shift;
    bless { };
  }
  sub add {
    my ($value, $tail) = @_;
    bless {
      value => $value,
      tail  => $tail,
    };
  }
  sub is_null { my $self = shift; not keys %$self }
}

use base 'Class::Accessor::Fast';
My::List->mk_accessors(qw( node last ));

sub new {
  my $class = shift;
  my $node = ListCore->null;
  bless {
    node => $node,
    last => $node,
  };
}

sub append {
  my ($self, $value) = @_;
  my $new_node = ListCore->null;

  $self->last->value($value);
  $self->last->tail($new_node);
  $self->last($new_node);

  $value;
}

sub iterator {
  my $self = shift;
  My::List::Iterater->new($self->node);
}

{
  package My::List::Iterater;

  sub new {
    my ($class, $current) = @_;
    bless {current => $current}, $class;
  }

  sub next {
    my $self = shift;
    my $current = $self->{current};
    $self->{current} = $self->{current}->tail;
    $current;
  }
  sub has_next {
    my $self = shift;
    not $self->{current}->is_null;
  }
}
1;
