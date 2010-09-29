#!/usr/bin/env perl
use strict;
use warnings;

sub decrypt{
    my $s = shift @_;
    
    my $hash = {
	'('=>' ',
	')'=>'r',
	'*'=>'n',
	'-'=>' ',
	'.'=>' ',
	'0'=>' ',
	'1'=>' ',
	'2'=>' ',
	'3'=>' ',
	'4'=>'a',
	'5'=>' ',
	'6'=>' ',
	'8'=>'e',
	'9'=>' ',
	':'=>'h',
	';'=>'t',
	'?'=>' ',
	']'=>' ',
	'c'=>' ',
	'd'=>' ',
	'p'=>' '};
    
    foreach my $c (split '', $s){
	print $hash->{$c};
    }

    print "\n";
}

my $s = "53ddc305))6*;4826)4d.)4d);806*;48c8p60))85;;]8*;:d*8c83(88)5*c;46(;88*96*?;8)*d(;485);5*c2:*d(;4956*2(5*-4)8p8*;4069285);)6c8)4dd;1(d9;48081;8:8d1;48c85;4)485c528806*81(d9;48;(88;4(d?34;48)4d;161;:188;d?;";

my $freqs;

foreach my $c (split '', $s){
    $freqs->{$c}++;
}

foreach my $k (sort keys %{$freqs}){
    print "$k: " . $freqs->{$k} .  "\n";
}

print decrypt($s);
