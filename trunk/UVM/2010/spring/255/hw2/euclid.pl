#!/usr/bin/env perl

use strict;
use warnings;

sub euclid{
    my ($a,$b) = (@_);

    if ($b == 0){
	return $a;
    }
    
    return euclid($b,$a%$b);
}
#    my $r = $a % $b;
#    my $d = ($a - $r) / $b;

#    print "$a = $b($d) + $r\n";

#    if ($r == 0){
#	return;
#    }
#    else{
#	euclid($b,$r);
#    }
#}

my ($a,$b) = ($ARGV[0], $ARGV[1]);

print euclid($a,$b) . "\n";
