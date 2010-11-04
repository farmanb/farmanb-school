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

sub countFrequencies{
    #Shift the string text off the stack and initialize (to null) the frequency hash.
    my ($s, $freqs) = (shift(@_), );
    
    foreach my $c (split '', $s){
	#Dump (only) the characters into a hash, (character, frequency).
	$freqs->{lc $c}++ unless ($c eq '' or $c eq ' ' or $c eq "\n");
    }

    return ($freqs)
}


my $fname = $ARGV[0];

sub findKeyLength{
    my ($s,$coincidences) = (shift(@_),{'max'=>1});
    
    $s = [split '', $s];
    my $l = $#{$s};

    foreach my $i (1 .. 10){
	#Initialize the number of coincidences to 0 for the shift of length i.
	$coincidences->{$i} = 0;

	#Iterate the string checking for coincidences.
	foreach my $j ($i+1..$l){
	    if ($s->[$j] eq $s->[$j-$i]){
		
		#Increment the number of coincidences associated with the shift of length i.
		$coincidences->{$i}++;
	    }
	}

	#Keep track of the size of the shift with the most coincidences.
	if ($coincidences->{$coincidences->{'max'}} < $coincidences->{$i}){
	    $coincidences->{'max'} = $i;
	}
	    
    }

    return $coincidences->{'max'};
}

#Take a string, $s, and separate it into $keylen strings.
sub generateStrings{
    my ($s,$keylen,$retVal) = (shift(@_), shift(@_),);
    
    $s = [split '', $s];

    foreach my $i (0 .. $keylen-1){
	my $temp;
	my $j = $i;
	
	while ($j <= $#{$s}){
	    push @{$temp}, $s->[$j];
	    $j += $keylen;
	}
	
	push @{$retVal}, join '' ,@{$temp}
    }
    return $retVal;
}

#Decrypt a message
sub decrypt{
    my ($s, $key) = (@_);

    my $keyArray = [split ' ', P($key)];
    my $temp = [split ' ', P($s)];
    my $i = 0;

    while ($i <= $#{$temp}){
	foreach my $j (0 .. $#{$keyArray}){
	    $temp->[$i + $j] =  ($temp->[$i + $j] - $keyArray->[$j])%26 unless ($i + $j > $#{$temp});
	}
	$i += $#{$keyArray} + 1;
    }

    $temp = join ' ', @{$temp};

    return Pinv($temp);
}



#Entry point.

#Open the cipher text file.
open my $fh, '<', $fname or 
    die "Error: Unable to open $fname for input: $!.\n"; #Fatal.  Print sys error and die.

#Array & hash refs.
my $ciphertext;

#Read the cipher text, line by line, from the file.  
while (<$fh>){
    chomp;
    #Split the line of space delimited strings
    foreach my $s (split ' ', $_){
	#Lowercase each string and push it into the array.
	push @{$ciphertext}, lc $s;
    }
}

close $fh;

my $cipherstring = join '', @{$ciphertext};

#Count the frequencies of each letter.
my $keylen = findKeyLength($cipherstring);

my $freqs;

my $strings = generateStrings($cipherstring, $keylen);
foreach my $s (@{$strings}){
    $freqs->{$s} = countFrequencies($s);
    print "Frequencies for \'$s\':\n";
    foreach my $key (sort keys %{$freqs->{$s}}){
	print $key . ":" . $freqs->{$s}->{$key} . "\n";
    }
}

#Guess the key based on the frequency analysis of the strings printed above.
my $key = Pinv((P('i') - P('e'))%26) .
    Pinv((P('r') - P('e'))%26) . 
    Pinv((P('k') - P('e'))%26) .
    Pinv((P('p') - P('e'))%26) . 
    Pinv((P('e') - P('e'))%26) .
    Pinv((P('r') - P('e'))%26) . 
    Pinv((P('h') - P('e'))%26) .
    "\n";

print "\nKey: $key\n";

#Decrypt the message.
print "Deciphered message:\n" . join '', split ' ', decrypt($cipherstring, $key);
print "\n";
