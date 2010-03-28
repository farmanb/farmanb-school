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
    $course) = (15, 
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

my $name = "4.2.4\n";
my $thm = "Prove or disprove:  If \\(P\\) is a \\(u,v\\)-path in a 2-connected graph \\(G\\), then there is a \\(u,v\\)-path \\(Q\\) that is internally disjoint from \\(P\\).\n";
my $pf = "Counterexample:\n\n". 
    ptex::center(ptex::graphic("./imgs/graph.png")) .
    "  This graph is 2-connected.  Let \\(P = \\{AB,BD,DE,EC\\}\\).\n" . 
    "  Then, there are two other mutually internally disjoint \\(A,C\\)-paths, \\(\\{AB,BC\\}\\) and \\(\\{AE,EC\\}\\), but neither of them are internally disjoint from \\(P\\)";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.2.8\n";
$thm = "Prove that a simple graph \\(G\\) is 2-connected if and only if for every ordered triple \\((x,y,z)\\) of distinct vertices, \\(G\\) has an \\(x,z\\)-path through \\(y\\).\n";
$pf = "Let \\(G\\) be 2-connected.  Let \\(x,y,z \\in V(G)\\).\n" . 
    "  Then there exist two internally disjoint \\(x,y\\)-paths and two internally disjoint \\(y,z\\)-paths.\n" . 
    "  Select the \\(x,y\\)-path which does not contain \\(z\\) and the \\(y,z\\)-path which does not contain \\(x\\).\n" . 
    "  Combine these two paths to create an \\(x,z\\)-path through \\(y\\).\n\n" . 
    "  Conversely, assume \\(y \\in V(G)\\) is a cut-vertex.\n" . 
    "  Then, \\(G-y\\) has at least two connected components, \\(H,H'\\).\n" . 
    "  Let \\(x \\in H\\) and \\(z \\in H'\\).\n". 
    "  Since \\((x,z,y) \\subset G\\), by hypothesis, \\(x\\) has a path to \\(y\\) through \\(z\\) in \\(G\\), which implies that there exists an \\(x,z\\)-path in \\(G-y\\).". 
    "  This is a contradiction, so \\(y\\) is not a cut vertex.\n" . 
    "  Hence,  \\(G\\) has no cut-vertex and \\(G\\) is clearly connected.\n" . 
    "  Therefore, \\(G\\) is 2-connected.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.2.20\n";
$thm = "Prove that the hypercube, \\(Q_k\\), is \\(k\\)-connected by constructing \\(k\\) pairwise internally disjoint \\(x,y\\)-paths for each vertex pair \\(x,y \\in V(Q_k)\\).\n";
$pf = "Construct \\(Q_k\\) inductively from two copies of \\(Q_{k-1}\\) and show that there are \\(k\\) pairwise internally disjoint paths.\n\n" . 
    "  Base case:  Let \\(k\\) = 2.  \\(Q_2\\) is 2-connected since for any two vertices, there are two very simple paths; one path goes clockwise, the other goes counterclockwise.\n\n" . 
    "  Assume the hypothesis holds up to \\(Q_k\\).  Construct \\(Q_{k+1}\\) in the usual way from two copies of \\(Q_k\\).\n" . 
    "  Let \\(G,H \\subset Q_{k+1}\\) be the two copies of \\(Q_k\\) from which \\(Q_{k+1}\\) is constructed and let \\(x \\in V(G), y \\in V(H)\\).\n". 
    "  First, in order to simplify the relationship between \\(x\\) and \\(y\\), we show that there are \\(k+1\\) pairwise internally disjoint \\(x,s\\)-paths in \\(Q_{k+1}\\)." .
    "  There are already \\(k\\) pairwise internally disjoint \\(x,s\\)-paths in \\(G\\), so all that remains to show is that there is one more created in the construction of \\(Q_{k+1}\\).\n" .
    "  Observe that in the construction of \\(Q_{k+1}\\), \\(x\\) is made adjacent to some \\(t \\in V(H)\\) and \\(s\\) is made adjacent to some \\(t' \\in V(H)\\).\n". 
    "  Select some \\(t, t'\\)-path from H and we have the \\((k+1)^{th}\\) \\(x,s\\)-path which must clearly be internally disjoint from all other \\(x,s\\)-paths contained in \\(G\\).\n\n" .
    "  Now, note that for any choice of \\(x\\) and \\(y\\), either \\(x\\) and \\(y\\) are adjacent in \\(Q_{k+1}\\), or \\(x\\) is adjacent to some \\(s \\in V(G)\\), which is adjacent to \\(y\\).\n" . 
    "  So for the sake of simplicity we can assume that \\(x\\) and \\(y\\) are adjacent, because if they are not we can simply transform the problem by finding internally disjoint \\(x,s\\)-paths in such a way that they are internally disjoint from the \\(s,y\\)-paths.\n\n" . 
    "  Let \\(x_1, x_2, \\ldots, x_k\\) be the \\(k\\) vertices to which \\(x\\) is adjacent.\n" . 
    "  By construction, there are \\(k\\) distinct vertices, \\(y_1, y_2, \\ldots, y_k \\in V(H)\\) such that \\(x_iy_i \\in E(Q_{k+1})\\).\n" . 
    "  Then by the induction hypothesis, for each choice of \\(i\\), there exist \\(k\\) pairwise internally distinct \\(y, y_i\\)-paths.\n" . 
    "  Since there are only \\(k-1\\) vertices other than \\(i\\), we can select one of these paths for each choice of \\(i\\) such that \\(y_i\\) is the only vertex from the set \\(y_1, \\ldots, y_k\\) along that path.\n" . 
    "  Therefore, we have created \\(k\\) pairwise internally disjoint \\(x,y\\)-paths.\n" . 
    "  The last path is simply the edge between \\(x\\) and \\(y\\).\n" . 
    "  Therefore, \\(Q_k\\) is \\(k\\)-connected.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
