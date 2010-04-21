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
    $course) = (21, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Tuesday, April 20, 2010",
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

my $name = "6.1.8"; 
my $thm = "Prove that every simple planar graph has a vertex of degree at most 5.\n"; 
my $pf = "Let \\(G\\) be a simple planar graph on \\(n\\) vertices.\n" . 
    "  Suppose to the contrary that every vertex of \\(G\\) has degree at least 6.\n" . 
    "  Then by proposition 6.1.26 \\[3n - 6 = " . ptex::frac(1,2) . "\\sum_{v \\in V(G)} \\deg(v) \\geq 3n.\\]\n" . 
    "  This is a contradiction.  Therefore, there exists some vertex with degree at most 5.";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.9";
$thm = "Use Theorem 6.1.23 to prove that every simple planar graph with fewer than 12 vertices has a vertex of degree at most 4.\n";
$pf = "Let \\(G\\) be a simple planar graph with \\(n < 12\\) vertices.\n" . 
    "  Suppose to the contrary that every vertex of \\(G\\) has degree at least 5.\n" .
    "  Then using Theorem 6.1.23 and Proposition 1.3.3, we obtain \\[ 5n \\leq |E(G)| \\leq 6n - 12.\\]". 
    "  With a little manipulation of the left and right hand sides of the inequality, we obtain \\[5 \\leq 6 - " . ptex::frac(12,"n") . " < 5.\\]" . 
    "  This is a contradiction.\n"  .
    " Therefore, there exists some vertex with degree at most 4.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.10";
$thm = "Prove or disprove:  There is no simple bipartite planar graph with minimum degree at least 4.\n";
$pf = "Let \\(G\\) be a simple bipartite planar graph with \\(n\\) vertices.\n" . 
    "  Suppose that every vertex of \\(G\\) has degree at least 4.\n" . 
    "  Since \\(G\\) was assumed to be simple, it suffices to assume \\(n \\geq 4\\).\n\n" .
    "  Since \\(G\\) is bipartite, \\(G\\) is necessarily triangle free.\n" .
    "  Hence, using Theorem 6.1.23 and Proposition 1.3.3 we obtain \\[2n \\leq |E(G)| \\leq 2n - 4.\\]\n" . 
    "  This is a contradiction.\n" . 
    "  Therefore, there is no simple bipartite planar graph with minimum degree at least 4.";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.21";
$thm = "Prove that a set of edges in a connected plane graph \\(G\\) forms a spanning tree of \\(G\\) if and only if the duals of the remaining edges form a spanning tree of \\(G^*\\). \n";
$pf = "Let \\(G\\) be a connected plane graph and let \\(U \\subset E(G)\\) be the set of edges corresponding to a spanning tree of \\(G\\).\n" . 
    "  Observe that \\[|E(G)| = |U| + |U^c| = n-1 + |U^c|.\\] " . 
    "  Using this in combination with Theorem 6.1.21 and the definition of \\(G^*\\), we obtain \\[f - 1 = |V(G^*)| - 1 = |U^c|.\\]\n\n" . 
    "  Now note that \\(U\\) was assumed to be the edges of a spanning tree of \\(G\\), so \\(U^c\\) is not a bond of \\(G\\).\n" .
    "  Then since \\(G\\) is connected Theorem 6.1.14 guarantees that the edge set \\(U^c\\) does not form a cycle in \\(G^*\\).\n" . 
    "  Hence, \\(U^c\\) corresponds to an acyclic graph with \\(|V(G^*)|-1\\) edges, which is a tree by Theorem 2.1.4.\n" . 
    "  Therefore, the edges of \\(U^c\\) form a spanning tree in \\(G^*\\).\n\n" . 
    "  Similarly, using the same argument as above and replacing \\(U\\) by \\(U^c\\) yields the converse.\n" . 
    "  Therefore, a set of edges in a connected plane graph \\(G\\) forms a spanning tree of \\(G\\) if and only if the duals of the remaining edges form a spanning tree of \\(G^*\\), as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.25";
$thm = "Prove that every \\(n\\)-vertex plane graph isomorphic to its dual has \\(2n-2\\) edges.  For all \\(n \\geq 4\\), construct a simple \\(n\\)-vertex plane graph isomorphic to its dual.\n";
$pf = "Let \\(G\\) be an \\(n\\)-vertex plane graph and suppose \\(G \\cong G^*\\).\n" .
    "  Since \\(G^*\\) is always connected, \\(G\\) is also connected.\n" . 
    "  Hence, there exists a spanning tree of \\(G\\), \\(T\\).\n" . 
    "  Let \\(U \\subset G\\) be the edges of \\(T\\)." . 
    "  By exercise 6.1.21 above, \\(U^{c}\\) is a spanning tree of \\(G^*\\) and we obtain \\[|U| = |V(G)| - 1 \\text{ and } |U^c| = |V(G^*)| - 1.\\]\n" . 
    "  Therefore since \\(G \\cong G^{*}\\), \\[|E(G)| = |U| + |U^c| = 2n - 2.\\]\n\n" .
    "  To construct such a graph, start with a star using all \\(n\\) vertices.\n" . 
    "  Then using the vertices on the outside of the star, form a cycle of length \\(n-1\\)." .
    "  Since the star is a tree, each of the \\(n-1\\) edges will add exactly one cycle to the graph, so there are \\(n-1\\) faces and one unbounded face in \\(G\\).\n" . 
    "  Hence, \\(|V(G^*)| = |V(G)|\\).\n" . 
    "  Then note that in \\(G^*\\) each of the vertices corresponding to the bounded faces of \\(G\\) connect to the vertex corresponding to the unbounded face of \\(G\\).\n" . 
    "  This forms the star in \\(G^*\\).\n" . 
    "  Finally, the bounded faces form the cycle of size \\(n-1\\) and thus \\(G \\cong G^*\\).\n\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
