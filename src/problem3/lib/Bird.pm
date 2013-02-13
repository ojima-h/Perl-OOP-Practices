package Bird;

use 5.016;
use strict;
use warnings;

use base qw( Class::Accessor::Fast Subject Observer );
Bird->mk_accessors(qw( name ));
Bird->mk_ro_accessors(qw( followee follower tweets friends_timeline ));

use Bird::Tweet;

our @BIRDS;

sub new {
  my ($class, %args) = (shift, @_);
  $args{$_} = [ ] for qw( followee follower tweets friends_timeline);

  my $bird = bless \%args, $class;
  $class->attach($bird);
  Bird::Tweet->attach($bird);
  $bird;
}

# Implementation for Observer
sub update {
  my ($self, $subject, $message, @args) = @_;

  if (ref $self) {
    given ($message) {
      when ('follow') { # notification that $subject follows $whom
        my $whom = shift @args;
        push @{ $self->follower }, $subject if $whom == $self;
      }
      when ('tweet') { # notification that someone tweets $tweet
        my $tweet = $subject;
        unshift @{ $self->friends_timeline }, $tweet if ($self->is_followee($tweet->who));
      }
    }
  }
}


sub follow {
  my ($self, $bird) = (shift, @_);
  push @{ $self->followee }, $bird;
  $self->notify('follow', $bird);
  $self;
}
sub is_followee {
  my ($self, $bird) = @_;
  grep $_ == $bird, @{ $self->followee };
}

sub tweet {
  my ($self, $_tweet) = @_;
  my $tweet = Bird::Tweet->new($self, $_tweet);

  unshift @{ $self->{tweets} }, $tweet;
  $self;
}

1;
