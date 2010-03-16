#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm", "fancyhdr");

#Cover Page info.
my ($num,
    $course) = (10, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("", 
	       "$course: Homework $num\\\\\n$school\\\\\nSolutions");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => "Tuesday, February 23, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

#print ptex::preamble($documentClass, \@docClassArgs, \@texPackages, "", "", 0,"");
print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "2.1.33";
my $thm = "Let \\(G\\) be a connected, n-vertex graph.  Prove that \\(G\\) has exactly one cycle if and only if \\(G\\) has exactly n edges.";
my $pf = "Assume \\(C\\subseteq G\\) is the only cycle contained by \\(G\\).\n" .
    "  Let \\(e \\in C\\) be a non-cut edge, whose existence is guaranteed by theorem 2.1.4\\cite{West}.\n" . 
    "  Let \\(G' = G-e\\).\n" . 
    "  Now, \\(G'\\) is acyclic and connected.\n".
    "  Hence, \\(G'\\) is a tree and \\( |E(G')| = n-1 \\).\n" .
    "  Therefore, \\[|E(G)| = |E(G')| + |\\{e\\}| = (n-1) + 1 = n\\]".
    
    #"  Let \\(U = V(G) \\backslash V(C_m)\\) be the set of \\(n-m\\) vertices which are not contained in \\(V(C_m)\\).\n\n" . 
    #"  Now, let \\(H\\) be the subgraph induced by the vertices of \\(U\\).\n" . 
    #"  Since it was assumed that \\(C_m\\) is the only cycle contained in G, it is clear that \\(H\\) must be a forest.\n" . 
    #"  Take \\(H\\) to be a connected forest.\n" . 
    #"  Then, \\(H\\) has \\(n-m-1\\) edges and, because \\(G\\) is connected, must have one edge from some \\(u \\in U\\) to some \\(c \\in C_m\\).\n" .
    #"  Therefore, \\[E(G) = m + ((n-m) - 1) + 1 = n\\]\n" . 
    "  as desired.\\\\\n\n" . 
    "  Assume \\(G\\) has \\(n\\) edges.\n" . 
    "  Given that \\(G\\) is connected, theorem 2.1.4\\cite{West} guarantees that \\(G\\) is not a tree.\n" .
    "  Hence, \\(G\\) must contain at least one cycle.\n" .
    "  Theorem 1.2.14\\cite{West} guarantees that there exists an edge, \\(e \\in E(G)\\), such that \\(e\\) is not a cut edge.\n\n".
    "  Consider the graph \\(G' = G - e\\).  Noting that \\(e\\) was not a cut edge, \\(G'\\) is a connected \\(n\\)-vertex graph with \\(n-1\\) edges.\n" . 
    "  Hence, \\(G'\\) is a tree.\n" .
    "  Now, add \\(e\\) to \\(G'\\); by corollary 2.1.5\\cite{West}, the resulting graph, \\(G\\), has exactly one cycle.\\\\\n\n" . 
    "  Therefore, \\(G\\) has exactly one cycle if and only if \\(G\\) has exactly n edges. ";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.1.37";
$thm = "Let \\(T, T'\\) be two spanning trees of a connected graph, \\(G\\).\n" . 
    "  For \\(e \\in E(T) - E(T')\\), prove that there is an edge \\(e' \\in E(T') - E(T)\\) such that \\(T' + e - e'\\) and \\(T - e + e'\\) are both spanning trees of \\(G\\).\n";
$pf = "Let \\(e = uv \\in E(T)-E(T')\\).\n" . 
    "  Given that \\(T\\) is a spanning tree, the edge \\(e\\) must be a cut edge of \\(T\\), so \\(e\\) must necesarily connect two connected components \\(U,U' \\subset T\\), with \\(u \\in V(U)\\) and \\(v \\in V(U')\\).\n" .
    "  Given that \\(T'\\) is also a spanning tree, there must exist at least one edge \\(u'v' \\in E(T')\\) with \\(u' \\in V(U)\\) and \\(v' \\in V(U')\\).\n\n" .
    "  With this in mind, add \\(e\\) to \\(T{'}\\); by corollary 2.1.5\\cite{West}, this creates exactly one cycle, \\(C \\subset T' + e\\).\n" .
    "  Since \\(e\\) has endpoints in \\(U\\) and \\(U'\\), the cycle created by adding \\(e\\) must include another edge with endpoints in \\(U\\) and \\(U'\\).\n" . 
    "  Hence, one of the edges \\(u'v'\\) must be such that \\(u'v' \\in C\\).\n" .
    "  Let \\(e'\\) be that edge.\n\n" .
    "  Note that \\(e'\\) has endpoints in \\(V(U)\\) and \\(V(U')\\). \n" . 
    "  If \\(e' \\in E(T)\\), then there are now two edges, \\(e\\) and \\(e'\\) between the two connected components \\(U\\) and \\(U'\\).\n" . 
    "  This is clearly a cycle contained in \\(T\\).\n" .
    "  However, this contradicts our assumption that \\(T\\) is a tree.  Hence, \\(e' \\not \\in E(T)\\) implies that \\(e' \\in E(T') - E(T)\\).\n\n".
    "  Now, add \\(e'\\) to \\(T\\); by corollary 2.1.5\\cite{West}, this creates exactly one cycle contained in \\(T+e'\\).\n" . 
    "  More importantly, this cycle must contain both of the edges, \\(e\\) and \\(e'\\).\n" .
    "  So, in both \\(T\\) and \\(T'\\), neither \\(e\\) nor \\(e'\\) are cut edges and the removal of either one from either tree results in a spanning tree.\n" .
    "  Therefore, \\(T+e{'} -e\\) and \\(T+e-e'\\) must both be spanning trees of \\(G\\)\n.";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.1.39";
$thm = "Let \\(G\\) be a tree with \\(2k\\) vertices of odd degree.  Prove that \\(G\\) decomposes into \\(k\\) paths.";
$pf = "By theorem 1.2.33\\cite{West}, the smallest decomposition of \\(G\\) into trails is \\(\\max(\\{k,1\\})\\) trails.\n" .
    "  Given that \\(G\\) is a tree, there must always be \\(k\\) trails, since if there were \\(0\\) vertices of odd degree, then there can only be an isolated vertex.\n" . 
    "  Let \\(T_1, T_2, \\ldots, T_{k}\\) be the trails which decompose \\(G\\).\n" . 
    "  Since \\(G\\) is acyclic, each of these trails is actually a path.\n" . 
    "  Therefore, \\(G\\) decomposes into \\(k\\) paths.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.2.1";
$thm = "Determine which trees have Pr\\\"{u}fer codes that (a) contain only one value, (b) contain exactly two values, or (c) have distinct values in all positions.\n";
$pf = "a) Star.\n\n" . 
    "b) Double star.\n\n". 
    "c) Paths";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.3.4";
$thm = "In the graph obtained from \\(K_5\\) by deleting two non-incdent edges, assign weights \\((1,1,2,2,3,3,4,4)\\) to the edges in two ways:  one way so that the minimum-weight spanning tree is unique, and the other way so that the minimum-weight spanning tree is not unique.\n";
$pf = "Unique:\\\\\n" . ptex::center(ptex::graphic("./imgs/unique.png"))  . 
    "\\newpage\n" . 
    "Non-Unique:\\\\\n" . ptex::center(ptex::graphic("./imgs/nonunique.png")) . "\n\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));
print "\\bibliographystyle{plain}" .
    "\\bibliography{refs}";
print ptex::endDoc();
