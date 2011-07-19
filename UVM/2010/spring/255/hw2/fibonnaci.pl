#!/usr/bin/env perl
use strict;
use warnings;

sub fibonnaci{
    my ($f,$n) = (@_,@_);

    if ($n == 1){
	return $f->[0];
    }

    my $temp = $f->[0] + $f->[1];
    $f->[1] = $f->[0];
    $f->[0] = $temp;

    return fibonnaci([$f->[0], $f->[1]], $n-1);
}

my $n = $ARGV[0];

print fibonnaci([1,1], $n) . "\n";

