#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "amsart";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","amssymb","calrsfs");

#Cover Page info.
my ($num,
    $course) = (7,
		"Math-333");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Friday, November 12, 2010",
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

my ($R,$N,$Z) = ("\\mathbb{R}","\\mathbb{N}", "\\mathbb{Z}");
my ($beq,$eeq) = ("\\begin{eqnarray*}\n", "\\end{eqnarray*}\n");
my $mb = "\\bar\\mu";

my $name = "1"; 
my $thm = "\n";
my $pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6"; 
$thm = "\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
