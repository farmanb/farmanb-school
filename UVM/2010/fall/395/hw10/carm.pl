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
    #print "$a = ($q)$b + " . $r . "\n";

    return euclid($b,$a%$b);
}

sub factor2{
    my $n = shift @_;

    if ($n%2 != 0){
	return 0;
    }

    return 1 + factor2($n/2);
}

sub pollardP1{
    my ($n, $r,$i) = (@_);

    if (!defined $i){
	$i = 1;
    }
    
    my $g = euclid($n,$r-1);

    if ($g != 1){
	print "i:$i\n";
	return $g;
    }

    print $r;
    $r = $r**$i;
    $r = $r%$n;
    $i++;
    return pollardP1($n,$r, $i);
}

my $c = $ARGV[0];

print pollardP1($c,2) . "\n";
