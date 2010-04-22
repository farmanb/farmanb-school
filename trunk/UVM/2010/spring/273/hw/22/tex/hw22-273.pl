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
    $course) = (22, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Thursday, April 22, 2010",
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

my $name = "6.1.26"; 
my $thm = "For \\(n \\geq 2\\), determine the maximum number of edges in a simple outerplane graph with \\(n\\) vertices.\n"; 
my $pf = "Let \\(G\\) be a simple outerplane graph with \\(n\\) vertices.\n" . 
    "  Let \\(e\\) be the number of edges of \\(G\\) and let \\(f\\) be the number of faces of \\(G\\).\n" .
    "  Since \\(G\\) is simple, each face must have length at least three, so Theorem 6.1.13 can be used to obtain \\[2e = \\sum \\ell(F_i) \\geq 3f.\\]\n" . 
    "  Note by Proposition 6.1.18 that each outerplane graph has a spanning cycle, so the upper bound becomes \\[2e \\geq n + 3(f-1).\\]\n" .
    "  Using Theorem 6.1.21 and a little algebra the inequality rearranges to \\[2n - 3 \\geq e.\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.33";
$thm = "Let \\(G\\) be a triangulation, and let \\(n_i\\) be the number of vertices of degree \\(i\\) in \\(G\\).  Prove that \\(\\sum (6-i)n_i = 12\\)..\n";
$pf = "Given that \\(G\\) is a triangulation, \\[2e = 6n - 12 = \\sum_{v \\in V(G)}\\deg(v).\\]\n" . 
    "  Since there are \\(n\\) vertices, the \\(6n\\) can be distributed through the sum and the equation can be manipulated by routine algebra to obtain \\[\\sum_{v \\in V(G)} \\left(6 - \\deg(v)\\right)= 12.\\]\n" . 
    "  Then, grouping each of the \\(n_i\\) vertices of degree \\(i\\), the sum can be rewritten as \\[\\sum_{i=\\delta(G)}^{\\Delta(G)} (6-i)n_i = 12.\\]\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.2.5";
$thm = "Determine the number of edges that must be deleted from the Petersen graph to obtain a planar subgraph.\n";
$pf = "By removing one edge from \\(G\\), there still exists a subgraph of \\(G\\) whose subdivision is isomorphic to \\(K_{3,3}\\)." . 
    "  So, there must be at least two edges removed.\n" .
    "Below is such a subgraph of Petersen embedded in the plane.\n" .
    ptex::center(ptex::graphic("img/petersen.png"));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
