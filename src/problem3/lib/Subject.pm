#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

package Subject;

# { class => {
#              observer_1 => observer_1,
#              observer_2 => observer_2,
#            }
# { instance => {
#                 ...
our %OBSERVERS;

sub attach {
  my ($self, $observer) = (shift, @_);
  $OBSERVERS{$self}->{$observer} = $observer;
}
sub detach {
  my ($self, $observer) = (shift, @_);
  delete $OBSERVERS{$self}->{$observer};
}
sub notify {
  my ($self, @args) = (shift, @_);
  for my $observer (values %{ $OBSERVERS{$self} }) {
    $observer->update($self, @args);
  }
}

1;
