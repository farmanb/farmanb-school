#!/usr/bin/env perl
use strict;
use warnings;

#Group an arbitrary bit string into a 
#collection of bytes
sub bits2bytes{
    my $bits = shift @_;
    my $bytes;
    
    #Reverse the bits and collect in groups of 8
    $bits = [reverse @{$bits}];
    
    my $byte;
    foreach my $i (0..$#{$bits}){
	push @{$byte}, $bits->[$i];
	
	#If i is a multiple of 8
	if ($i != 0 and $i % 8 == 7 ){
	    #Reverse the byte and push it into
	    #the collection of bytes
	    push @{$bytes}, join '', reverse @{$byte};
	    #Clear the current byte
	    $byte = ();
	}
    }

    #Put the bytes in the correct order.
    return [reverse @{$bytes}];
}

my $bits = $ARGV[0];

if (!defined $bits){
    #Nothing provided to convert.  Fatal.
    die "Error: Usage: bin2dec binary_number\n";
}

my $l = length($bits);

#Pad the string with zeros to make sure its 
#length is a multiple of 8
if ($l%8 != 0){
    my $r = $l%8;
    foreach my $i (1..(8-$r)){
	$bits = '0' . $bits;
    }
}

my $bytes = bits2bytes([split '', $bits]);

foreach my $byte (@{$bytes}){
    print $byte . "\n";
}
