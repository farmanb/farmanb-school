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
    $course) = 
    (6, "Math-273");

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
    "date" => "Tuesday, February 9, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "1.1.35";
my $thm = $kn . " decomposes into three pairwise-isomorphic subgraphs if and only if \\(n + 1\\) is not divisible by \\(3\\)";
my $pf = "Suppose " . $kn . " were to decompose into three pairwise-isomorphic subgraphs, " .
    ptex::list($g,3) . 
    ", with \\(G_1 \\cong G_2 \\cong G_3\\).  The edge sets of each subgraph would all have the same cardinality" . 
    ptex::math(ptex::abs("E(" . $g->("i") . ")") . " = " . 
		     ptex::frac(1,3) . ptex::abs("E(" . $k->("n") . ")") . " = " . 
		     ptex::frac(1,3) . ptex::frac("n(n-1)",2) . ".") . 
    "Thus, 3 must divide either \\(n\\) or \\((n-1)\\) which implies " . ptex::inlineMath("n \\not" . ptex::cong(2,3)) . ".\\\\\n\n". 
    "Let \\(n = 3s\\), for some \\(s \\in \\mathbb{N} \\setminus \\{0\\}\\).\n" . 
    "  Construct \\(G_1, G_2, G_3\\) in the following manner.\n" . 
    "Partition \\(V(K_n)\\) into three disjoint sets of size \\(s\\) \n" . 
    ptex::math("V_i = \\{v_j \\in V(K_n) \\mid j \\in [(i-1)s, i(s-i)]\\}, \\text{ } i = 1,2,3.") . 
    "\n" . 
    "Define the edge sets by the cartesian product \n" . 
    ptex::math("E_1 = ((V_1 \\times V_1) \\setminus \\{(u,v) \\mid u = v\\}) \\cup (V_1 \\times V_2),") . "\n" .
    ptex::math("E_2 = ((V_2 \\times V_2) \\setminus \\{(u,v) \\mid u = v\\}) \\cup (V_2 \\times V_3),") . "\n" .
    ptex::math("E_3 = ((V_3 \\times V_3) \\setminus \\{(u,v) \\mid u = v\\}) \\cup (V_3 \\times V_1).") . "\n" .
    "  Noting that \\(\\bigcap_{i=1}^{3}V_i = \\phi\\), it is clear that \\(\\bigcap_{i=1}^{3}E_i = \\phi\\) and that \\(\\bigcup_{i=1}^{3}E_i\\) covers \\(E(K_n)\\), so the construction of each subgraph decomposing \\(G\\) is clear.\n" . 
    "  Let \\(G_1 = (V_1 \\cup V_2, E_1)\\), \\(G_2 = (V_2 \\cup V_3, E_2)\\) and \\(G_3 = (V_3 \\cup V_1, E_3)\\).\n" .
    "  Since all the edge sets were constructed in the same manner, the three graphs decomposing \\(G\\) are isomorphic.\n\n" . 
    "  Let \\( = 3s + 1\\), for some \\(s \\in \\mathbb{N} \\setminus \\{0\\}\\)." . 
    "  Let \\(v_{3s+1} \\in V(K_n)\\) be the \\((3s+1)^{th}\\) vertex of \\(G\\).\n" . 
    "  Using the other \\(3s\\) vertices of \\(G\\), construct \\(G_1, G_2 \\text{ and } G_3\\) in the exact same manner as before and modify their edge and vertex sets as follows.\n" . 
    "  Let \n" . 
    ptex::math("V(G_i) = V(G_i) \\cup \\{v_{3s+1}\\}, \\text{ for each } i \\in \\{1,2,3\\},") . "\n" . 
    "  and let \n" . 
    ptex::math("E_i = E_i \\cup (V_i \\times \\{v_{3s+1}\\}),\\text{ for each } i \\in \\{1,2,3\\}.") . "\n" . 
    "  This preserves the disjoint property of the edge sets and also allows \\(\\bigcup_{i=1}^{3}E_i\\) to cover \\(E(K_{3s+1})\\).\n";    
print ptex::thm($name, $name, $thm . ptex::pf($pf));


