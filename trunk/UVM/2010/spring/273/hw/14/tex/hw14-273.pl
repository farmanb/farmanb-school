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
    $course) = (14, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Tuesday, March 23, 2010",
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

my $name = "4.1.2\n";
my $thm = "Give a counterexample to the following statement, add a hypothesis to correct it, and prove the corrected statement:  If \\(e\\) is a cut-edge of \\(G\\), then at least one endpoint of \\(e\\) is a cut-vertex of \\(G\\).\n";
my $pf = "\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.1.4\n";
$thm = "Prove that a graph \\(G\\) is \\(k\\)-connected if and only if \\(G \\vee K_r\\) is \\(k+r\\)-connected.\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.1.9\n";
$thm = "For each choice of integers, \\(k,l,m\\) with \\(0 < k \\leq l \\leq m\\), construct a simple graph \\(G\\) with \\(\\symrm{\\kappa}(G) = k, \\kappa'(G) = l,\\) and \\(\\delta(G) = m\\).\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.1.10\n";
$thm = "\n";
 $pf = "\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
