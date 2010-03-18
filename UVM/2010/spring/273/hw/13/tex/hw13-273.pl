#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm");

#Cover Page info.
my ($num,
    $course) = (13, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("Blake Farman", 
	       "$course: Homework $num\\\\\n");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    #"date" => $date,
    "isCP" => 0
};


print ptex::preamble($p);

my $name = "3.3.4\n";
my $thm = "\n";
my $pf = "\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.3.7";
$thm = "\n";
$pf = "\n";
    
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.3.9\n";
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
