#!/usr/bin/env perl
use strict;
use warnings;

#The decrypted number from sage
my $string = '31351940280579449';

#Convert to binary.
my $binString = `./radic.pl $string 2`;

my $bytes = [split ("\n", `./bits2bytes.pl $binString`)];

foreach my $byte (@{$bytes}){
    print chr(`./bin2dec.pl $byte`);
}

print "\n";
