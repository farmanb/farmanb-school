#!/usr/bin/env perl
use strict;
use warnings;

#Function mapping blocks of text to Z/26Z.
sub Pinv{
    #Shift the argument off the stack
    my ($s, $retVal) = (shift(@_),);
    
    #Since the ASCII map is 'continuous', use the value of 'a'
    #to scale it down so that a maps to 0, z maps to 25.
    my ($a,$z) = (ord('a'),ord('z'));
    
    #Convert the block to numbers.
    foreach my $c (split ' ', $s){
	#Replace the letter by its numerical equivalent,
	#but do not convert spaces, endlines, etc.
	($c+$a >= $a and $c+$a <= $z) ? push @{$retVal}, chr($c+$a) : 
	    push @{$retVal}, $c;
    }

    #Return the string.
    return join ' ', @{$retVal};
}

sub P{
    #Shift the argument off the stack
    my ($s, $retVal) = (shift(@_),);
    
    #Since the ASCII map is 'continuous', use the value of 'a'
    #to scale it down so that a maps to 0, z maps to 25.
    my ($a,$z) = (ord('a'),ord('z'));
    
    #Convert the block to numbers.
    foreach my $c (split '', $s){
	#Replace the letter by its numerical equivalent,
	#but do not convert spaces, endlines, etc.
	(ord($c) >= $a and ord($c) <= $z) ? push @{$retVal}, ord($c) - $a : 
	    push @{$retVal}, $c;
    }

    #Return the string.
    return join ' ', @{$retVal};
}

#Encrypt a message
sub encrypt{
    my ($s, $key) = (@_);

    my $keyArray = [split ' ', P($key)];
    my $temp = [split ' ', P($s)];
    my $i = 0;

    while ($i <= $#{$temp}){
	foreach my $j (0 .. $#{$keyArray}){
	    $temp->[$i + $j] =  ($temp->[$i + $j] + $keyArray->[$j])%26 unless ($i + $j > $#{$temp});
	}
	$i += $#{$keyArray} + 1;
    }

    $temp = join ' ', @{$temp};

    return Pinv($temp);
}



my $cipher = "why is a raven like a writing desk";
my $key = "rabbithole";

print join '', split ' ', encrypt($cipher, $key);
print "\n";
