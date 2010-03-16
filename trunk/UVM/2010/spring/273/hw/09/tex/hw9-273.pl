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
    (9, "Math-273");

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
    "date" => "Thursday, February 18, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "2.1.23\n";
my $thm = "Let \\(T\\) be a tree in which every vertex has degree 1 or degree \\(k\\).  Determine the possible values of \\(n(T)\\).\n";
my $pf = "\\(k=1\\) is a graph with two vertices and one edge between them.\n" . 
    "  \\(k=2\\) is a path of any length at least 1.\n" . 
    "When \\(k \\geq 3\\), the smallest possible tree satisfying the above conditions is a path of length 1, where both vertices are leaves.\n" . 
    "  For this graph, \\(|E| \\equiv 1 (\\text{mod } k-1)\\)." . 
    "  From this graph, any graph (or one isomorphic) satisfying the above conditions can be constructed by selecting a leaf and adding \\(k-1\\) edges.\n" . 
    "  Thus, \\(|E| \\equiv 1 (\\text{mod } k-1)\\).\n" . 
    "  Given that \\(T\\) is a tree, \\(|E| = |V| - 1\\).\n" . 
    "  Therefore, \\(|V| \\equiv 2 (\\text{mod } k-1).\\)";    

print ptex::thm($name, $name, $thm . ptex::pf($pf));


$name = "2.1.27\n";
$thm = "Let \\(d_1,\\ldots,d_n\\) be positive integers, with \\(n \\geq 2\\).  Prove that there exists a tree with vertex degrees \\(d_1,\\ldots, d_n\\) if and only if \\[{\\sum_{i=1}^{n} d_i} = 2n-2.\\]\n";
$pf = "  Let \\(I = \\{1,\\ldots, n\\}\\) be an index set of size \\(n\\).\n" . 
    "Suppose \\(d_1, \\ldots, d_n\\) were the degree sequence of an \\(n\\)-vertex tree, \\(T\\), which must have \\(n-1\\) edges by definition.\n" . 
    "  It follows directly from proposition 1.3.3 that \\[{\\sum_{v \\in V(T)} \\text{deg}(v)} = {\\sum_{i \\in I} d_i} = 2|E| = 2n-2.\\]\n\n" . 
    "Conversely, suppose \\({\\sum_{i \\in I} d_i} = 2n-2.\\)\n" . 
    "  Consider the potential values of \\(d_1, \\ldots, d_n\\), more specifically each \\(i \\in I\\) such that \\(d_i = 1\\).\n" .
    "  Let \\(k\\) be the total number of vertices of degree 1.\n" .
    "  Suppose \\(0 \\leq k \\leq 1\\).\n" . 
    "  Then \\[{\\sum_{i = 1}^{n-k} d_i} + k \\geq  2n - k \\geq 2n - 1.\\]" .
    "  Since it was supposed that \\({\\sum_{i \\in I} d_i} = 2n-2\\), this is a contradiction.\n" .
    "  Therefore, \\(k \\geq 2.\\)\n\n" . 
    "  Using the fact that \\(k \\geq 2\\), construct a graph from the degree sequence as follows.\n" . 
    "  Start with the first \\(n-k\\) vertices corresponding to \\(d_1, \\ldots, d_{n-k}\\), say \\(v_1, \\ldots, v_{n-k} \\), and construct a path starting and ending at the vertices corresponding to \\( d_{n-k+1}, d_{n-k+2} \\) respectively, say \\( v_{n-k+1}, v_{n-k+2} \\).\n" . 
    "  Along the path, there are now two leaves, \\(n-k\\) vertices and the sum of the degrees for this path is \\[{\\sum_{i=1}^{n-k} 2 + 2 = 2(n-k) + 2}.\\]\n" . 
    "  For each \\(v_1, \\ldots, v_{n-k}\\), bring the degree of each \\(v_i\\) up from \\(2\\) to \\(d_i\\) by adding \\(d_i - 2\\) leaves.\n" . 
    "  This adds \\[{\\sum_{i=1}^{n-k} (d_i - 2)} = {\\sum_{i=1}^{n-k} d_i} - {\\sum_{i=1}^{n-k} 2}  = (2(n-1) - k) - 2(n-k) = k - 2\\] leaves which are spread over non-leaf vertices in the path.\n" . 
    "  These \\(k-2\\) new leaves, say \\(v_{n-k+3}, \\ldots, v_{n}\\), bring the total leaf count up to \\(2 + (k-2) = k\\), as expected.\n" .
    "  From the construction, the degrees of the vertices sum to \\[{\\sum_{i=1}^{n-k} 2} + 2 +  {\\sum_{i=1}^{n-k} (d_i - 2)} + (k-2) = [2(n-k) + 2] + [k-2] + [k-2] =2(n-1).\\]\n" .
    "  Hence, this graph is connected on \\((n-k + 2) + (k-2) = n\\) vertices with \\(n-1\\) edges and, for each \\(i \\in I\\), \\(v_i = d_i\\).\n"  .
    "  Therefore, \\(d_1, \\ldots, d_n\\) is the degree sequence of a tree.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.1.30\n";
$thm = "Let \\(T\\) be a tree in which all vertices adjacent to leaves have degree at least 3.  Prove that \\(T\\) has some pair of leaves with a common neighbor.\n";
$pf = "Let \\(P\\) be a maximum length path from \\(u \\in V(T)\\) to \\(v \\in V(T)\\).\n" . 
    "  \\(T\\) is a tree, so it must be that \\(v\\) is a leaf.\n" . 
    "  Let \\(x \\in V(T)\\) be the vertex along \\(P\\) to which \\(v\\) is connected.\n" . 
    "  By our assumption, \\(x\\) must have degree at least \\(3\\).\n" . 
    "  Consider \\(P\\) as a subgraph of \\(T\\).\n" . 
    "  Every vertex along \\(P\\) must have degree at most \\(2\\).\n" .
    "  Since \\(x\\) has degree at least 3 in \\(T\\), there exists some \\(y \\in V(T)\\) such that \\(y \\not \\in P\\) and \\(x\\) is adjacent to \\(y\\)\n\n" . 
    "  Suppose \\(y\\) were not a leaf in \\(T\\).\n" . 
    "  Then there would be a path, \\(P-v+y\\), from \\(u\\) to \\(y\\) which passes through \\(x\\).\n" . 
    "  This path simply switches \\(v\\) and \\(y\\) as endpoints, so \\(P-v+y\\) must be the same length as \\(P\\)." . 
    "  Since \\(y\\) was supposed to not be a leaf,  there must be a vertex not along \\(P\\) to which \\(y\\) is adjacent.\n" .
    "  This would create a path which is longer than \\(P\\), contradicting our assumption that \\(P\\) is a maximum length path in \\(T\\).\n" .
    "  Hence, it must be that \\(y\\) and \\(v\\) are both leaves with a common neighbor, \\(x\\).\n";
   
print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
