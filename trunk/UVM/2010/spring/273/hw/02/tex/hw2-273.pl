#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm", "fancyhdr");

#Cover Page info.
my ($num,
    $course) = (2, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("", 
	       "$course: Homework $num\\\\\nSolutions");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => "Tuesday, January 26, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $imgs = "./imgs/";

my $name = "1.1.11";
my $thm = "Determine the maximum size of a clique and the maximum size of an independent set in the graph below.\n" .
    ptex::center(ptex::graphic($imgs . "$name/graph.png")) . "\n";
my $pf = "Since the clique of size 5 requires 5 vertices of degree 4 and \\(G\\) has only 4 vertices of degree 4, the maximum size of a clique contained by \\(G\\) must be at most 4.\n" . 
    "  The following graph depicts just such a clique.\n" .
    ptex::center(ptex::graphic($imgs . "$name/subgraph.png")) .
    "Therefore, the largest clique contained by \\(G\\) is that of size 4.\\\\\n\n" .
    "Now, consider the vertices \\(e\\) and \\(f\\); both are adjacent to every vertex in \\(G\\) and therefore cannot be elements of any independent set larger than size 1.\n"  . 
    "  Hence, any independent set larger than size 1 must be formed using the four remaining vertices.  Selecting any of the three remaining vertices guarantees that two of them are pairwise adjacent.\n" .
    "  So, the largest independent set must be at most size 2.  The set \\(\\{a,d\\}\\) exhibits just such a set.  Therefore, the largest independent set is of size 2.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.1.18";
$thm = "Determine which pair of graphs below are isomorphic.\\\\\n" . 
    ptex::center(ptex::graphic($imgs . "$name/q2.png") . 
    ptex::graphic($imgs . "$name/bipart.png").
    ptex::graphic($imgs . "$name/oct.png")) . "\n";
$pf = "Let \\(G_1, G_2 \\text{ and } G_3\\) be the graphs starting from left to right.  \\(G_1\\) is isomorphic to \\(G_2\\), as demonstrated by the following automorphism of \\(G_1\\):\\\\\n" . 
    ptex::center(ptex::graphic($imgs . "$name/amorph.png")) .  
    "Consider the following subgraph of \\(G_3\\).\\\\\n" . 
    ptex::center(ptex::graphic($imgs . "$name/5cycle.png")) .
    "  This subgraph of \\(G_3\\) is not bipartite and, because \\(G_1\\) and \\(G_2\\) are both bipartite, \\(G_3 \\not \\cong (G_1 \\cong G_2)\\).\n"  ;


print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.1.22";
$thm = "Determine which pairs of graphs below are isomorphic, presenting the proof by testing the smallest possible number of pairs.\n";
$pf = "Let the graphs be named \\(G_1,G_2,G_3,G_4,G_5\\) from left to right.  The following labelings of the vertices show that \\(\\{G_1,G_2,G_5\\}\\) is a pairwise isomorphic.\\\\\n" .
  ptex::center(ptex::graphic($imgs . "$name/a.png") .
    ptex::graphic($imgs . "$name/b.png") . 
    ptex::graphic($imgs . "$name/e.png")) . 
    "The following labelings of the vertices show that \\(G_3 \\text{ and } G_4\\) are isomorphic.\n" . 
    ptex::center(ptex::graphic($imgs . "$name/c.png") .
    ptex::graphic($imgs . "$name/d.png")) .
    "Considering \\(G_1\\) and \\(G_3\\) as representatives from their respective isomorphism classes, in \\(G_1\\) any vertex is a point in three different triangles.\n" . 
    "  However, in \\(G_3\\) this is not the case; observe the following subgraph of \\(G_3\\).\n" . 
  ptex::center(ptex::graphic($imgs . "$name/subg.png")) .
    "The vertex \\(t\\) is a part of only two different triangles.  Thus, it must be that the two sets are subsets of distinct isomorphism classes.\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));
print ptex::endDoc();
