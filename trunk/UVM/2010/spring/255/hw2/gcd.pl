#!/usr/bin/env perl
use strict;
use warnings;

sub euclid{
    my ($a,$b) = (@_);

    if ($b == 0){
	return $a;
    }
    
    my $q = ($a - $a%$b)/$b;
    my $r = $a%$b;
    print "$a = ($q)$b + " . $r . "\n";

    return euclid($b,$a%$b);
}

my ($a,$b) = ($ARGV[0], $ARGV[1]);

print "gcd($a,$b) = " . euclid($a,$b) . "\n";
