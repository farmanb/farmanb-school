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
    $course) = (20, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Thursday, April 15, 2010",
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

my $name = "6.1.8"; 
my $thm = "Prove that every simple planar graph has a vertex of degree at most 5.\n"; 
my $pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.9";
$thm = "Use Theorem 6.1.23 to prove that every simple planar graph with fewer than 12 vertices has a vertex of degree at most 4.\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.10";
$thm = "Prove or disprove:  There is no simple bipartite planar graph with minimum degree at least 4.\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.21";
$thm = "Prove that a set of edges in a connected plane graph \\(G\\) forms a spanning tree of \\(G\\) if and only if the duals of the remaining edges form a spanning tree of \\(G*\\). \n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.25";
$thm = "Prove that every \\(n\\)-vertex plane graph isomorphic to its dual has \\(2n-2\\) edges.  For all \\(n \\geq 4\\), construct a simple \\(n\\)-vertex plane graph isomorphic to its dual.\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
