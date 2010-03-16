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
    $course) = (4, 
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
    "date" => "Tuesday, February 12, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "1.1.27";
my $thm = "Let \\(G\\) be a graph with girth 5.  Prove that if every vertex of \\(G\\) has degree at least \\(k\\), then \\(G\\) has at least \\(k^2 + 1\\) vertices.  For \\(k = 2\\) and \\(k = 3\\), find one such graph with exactly \\(k^2 + 1\\) vertices.";
my $pf = "Given that \\(G\\) has girth 5, there can be no cycles of length \\(1\\) and no cycles of length \\(2\\).  Hence, \\(G\\) must be a simple graph, and so for any vertex \\(v \\in V(G)\\), \\(v\\) must be adjacent to \\(k\\) distinct vertices.\\\\\n\n" . 
    "  Let \\(v \\in V(G)\\) and let \\(U_v \\subset V(G)\\) be the set of \\(k\\) vertices adjacent to \\(v\\).\n" .
    "  Consider any two distinct vertices \\(u_i,u_j \\in U_v\\).  If \\(u_i\\) is adjacent to \\(u_j\\), then there exists a 3-cycle involving \\(u_1, u_2 \\text{ and } v\\)." .
    "  This contradicts the assumption that \\(G\\) has girth 5.  Hence, \\(U_v\\) must be an independent set.\n" .
    "  So, it must be that case that for each \\(u_i \\in U_v\\), \\(u_i\\) is adjacent to at least \\(k-1\\) distinct vertices which are neither \\(v\\) nor are elements of \\(U_v\\).\\\\\n\n". 
    "  For each \\(u_i \\in U_v\\), let \\(U_{u_i}\\) be the set of \\(k-1\\) vertices to which \\(u_i\\) is adjacent.\n" . 
    "  Consider any two distinct \\(U_{u_i}, U_{u_j}\\) and suppose \\(U_{u_i} \\cap U_{u_j} \\not = \\phi.\\)\n" . 
    "  Let \\(x \\in U_{u_i} \\cap U_{u_j}.\\)\n" .
    "  Since \\(u_i\\) and \\(u_j\\) are both adjacent to \\(v\\) and to \\(x\\), there exists a 4-cycle in \\(G\\).  This contradicts the assumption that \\(G\\) has girth 5.\n" .
    "  Hence, it must be that \\(U_{u_i} \\cap U_{u_j} = \\phi.\\)\\\\\n\n" .
    "  Now, we have " .
    "\\[\\{v\\} \\cap U_v \\cap U_1 \\cap \\ldots \\cap U_k = \\phi\\]\n" .
    "and\n" . 
    "  \\[\\{v\\} \\cup U_v \\cup U_1 \\cup \\ldots \\cup U_k \\subseteq V(G).\\]\n".
    "  So, it follows that" . 
    "\\[ |\\{v\\}| + |U_v| + |U_1| + \\ldots + |U_k| = 1 + k + k(k-1) = k^2 + 1\\leq \\left|V(G)\\right| \\]\n" . 
    "Therefore, \\(G\\) has at least \\(k^2 + 1\\) vertices.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.1.31";
$thm = "Prove that a self-complementary graph with \\(n\\)-vertices exists if and only if \\(n\\) or \\(n-1\\) is divisible by 4.\n";
$pf = "Let \\(G\\) be a self-complementary graph with \\(n\\) vertices.\n" . 
    "  Then \\(K_n = G \\cup \\overline{G}\\) implies \\[|E(G)| = " . ptex::frac(1,2) . "E(K_n) = " . ptex::frac("(n-1)(n)",4) . ".\\]\n" . 
    "  Therefore, \\(|E(G)| \\equiv 0 (\\text{mod 4})\\) or \\(|E(G)| \\equiv 1 (\\text{mod 4})\\)\n\n" .
    "Conversely, suppose \\(n \\equiv 0 (\\text{mod 4})\\).\n" .
    "  Partition \\(V(G)\\) into four disjoint sets of size " . ptex::inlineMath(ptex::frac("n",4)) . ", \\(V_1, V_2, V_3 \\) and \\(V_4\\).\n" . 
    "  Let the edge sets of the partitions \\(V_1\\) and \\(V_4\\) be such that each partition by itself forms the subgraph \\(K_{" . ptex::frac("n",4) . "}\\) and " . 
    " let the edge sets of the partitions \\(V_2\\) and \\(V_3\\) be such that each partition by itself forms the subgraph \\(\\overline{K_{" . ptex::frac("n",4) . "}}\\).\n" . 
    "  For each \\(i = 1,2,3\\), let \\(V_i\\) and \\(V_{i+1}\\) form the partite sets of \\(K_{" . ptex::frac("n",4) . ", " . ptex::frac("n",4) . "}.\\)\n\n" . 
    "  Consider \\(\\overline{G}\\); \\(G\\) generalizes the structure of \\(P_4\\), which is self-complementary, so consider \\(V_1, V_2, V_3\\) and \\(V_4\\) as though they were nodes in \\(P_4\\).\n" . 
    "  \\(V_1\\) and \\(V_4\\) switch places with \\(V_2\\) and \\(V_3\\) as well as internal structure, and so \\(G \\cong \\overline{G}\\).\n" . 
    "  For the case where \\(n \\equiv 1 (\\text{mod 4})\\), simply connect the \\((4k+1)^{th}\\) vertext to all the vertices of \\(V_1\\) and \\(V_4\\).  Then, in \\(\\overline{G}\\), this vertex will be completely connected to each vertex in \\(V_2\\) and \\(V_3\\).\n" . 
    "  By a similar argument used for the case where \\(n \\cong 0(\\text{mod 4})\\), \\(G \\cong \\overline{G}\\).";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.2.8";
$thm = "Determine the values of \\(m\\) and \\(n\\) such that \\(K_{m,n}\\) is Eulerian.";
$pf = "The graph \\(K_{m,n}\\) is Eulerian if and only if, for each vertex \\(v \\in V(K_{m,n})\\), the degree of \\(v\\) is even.\\\\\n\n" .
    "  Let \\(A\\) and \\(B\\) be the bipartition of \\(K_{m,n}\\) of sizes \\(m\\) and \\(n\\), respectively.\n" . 
    "  For each \\(a \\in A\\) and \\(b \\in B\\), the degree of \\(a\\) must be \\(n\\) and the degree of \\(b\\) must be \\(m\\).\n " . 
    "  Therefore, \\(K_{m,n}\\) is Eulerian precisely when \\[m \\equiv 0 \\text{ }(\\text{mod } 2)\\] and \\[n \\equiv 0 \\text{ }(\\text{mod } 2)\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";

print ptex::endDoc();
