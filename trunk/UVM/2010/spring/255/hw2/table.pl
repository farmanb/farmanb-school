#!/usr/bin/env perl
use strict;
use warnings;

sub calcTrip{
    my ($u,$v) = (@_);
    
    return {'a' => $u*$u - $v*$v,
	    'b' => 2*$u*$v,
	    'c' => $u*$u + $v*$v};
}

sub printTrip{
    my $tripRef = shift;

    print "($tripRef->{'a'}, $tripRef->{'b'}, $tripRef->{'c'})";
}


my $table;

foreach my $u (2..10){
    my $row;
    foreach my $v (1..($u-1)){
	my $trip = calcTrip($u,$v);
	push @{$row}, $trip;
    }
    push @{$table}, $row;
}


foreach my $row (@{$table}){
    foreach my $trip (@{$row}){
	printTrip($trip);
	print " ";
    }
    print "\n";
}
