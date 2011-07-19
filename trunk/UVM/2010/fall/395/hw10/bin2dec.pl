#!/usr/bin/env perl
use strict;
use warnings;

#Pass in a binary string and convert it to a decimal
sub bin2dec{
    my $b = shift @_;
    
    my $dec = 0;
    foreach my $i (0..$#{$b}){
	$dec += 2**$i * $b->[$i];
    }
    
    return $dec
}

my $b = $ARGV[0];

if (!defined $b){
    #Nothing provided to convert.  Fatal.
    die "Error: Usage: bin2dec binary_number\n";
}

$b = [split '', $b];

print bin2dec([reverse @{$b}]);
