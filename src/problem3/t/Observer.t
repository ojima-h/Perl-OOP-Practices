#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Test::More 'no_plan';

BEGIN {
  use_ok 'Observer';
  use_ok 'Subject';
}

our @messages;

{
  package ConcreteObserver;
  use base 'Observer';

  sub new {
    my ($class, $name) = @_;
    bless { name => $name }, $class;
  }

  sub update {
    my ($self, $subject, $message) = @_;
    push our @messages, $self->{name} . ": $message";
  }
}

{
  package ConcreteSubject;
  use base 'Subject';

  sub new {
    my ($class, $name) = (shift, @_);
    bless { name => $name }, $class;
  }
  sub notify_test {
    my $self = shift;
    $self->notify('Test Message');
  }
}

my $observerA = ConcreteObserver->new("observerA");
my $observerB = ConcreteObserver->new("observerB");

my $subject = ConcreteSubject->new("subjectA");

can_ok($subject, 'attach');

$subject->attach($observerA);
$subject->attach($observerB);

$subject->notify_test;

ok(grep("observerA: Test Massage", @ConcreteObserver::messages));
ok(grep("observerB: Test Massage", @ConcreteObserver::messages));