$name = "1.2.17\n";
$thm = "Let \\(G\\) be the graph whose vertices are the permutations of \\(\\{1,\\ldots,n\\}\\), with two permutations \\(a_1,\\ldots,a_n\\) and \\(b_1,\\ldots,b_n\\) adjacent if they differ by interchanging a pair of adjacent entries.  Prove that \\(G_n\\) is connected.\n";
$pf = "Let \\(x = x_1,\\ldots,x_n,y = x_2,\\ldots,y_n \\in V(G)\\) be distinct vertices in \\(G\\) and let \\(I = \\{1,\\ldots,n\\}\\) be an index set.\n" . 
    "  Construct a path starting at \\(x\\) and ending at \\(y\\) in the following manner.\n\n" . 
    "  Select \\(x_n\\) and find \\(j \\in I\\) such that \\(y_j = x_n\\).\n" . 
    "  Switch \\(x_n\\) with the left adjacent entry in \\(x\\) until \\(x_n\\) is in the \\(j^{th}\\) position." . 
    "  Each switch with a left-adjacent entry yields a new vertex which was connected to the previous vertex.\n" . 
    "  Hence, these vertices form a path originating at \\(x\\).\n" . 
    "  Proceed by performing the same process with each entry of \\(x\\), moving from right to left, until \\(x = y\\).\n" .
    "  This path was constructed for arbitrary \\(x,y \\in V(G)\\), so for any \\(x,y \\in V(G)\\) there exists a path from \\(x\\) to \\(y\\).\n" . 
    "  Therefore, \\(G\\) is connected.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.2.20\n";
$thm = "Let \\(v\\) be a cut-vertex of a simple graph \\(G\\).  Prove that \\(\\overline{G} - v\\) is connected.\n";
$pf = "Given that \\(v\\) is a cut vertex, \\(G - v\\) is necessarily disconnected.\n" . 
    "  Let \\(U,U' \\subset G\\) be the components of \\(G\\) connected by \\(v\\)\n." . 
    "  We are guaranteed, by the fact that \\(v\\) is a cut vertex, that for any \\(u \\in U\\) and \\(u' \\in U'\\), \\(uu' \\not \\in E(G)\\), and so \\(uu' \\in E(\\overline{G})\\).\n\n" .
    "  Consider any two vertices \\(x,y \\in V(G) \\setminus \\{v\\}\\).\n" . 
    "  Either \\(x\\) and \\(y\\) are in the same component of \\(G\\), or they are not.\n" . 
    "  If they are not in the same component, then they are adjacent in \\(\\overline{G}\\).\n" . 
    "  If they are in the same component of \\(G\\), say \\(U\\), then there exists a vertex, \\(w \\in U'\\), to which \\(x\\) and \\(y\\) are both adjacent in \\(\\overline{G}\\).\n". 
    "  Hence, there is a path between any \\(x,y \\in V(G) \\setminus \\{v\\} \\) in \\(\\overline{G}\\).\n" . 
    "  Therefore, \\(\\overline{G}-v\\) is connected.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.3.31\n";
$thm = "Use complete graphs and counting arguments (not algebra!) to prove that\\\\\n\n". 
    "a) \\({n \\choose 2} = {k\\choose2} + k(n-k) + {{n-k}\\choose2} \\text{ for } 0 \\leq k \\leq n\\).\\\\\n\n" . 
    "b) If \\({\\sum n_i} = n\\), then \\(\\sum\\) \\({n_1} \\choose {2}\\) \\(\\leq\\) \\(n \\choose 2\\).\n";
$pf = "a)  Decompose \\(K_n\\) into the union of \\(K_k \\cup K_{n-k}\\) and its complement.\n" .
    "  Noting that \\(\\overline{K_k \\cup K_{n-k}}\\) = \\(K_{k,n-k}\\), we have \\(K_n = K_k \\cup K_{n-k} \\cup K_{k,n-k}\\).\n" .
    "  Using this decomposition, we have the equation \\[|E(K_n)| = |E(K_k)| + |E(K_{n-k})| + |E(K_{k,n-k})|.\\]\n" . 
    "  Given that \\(K_n\\) has \\(n \\choose 2\\) edges and \\(K_{m,n}\\) has \\(m(n)\\) edges, we can plug these values into the above equation to get \\[{n \\choose 2} = {k\\choose2} + k(n-k) + {{n-k}\\choose2} \\text{, for } 0 \\leq k \\leq n.\\]\n\n". 
    "b) Let \\(K_{n_i}\\) be the complete graph on \\(n_i\\) distinct vertices.\n" . 
    "  Since \\({\\sum n_i} = n\\), we have \\(\\bigcup K_{n_i} \\subseteq K_n\\), which implies \\(\\bigcup E(K_{n_i}) \\subseteq E(K_n)\\).\n" . 
    "  Noting \\(|E(K_n)| = {n \\choose 2}\\), we have \\[{\\sum |E(K_{n_i})|} = {\\sum {n_i \\choose 2}} \\leq { n \\choose 2}.\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
