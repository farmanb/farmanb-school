#!/usr/bin/perl
use strict;
use warnings;

#my $input;
#my $count = 0;
#while(chomp ( $input = <STDIN>)){
#    if ($input =~ /.*?(catch)\w*\((.+?)\s+/){
    #if ($input =~ /\btry\b/){
#    if ($input  =~ /\/(\w+)\.java$/){
	#print "Matched!: $1\n";#Clause: $1\nType: $2\n";
#    }
#    if ($input =~ /<a href=\"(.*?)\"/){
#	my $addy = $1;
	#print "$1\n";
#	if ($addy =~ /\/(\w+?)\.(.*?)\.(.*?)\//){
	    #print "Worked!\n";
	    #print "$1.$2.$3\n";
#	    my $key = "$1.$2.$3";
#	    print "$key\n";
#	}
#    }
#}

my $addy = "http://1.2.3.4.www.cs.rpi.edu/dept/~/asdf/more/things";
print $addy."\n";
#if ($addy =~ /^.*?\/(\w+)(.+?)(\w+)\//){
if ($addy =~ /\/(\w+)\.(.*?)\.(\w+)\//){
    print "$1.$2.$3\n";
    print "Match\n";
}
