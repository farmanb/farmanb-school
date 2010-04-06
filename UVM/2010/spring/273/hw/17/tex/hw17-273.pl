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
    $course) = (17, 
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

my $name = "4.3.24"; 
my $thm = "Let \\(G\\) be a k-connected graph and let \\(S,T\\) be disjoint subsets of \\(V(G)\\) with size at least \\(k\\).\n" . 
    "  Prove that \\(G\\) has \\(k\\) pairwise disjoint \\(S,T\\)-paths.\n"; 
my $pf = "Take two new vertices, \\(s\\) and \\(t\\), and make them adjacent to \\(k\\) vertices of \\(S\\) and \\(T\\) respectively.\n" . 
    "  The resulting graph is still \\(k\\)-connected, so by Menger's Theorem there are \\(k\\) pairwise internally disjoint \\(s,t\\)-paths.\n" . 
    "  Then one can create \\(k\\) disjoint \\(S,T\\)-paths by removing all the edges from each of the \\(s,t\\)-paths except for one edge which passes directly from \\(S\\) to \\(T\\).\n"; 

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.3.3";
$thm = "A kitchen sink draws water from two tanks according to the network of pipes with capacities per unit time shown below.  Find the maximum flow.  Prove that your answer is optimal using the dual problem, and explain why this proves optimality.\n";
$pf = "First, add a super source adjacent to the two tanks with edges equal to the total capacity out of each tank.\n" . 
    "  Then, use the Ford-Fulkerson algorithm, which yields the graph below.\n" . 
    "  Circled is the minimum cut, across which the flow is 34, which is equal to the flow into the sink.\n" . 
    "  This proves the flow is the maximum flow.\n" . 
    ptex::center(ptex::graphic("imgs/4-3-3.png"));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.3.14";
$thm = "In a large university with \\(k\\) academic departments, we must appoint an important committe.\n" . 
    "  One professor will be chosen from each department.\n" . 
    "  Some professors have joint appointments in two or more departments, but each must be the designated representative of at most one department.\n" .
    "  We must use equally many assistant professors, associate professors, and full professors among the chosen representatives (assume that \\(k\\) is divisible by 3)." .
    "  How can the committee be found?\n";
$pf = "Start by connecting a source node to three nodes representinge the associate, assistant and full professor appointments.\n" . 
    "  Set the capacity of the edge between the source and the three nodes to be \\(k/3\\).\n". 
    "  Create nodes for each of the professors and make them adjacent to their respective appointments by an edge of capacity 1.\n" . 
    "  Finally, create \\(k\\) nodes for each of the departments.\n" . 
    "  Make each professor adjacent to the department(s) in which they have an appointment by an edge (the capacities are irrelevant) and make each department adjacent to the sink by an edge of capacity 1.\n" . 
    "  If the maximum flow into the source saturates each of the \\(k\\) edges into the sink, then it is possible to select the committee as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.9";
$thm = "Draw the graph of \\(K_{1,3} \\Box P_3\\) and exhibit an optimal coloring of it.  Draw \\(C_5 \\Box C_5\\) and find a proper 3-coloring of it with color classes of size 9,8,8.\n";
$pf = "\n\n" . 
    ptex::center(ptex::graphic("imgs/5-1-9a.png") .
    ptex::graphic("imgs/5-1-9b.png"));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.11";
$thm = "Prove that each graph below is isomorphic to \\(C_3 \\Box C_3\\).\n";
$pf = "The following labeling of all three graphs proves the three are isomorphic.\n\n" . 
    ptex::center(ptex::graphic("imgs/5-1-11a.png") . 
    ptex::graphic("imgs/5-1-11b.png") .
    ptex::graphic("imgs/5-1-11c.png"));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.12";
$thm = "Prove or disprove:  Every \\(k\\)-chromatic graph \\(G\\) has a proper \\(k\\)-coloring in which some color class has \\(\\alpha(G)\\) vertices.\n";
$pf = "Counterexample:\n" . 
    ptex::center(ptex::graphic("imgs/5-1-12.png")) . 
    "  The graph has an independent set of size four, but each of the color classes are of size three.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));


#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
