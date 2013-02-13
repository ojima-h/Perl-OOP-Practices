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


{
  package ConcreteObserver;
  use base 'Observer';

  our @messages;

  sub new {
    my ($class, $name) = @_;
    bless { name => $name }, $class;
  }

  sub update {
    my ($self, $subject, $message) = @_;
    my $debug_message = sprintf("observer:%s, subject:%s, message:$message",
                                ref($self) ? $self->{name} : $self,
                                ref($subject) ? $subject->{name} : $subject);

    push(our @messages, $debug_message);
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
my $observerC = ConcreteObserver->new("observerC");

my $subject = ConcreteSubject->new("subjectA");

can_ok($subject, 'attach');

$subject->attach($observerA);
$subject->attach($observerB);
ConcreteSubject->attach($observerC);

$subject->notify_test;
cmp_ok(@ConcreteObserver::messages, '==', 3);
ok(/^observer:observerA, subject:subjectA/ ~~ @ConcreteObserver::messages);
ok(/^observer:observerB, subject:subjectA/ ~~ @ConcreteObserver::messages);
ok(/^observer:observerC, subject:subjectA/ ~~ @ConcreteObserver::messages);

ConcreteSubject->notify_test;
cmp_ok(@ConcreteObserver::messages, '==', 4);
ok(/^observer:observerC, subject:ConcreteSubject/ ~~ @ConcreteObserver::messages);
