#!/usr/bin/env perl

use 5.016;
use strict;
use warnings;

use Test::More 'no_plan';

BEGIN { use_ok 'Bird::Tweet'; }

use Bird;
my @birds = ( Bird->new(name => 'b1'),
              Bird->new(name => 'b2') );

new_ok('Bird::Tweet' => [ $birds[0],
                          "0 th tweet of " . $birds[0]->name
                        ]);

for my $i (1 .. 2) {
  my $bird = $birds[$i % 2];
  Bird::Tweet->new($bird, "$i th tweet of " . $bird->name);
}

cmp_ok(@{ Bird::Tweet->all_tweets() }, '==', 3);

my $iter = Bird::Tweet->find($birds[0]);

my $name = $birds[0]->name;
like($iter->next, qr/^0 th.*${name}$/);
like($iter->next, qr/^2 th.*${name}$/);
ok((not $iter->next), 'no more tweet found.');

