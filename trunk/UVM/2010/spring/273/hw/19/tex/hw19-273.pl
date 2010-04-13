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
    $course) = (19, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Tuesday, April 13, 2010",
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
my $thm = "Let \\(G_1, \\ldots, G_k\\) be the blocks of a graph \\(G\\).  Prove that \\(\\chi(G) = \\max_i \\{\\chi(G_i)\\}\\).\n"; 
my $pf = "Induct on the number of blocks of \\(G\\).\n\n" . 
    "  For the base case, assume there is only one block, \\(G_1 \\subseteq G\\).\n" . 
    "  Clearly, \\(\\chi(G) = \\max_i \\{\\chi(G_i)\\} = \\chi(G_1)\\).\n\n" . 
    "  Assume that for any graph, \\(G\\), with at most \\(k-1\\) blocks, \\(\\chi(G) = max_i \\{\\chi(G_i)\\}\\).\n" . 
    "  Let \\(k > 1\\) and suppose that \\(G\\) has \\(k\\) blocks.\n" . 
    "  Since \\(G\\) is not a block by itself, \\(G\\) must either be disconnected or have a cut vertex.\n" . 
    "  Hence, there exists a way in which to split the blocks of \\(G\\) into two collections such that the two subgraphs formed by the union of these collections share at most one vertex.\n" . 
    "  Call these two subgraphs \\(H_1\\) and \\(H_2\\) and let \\(I,J\\) be index sets such that \\[H_1 = \\bigcup_{i \\in I} G_i \\text { and } H_2 = \\bigcup_{j \\in J} G_j.\\]\n" . 
    "  Clearly, each of \\(H_1\\) and \\(H_2\\) have fewer than \\(k\\) blocks.\n" . 
    "  Hence, by the induction hypothesis, \\(\\chi(H_1) = \\max_{i \\in I} \\{\\chi(G_i)\\}\\) and \\(\\chi(H_2) = \\max_{j \\in J} \\{\\chi(G_j)\\}\\).\n\n" . 
    "  If \\(V(H_1) \\cap V(H_2) = \\phi\\), then \\(\\chi(G) = \\chi(H_1 + H_2) = \\max \\{\\chi(H_1), \\chi(H_2)\\}\\).\n" . 
    "  Then \\(\\chi(G) = \\max_i\\{\\chi(G_i))\\}\\).\n" .
    "  Thus, it can be assumed that \\(V(H_1) \\cap V(H_2) \\not = \\phi\\).\n\n" . 
    "  Note that \\(H_1\\) and \\(H_2\\) are the union of blocks of \\(G\\) connected only by a cut vertex, so necessarily there are no edges between \\(H_1\\) and \\(H_2\\)." .
    "  Then, as in Brooks' Theorem, each of \\(H_1\\) and \\(H_2\\) along with the cut vertex can be colored independently and only a renaming of the colors such that the cut vertex receives the same color in both \\(H_1\\) and \\(H_2\\) is needed.\n" .
    "  Hence, \\(\\chi(G) = \\max \\{\\chi(H_1), \\chi(H_2)\\} = \\max_i \\{\\chi(G_i)\\}\\), as desired.\n"; 

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.21";
$thm = "Suppose that every edge of a graph \\(G\\) appears in at most one cycle.  Prove that every block of \\(G\\) is an edge, a cycle or an isolated vertex.  Use this to prove that \\(\\chi(G) \\leq 3\\).\n";
$pf = "Using 4.2.4 (d) to characterise 2-connected graphs, every pair of edges of a block must lie on a common cycle.\n" .
    "  Since any edge of \\(G\\) was assumed to lie only on one cycle, it must be the block itself can only be, at most, a single cycle.\n\n" . 
    "  Then, using the result from exercise 5.1.3, we have \\[\\chi(G) = \\max_i \\{\\chi(G_i) \\mid G_i \\text{ is a block of } G\\}.\\]\n" . 
    "  Therefore, since any block must be at most a single cycle, \\(\\chi(G_i) \\leq 3\\) implies \\(\\chi(G) \\leq 3\\).";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.22";
$thm = "Given a set of lines in the plane with no three meeting at a point, form a graph \\(G\\) whose vertices are the intersections of the lines, with two vertices adjacent if they appear consecutively on one of the lines.\n" . 
    "  Prove that \\(\\chi(G) \\leq 3\\).\n";
$pf = "Using Szekeres-Wilf, we have the upper bound \\(\\chi(G) \\leq 1 + max_{H \\subseteq G} \\{\\delta(H)\\}\\).\n" . 
    "  Consider any subgraph \\(H \\subseteq G\\) with \\(\\delta(H) \\geq 3\\).\n".
    "  For any graph satisfying the hypotheses, each vertex must have at most two neighbors with lower y-coordinate and two neighbors with higher y-coordinates." .
    "  However, if \\(\\delta(H) \\geq 3\\), then there must exist at least one vertex with 3 lower y-coordinate neighbors.\n" .
    "  This would imply that three lines must intersect at a single point, which contradicts our hypothesis.\n" .
    "  Hence, it must be for any \\(H \\subseteq G\\), \\(\\delta(H) < 3\\)." .
    "  Therefore, \\(\\chi(G) \\leq 3\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.23";
$thm = "Place \\(n\\) points on a circle, where \\(n \\geq k(k+1)\\).\n" . 
    "  Let \\(G_{n,k}\\) be the \\(2k\\)-regular graph obtained by joining each point to the \\(k\\) nearest points in each direction on the circle.\n" . 
    "  For example, \\(G_{n,1} = C_n\\), and \\(G_{7,2}\\) appears below.\n" . 
    "  Prove that \\(\\chi(G_{n,k}) = k+1\\) if \\(k+1\\) divides \\(n\\) and \\(\\chi(G_{n,k}) = k+2\\) if \\(k+1\\) does not divide \\(n\\).\n" . 
    "  Prove that the lower bound on \\(n\\) cannot be weakened, by proving that \\(\\chi(G_{k(k+1)-1,k}) > k+2\\) if \\(k \\geq 2\\).\n";
$pf = "By construction, each \\(k+1\\) consecutive vertices form a \\(k+1\\)-clique.\n" . 
    "  Hence, any \\(k+1\\) consecutive vertices must all receive different colors.\n" .
    "  If \\(n\\) is divisible by \\(k+1\\), then working in a clockwise (or counterclockwise) direction, the vertices can be colored \\(1,2,\\ldots,k+1,1,2,\\ldots ,k+1,\\ldots\\).\n\n" .
    "  If \\(n\\) is not divisible by \\(k+1\\), then since \\(n \\geq k(k+1)\\) we have at least \\(k\\) groups of \\(k+1\\) vertices and  \\(n \\leq k (\\text{mod } k+1)\\).\n" .
    "  Hence, we can 'distribute' those remaining vertices among the groups.\n" .
    "  Let \\(\\ell \\equiv n (\\text{mod } k+1)\\).\n" . 
    "  Instead of coloring the first \\(\\ell\\) groups of consecutive vertices \\(1,2,\\ldots , k+1\\), color them \\(1,2,\\ldots ,k+1, k+2\\) and color the remaining \\(k-\\ell\\) groups \\(1,2,\\ldots , k+1\\).\n\n" . 
    "  Consider \\(G_{k(k+1)-1,k}\\) when \\(k \\geq 2\\).\n" . 
    "  Since \\(k(k+1)-1 \\equiv k (\\text{mod } k+1)\\) it is immediately clear that, for the same reasons above, it is not possible to color the graph in \\(k+1\\) colors.\n" . 
    "  More importantly, there are only \\(k-1\\) groupings of the \\(k+1\\) vertices, which immediately means the trick of 'distributing' the remaining vertices will not work.\n". 
    "  Hence, we can only 'distribute' \\(k-1\\) of the \\(k\\) vertices in the fashion above, leaving the last vertex requiring a \\(k+3^{rd}\\) color.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.26";
$thm = "Given finite sets \\(S_1, \\ldots, S_m\\), let \\(U = S_1 \\times \\ldots \\times S_m\\).\n".
    "  Define a graph \\(G\\) with vertex set \\(U\\) by putting \\(u \\leftrightarrow v\\) if and only if \\(u\\) and \\(v\\) differ in every coordinate.  Determine \\(\\chi(G)\\).";
$pf = "For any collection of sets \\(S_1, \\ldots, S_m\\), the size of any one set limits the possible number of points \\(u,v\\) which differ in every coordinate.\n" . 
    "  For instance, if there is a set with cardinality 2, it is not possible to have a set of mutually adjacent points of size larger than 2.\n\n" . 
    "  However, there is always a clique of size \\(\\min_i \\{|S_i|\\}\\).\n" .
    "  Simply create \\(\\min_i \\{|S_i|\\}\\) vertices in the following way.\n" . 
    "  Let \\(m = \\min_i \\{|S_i|\\}\\)." .
    "  Since each set has at least \\(m\\) elements, we can form the first vertex by using the first element of each \\(S_i\\), the second vertex using the second element from each \\(S_i\\) and so on until creating the \\(m^{th}\\) vertex \n" .
    " using the \\(m^{th}\\) element of each \\(S_i\\).\n" .
    "  Each of the vertices are guaranteed to differ at each coordinate and these \\(m\\) pairwise adjacent vertices form a clique." .
    "  Hence, \\(\\chi(G) \\geq \\min_i \\{|S_i|\\}\\).\n\n" . 
    "  Furthermore, the size of the smallest set in the cross product dictates the number of independent sets.\n" .
    "  Using the same \\(m\\) as before, let \\(|S_k| = m\\).\n" . 
    "  All vertices containing the same element of \\(S_k\\) must necessarily form an independent set.\n" . 
    "  Hence, there are \\(m\\) independent sets which can all receive the same color and \\(\\chi(G) \\leq m\\).\n" .
    "  Therefore, \\(\\chi(G) = \\min_i \\{|S_i|\\}\\)\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
