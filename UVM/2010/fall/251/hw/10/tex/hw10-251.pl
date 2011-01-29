#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "amsart";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","amssymb");

#Cover Page info.
my ($num,
    $course) = (6, 
		"Math-251");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Friday, October 22, 2010",
	       "$course: Homework $num\\\\\n");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => $date,
    "isCP" => 0,
    "other" => "\\openup 5pt" 
};


print ptex::preamble($p);

my $Z = "\\mathbb{Z}";
my $R = "\\mathbb{R}";

my ($beq,$eeq) = ("\\begin{eqnarray*}\n", "\\end{eqnarray*}\n");

my $name = "1"; 
my $thm = "Let \\(G\\) be a group of order 315 which has a normal Sylow 3-subgroup.\n" . 
    "Prove that \\(Z(G)\\) contains a Sylow 3-subgroup of \\(G\\) and deduce that \\(G\\) is abelian.\n"; 
my $pf = "";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "\n"; 
$pf = "";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "\n"; 
$pf = "";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "\n"; 
$pf = "";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "\n"; 
$pf = "";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6"; 
$thm = "\n"; 
$pf = "";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
