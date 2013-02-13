#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

package Bird::Tweet;

use base qw( Class::Accessor::Fast Subject );
Bird::Tweet->mk_accessors(qw( who body ));

our @TWEETS = ( );

sub new {
  my ($class, $who, $tweet) = @_;

  my $new = bless {
    who  => $who,
    body => $tweet,
  }, $class;
  push @TWEETS, $new;
  $new->notify('tweet');

  $new;
}

sub all_tweets { \@TWEETS; }


sub find {
  my ($class, $who) = @_;

  Bird::Tweet::Iterator->new($who);
}

sub message {
  my $self = shift;
  sprintf "%s: %s", $self->who->name, $self->body;
}

{
  package Bird::Tweet::Iterator;

  use base qw( Class::Accessor::Fast );
  Bird::Tweet::Iterator->mk_accessors(qw( who cur done ));

  sub new {
    my $class = shift;
    my $who   = shift;

    bless {
      who => $who,
      cur => 0,
      done => undef,
    }
  }

  sub next {
    my $self = shift;
    my $tweets = Bird::Tweet->all_tweets;
    my $found;

    my $i = $self->cur;
    while ($i < @$tweets) {
      if ($tweets->[$i]->who == $self->who) {
        $found = $tweets->[$i];
        $self->cur($i + 1);
        last;
      }
      $i++;
    }
    $self->done(1) unless ($found);

    if (defined $found) {
      return $found->body;
    } else {
      return;
    }
  }
}

1;
