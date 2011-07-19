#!/usr/bin/env perl
use strict;
use warnings;

sub rAdic{
    my ($a,$r) = (@_);
    if ($a == 0){
	return '';
    }

    return rAdic(($a - $a%$r)/$r, $r) . $a%$r;
}

my ($a, $r) = ($ARGV[0],$ARGV[1]);

if (!defined $a or !defined $r){
    #Something is missing.  Fatal.
    die "Error: Usage: bin2dec binary_number base\n";
}

print rAdic($a,$r);
