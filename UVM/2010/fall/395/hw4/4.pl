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

print rAdic($a,$r) . "\n";
