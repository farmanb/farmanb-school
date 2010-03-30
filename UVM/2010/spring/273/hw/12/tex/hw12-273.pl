#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","fancyhdr");

#Cover Page info.
my ($num,
    $course) = (12, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("", 
	       "Tuesday, March 2, 2010",
	       "$course: Homework $num\\\\\n$school\\\\\nSolutions");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => $date,
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};


print ptex::preamble($p);

my $name = "3.1.10";
my $thm = "Let \\(M\\) and \\(N\\) be matchings in a graph, \\(G\\), with \\(|M| > |N|\\).\n". 
    "  Prove that there exist matchings \\(M'\\) and \\(N'\\) such that \\(|M'| = |M| - 1\\), \\(|N'| = |N| + 1\\), and \\(M',N'\\) have the same union and intersection (as edge sets) as \\(M\\) and \\(N\\).\n";
my $pf = "Consider the symmetric difference of the two matchings, \\(M \\triangle N\\).\n" . 
    "  Since \\(|M| > |N|\\), there must exist at least one component of the symmetric difference which is a path.\n" . 
    "  This path is an \\(M\\)-alternating path, which is also an \\(N\\)-augmenting path.\n" . 
    "  Simply switch the \\(M\\) edges along this path with the \\(N\\) edges to create new matchings, \\(M'\\) and \\(N'\\)." . 
    "  The only changes made were switches along this path, without the addition or removal of edges, so \\(M'\\) and \\(N'\\) still have the same union and intersection, however \\(|M'| = |M| - 1\\) and \\(|N'| = |N| + 1\\), as desired.\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.1.19";
$thm = "Let \\({\\bf A}\\) = \\(A_1, \\ldots, A_m\\) be a collection of subsets of a set \\(Y\\).\n" . 
    "  A {\\bf system of distinct representatives} (SDR) for \\({\\bf A}\\) is a set of distinct elements \\(a_1, \\ldots, a_m\\) in \\(Y\\) such that \\(a_i \\in A_i\\).\n" . 
    "  Prove that \\({\\bf A}\\) has an SDR if and only if \\(|\\bigcup_{i \\in S} A_i| \\geq |S|\\) for every \\(S \\subseteq \\{1, \\ldots, m\\}\\).\n";
$pf = "Transform the decision problem for a system of distinct representatives into an equivalent decision problem for a matching saturating a set of vertices in the following way.\n" . 
    "  Let \\(X = \\{x_1, \\ldots, x_m\\}\\) be some set of \\(m\\) vertices, distinct from \\(Y\\), and let \\(Y\\) be the neighbors of \\(X\\).\n" . 
    "  Let \\(I = \\{1,\\ldots, m\\}\\) be an index set.\n\n" .
    "  For any \\(i \\in I\\), let \\(A_i\\) be the set of neighbors of \\(x_i\\)." . 
    "  For any \\(S \\subseteq I\\), let \\(\\bigcup_{i \\in S} A_i\\) be the set of neighbors for \\(\\bigcup_{i \\in S} \\{x_i\\} \\subseteq X\\).\n" .
    "  Now, there exists a set of distinct representatives if and only if there exists a matching saturating \\(X\\).".
    "  According to Hall's Theorem, there exists a matching which saturates \\(X\\) if and only if \\(|\\bigcup_{i \\in S} A_i| \\geq |\\bigcup_{i \\in S} \\{x_i\\}| = |S|\\).\n" .
    "  Therefore, there exists a set of distinct representatives if and only if for every \\(S \\subseteq I\\), \\(|\\bigcup_{i \\in S} A_i| \\geq |S|\\).\n";
    
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.1.24";
$thm = "A {\\bf permutation matrix} \\(P\\) is a \\(0,1\\)-matrix having exactly one 1 in each row and column.\n" . 
    "  Prove that a square matrix of nonnegative integers can be expressed as the sum of \\(k\\) permutation matrices if and only if all row sums and column sums equal \\(k\\).\n";
$pf = "Let \\(M\\) be an \\(n \\times n\\) matrix of nonnegative integers.\n\n" . 
    "  Suppose \\(M\\) were expressible as the sum of \\(k\\) permutation matrices, \\(P_1, \\ldots, P_k\\).\n" . 
    "  By definition, the row and column sums of any permutation matrix are always 1, for every row and every column\n." . 
    "  So it must be that if \\(M = {\\sum_{i=1}^{k} P_i}\\), then for the \\(m^{th}\\) row of \\(M\\), the row sum of \\(M\\) would be \\[{\\sum_{i=1}^{k}({\\sum_{j=1}^{n} p_{i_{m,j}}}}) = {\\sum_{i=1}^{k}1} = k\\] and for the \\(m^{th}\\) column, the column sum of \\(M\\) would be \\[{\\sum_{i=1}^{k}({\\sum_{j=1}^{n} p_{i_{j,m}}}}) = {\\sum_{i=1}^{k}1} = k.\\]\n\n" . 
    "  Conversely, suppose for every row and column of \\(M\\), the row and column sum of \\(M\\) were \\(k\\).\n" . 
    "  Consider \\(M\\) as some part of an adjacency matrix where the entry \\(m_{i,j}\\) is the number of edges \\(\\{u_i, v_j\\}\\), with \\(u_i \\not = v_j\\), for any \\(i,j \\in \\{1, \\ldots ,n\\}\\).\n" . 
    "  Clearly the subgraph induced by the vertices of this adjacency matrix has no loops.\n" .
    "  In fact, it is necessarily bipartite.\n" . 
    "  Then, for each \\(u_i\\), \\(\\text{deg}(u_i)\\) is the \\(i^{th}\\) row sum and for each \\(v_j\\), \\(\\text{deg}(v_k)\\) is the \\(j^{th}\\) column sum.\n" . 
    "  These values are all \\(k\\), so this describes a \\(k\\)-regular bipartite graph.\n\n" . 
    "  By corollary 3.1.13, there exists a perfect matching using these vertices, which would be described by a matrix with row and column sums of 1." . 
    "  Hence, an adjacency matrix corresponding to a perfect matching is just a permutation matrix.\n" . 
    "  Deleting a perfect matching from a \\(k\\)-regular, bipartite graph yields a \\(k-1\\)-regular, bipartite graph, which will also has a perfect matching.\n" . 
    "  So, to determine the \\(k\\) permutation matrices which sum to \\(M\\), simply continue removing perfect matchings until left with a 1-regular bipartite graph, which is the \\(k^{th}\\) permutation matrix.\n". 
    "  Therefore, \\(M\\) is the sum of \\(k\\) permutation matrices.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.1.28\n";
$thm = "Exhibit a perfect matching in the graph below or give a short proof that it has none.\n";
$pf = "The graph does not have a perfect matching.\n" . 
    "  Since the graph does not have any odd cycles, it is bipartite and each partite set has 21 vertices.\n" . 
    "  Shown below is a subset of one partite set (black) of size 11 and its 10 neighbors (red).\n" . 
    "  Hence, by Hall's Theorem, there is no matching which saturates the partite set to which the black vertices belong.\n" . 
    "  Therefore, there is no perfect matching.\n" . 
    ptex::center(ptex::graphic("imgs/28.png"));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
