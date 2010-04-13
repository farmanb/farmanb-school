#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","amssymb");

#Cover Page info.
my ($num,
    $course) = (18, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Thursday, April 8, 2010",
	       "$course: Homework $num\\\\\n");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => $date,
    "isCP" => 0
};


print ptex::preamble($p);

my $name = "5.1.3"; 
my $thm = "\n"; 
my $pf = "\n"; 

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.21";
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.22";
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.23";
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.26";
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
