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
    $course) = (11, 
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
    "date" => "Thursday, February 25, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};


print ptex::preamble($p);

my $name = "2.2.20";
my $thm = "Prove that a \\(d\\)-regular simple graph \\(G\\) has a decomposition into copies of \\(K_{1,d}\\) if and only if it is bipartite.\n";
my $pf = "Assume \\(G\\) decomposes into copies of \\(K_{1,d}\\).  Let \\(I\\) be a finite index set and let \\[G = \\bigcup_{i \\in I}G_i,\\] with \\[G_i \\cong K_{1,d}, \\text{ for all } i \\in I\\] be the decomposition of \\(G\\).\n" . 
    "  For each \\(i \\in I\\), let \\(A_i, B_i\\) be the bipartition of \\(G_i\\) and assume, without loss of generality, that \\(|A_i| = 1\\) and \\(|B_i| = d\\).\n" . 
    "  Let \\(V(G) = A \\cup B\\), where \\(A = \\bigcup_{i \\in I} A_i\\) and \\(B = \\bigcup_{i \\in I} B_i\\).\n\n" .
    #"  Then, there must exist \\(a_1,a_2 \\in A\\) such that \\(a_1a_2 \\in E(G)\\) or \\(b_1,b_2 \\in B\\) such that \\(b_1b_2 \\in E(G)\\).\n" . 
    "  Consider any \\(u,v \\in A\\).\n" .
    "  Note that for some \\(i,j \\in I\\), \\(u \\in A_i\\) and \\(v \\in A_j\\) with \\(i = j\\) if and only if \\(u = v\\).\n".
    "  The definition of \\(K_{1,d}\\) guarantees the degrees of \\(u\\)  and \\(v\\) must both be \\(d\\).\n" . 
    "  Given that \\(G\\) is both simple  as well as \\(d\\)-regular and that \\(u,v\\) are adjacent only to vertices in \\(B_i\\) and \\(B_j\\) respectively, \\(u\\) and \\(v\\) cannot possibly be adjacent.\n\n" .
    "  Consider \\(u,v \\in B\\) such that for some \\(i,j \\in I\\), \\(u \\in B_i\\) and \\(v \\in B_j\\)." . 
    "  If \\(i = j\\), then \\(u\\) and \\(v\\) would clearly not be adjacent because they are both in the same partition of a bipartite subgraph, \\(G_i\\).\n" .
    "  If \\(i \\not = j\\), then \\(u\\) and \\(v\\) would not be part of the same bipartite subgraph and could potentially be adjacent.\n" .
    "  Suppose \\(u\\) and \\(v\\) were adjacent.\n" .
    "  \\(G\\) is assumed to decompose into copies of \\(K_{1,d}\\), so it must be the case that either \\(u \\in A_j\\) or \\(v \\in A_i\\).\n".
    "  Assume, without loss of generality, \\(u \\in A_j\\).\n" .
    "  We assumed \\(u \\in B_i\\), so it must be the case that \\(u\\) is adjacent to \\(a \\in A_i\\).\n" . 
    "  We proved that any two elements of \\(A\\) must not be adjacent, however we now have \\(u\\in A_j \\subset A\\) adjacent to \\(a \\in A_i \\subset A\\).\n".
    "  This is a contradiction.\n" . 
    "  Using a similar argument with the necessary changes, the same contradiction is reached by assuming \\(v \\in A_i\\).\n" .
    "  Hence, \\(u\\) and \\(v\\) are not adjacent.\n\n" . 
    "This proves that for any \\(u,v \\in A\\), \\(u\\) and \\(v\\) are not adjacent and for any \\(u',v' \\in B\\), \\(u'\\) and \\(v'\\) are not adjacent.  Therefore, \\(G\\) is bipartite and the sets \\(A\\), \\(B\\) are in fact the bipartition of \\(G\\)\\\\\n\n" .
    "Assume \\(G\\) is bipartite.\n" . 
    "  Let \\(A,B\\) be the bipartition of \\(G\\) and let \\(I\\) be an index set with \\(|I| = |A|\\).\n".
    "  For each \\(i \\in I\\), let \\(A_i = \\{a_i \\in A\\} \\text{ and } B_i = \\{b \\in B \\text{ | } a_ib \\in E(G)\\}\\).\n" .
    "  For each \\(i \\in I\\), let \\(G_i\\) be the bipartite graph induced by the vertex set \\(A_i \\cup B_i\\).\n" .
    "  Since the only edges in \\(G\\) are those between the partite sets, it should be clear that these \\(G_i\\) decompose \\(G\\).\n\n" .
    "  All that remains is to show that for each \\(i \\in I\\), \\(G_i \\cong K_{1,d}\\).\n" . 
    "  Consider any \\(G_i\\).\n".
    "  \\(G\\) is both simple and \\(d\\)-regular, so \\(a_i\\) has \\(d\\) incident edges, each with a unique endpoint in \\(B_i\\).\n" . 
    "  Using this fact and our construction of each \\(G_i\\), we have that \\(G_i\\) is a bipartite graph with partite sets \\(A_i, B_i\\) of size \\(1\\) and \\(d\\), respectively.\n " .
    "  Therefore, \\(G_i \\cong K_{1,d}\\).";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.1.8";
$thm = "Prove or Disprove: Every tree has at most one perfect matching..";
$pf = "Let \\(T\\) be a tree.\n" . 
    "  Suppose \\(M_1\\) and \\(M_2\\) were perfect matchings for \\(T\\)." .
    "  Consider the symmetric difference of the two matchings, \\(M_1 \\triangle  M_2\\), which must be either an even cycle or a path.\n" .
    "  Given that \\(T\\) is a tree and therefore acyclic, \\(M_1 \\triangle  M_2\\) must be a path.\n\n" . 
    "  Let \\(P\\) be a maximum path along \\(M_1 \\triangle  M_2\\) with endpoints \\(u\\) and \\(v\\).\n" . 
    "  The edges of this path must alternate between edges of \\(M_1\\) and \\(M_2\\).\n" . 
    "  Assume that \\(u\\) is \\(M_1\\)-saturated in \\(M_1 \\triangle  M_2\\).\n" . 
    "  If \\(u\\) were \\(M_2\\)-saturated in \\(T\\), then \\(u\\) would be \\(M_2\\)-saturated in \\(M_1 \\triangle  M_2\\) by adding an edge from \\(M_2\\), which saturates \\(u\\), to \\(P\\)." .
    "  We assumed \\(P\\) was a maximum path in \\(M_1 \\triangle  M_2\\), so it must be that such an edge does not exist and \\(u\\) is not \\(M_2\\)-saturated in \\(T\\).\n" . 
    "  Hence, \\(M_2\\) is not a perfect matching, which contradicts our hypothesis.\n" . 
    "  Therefore, it must be that \\(T\\) has only one perfect matching.\n";
    #"  \\(T\\) is bipartite, so let \\(A\\) and \\(B\\) be the bipartition of \\(T\\).\n" . 
    #"  Using Hall's condition, we can formulate that \\(T\\) has a perfect matching if and only if, for each \\(X \\subseteq A\\) and \\(Y \\subseteq B\\), \\(N(X) \\geq |X|\\) and \\(N(Y) \\geq |Y|\\).\n\n" . 
    #"  Take \\(X = A\\) and \\(Y = B\\).\n" .
    #"  \\(T\\) is a tree, which implies \\(T\\) is connected, so we have that \\(N(A) = B\\) and \\(N(B) = A\\).\n" . 
    #"  Using this fact in combination with our condition for the existence of a  perfect matching, we have \\(|B| \\geq |A|\\) and \\(|A| \\geq |B|\\), which implies the necessary, but not sufficient, condition that \\(|A| = |B|\\)." . 
    #"  Noting that each perfet matching must use " . ptex::inlineMath("|A| = |B| = " . ptex::frac("n",2)) . " edges and that \\(T\\) has \\(n-1\\) edges, it is impossible to have more than one perfect matching in \\(T\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.1.16";
$thm = "For \\(k \\geq 2\\), prove that \\(Q_k\\) has at least \\(2^{(2^{k-2})}\\) perfect matchings.\n";
$pf = "Any \\(Q_k\\) can be formed by taking two copies of \\(Q_{k-1}\\) and making adjacent any two equivalent edges.\n" . 
    "  So, inductively construct \\(Q_k\\) from \\(Q_{k-1}\\) and count the matchings along the way.\\\\\n\n" . 
    "  Case: \\(k = 2\\).  \\(Q_k\\) is isomorphic to \\(C_4\\), so any two parallel vertices form a perfect matching, of which there are two.\n" . 
    "  \\(2^{(2^{k-2})} = 2\\) holds.\n\n". 
    "  Assume \\(k > 2\\) and assume for every \\(Q_j\\) with \\(j < k\\) that the number of perfect matchings is \\(2^{(2^{j-1})}\\).\n" .
    "  Construct \\(Q_k\\) from two copies of \\(Q_{k-1}\\).\n" . 
    "  Each has \\(2^{(2^{(k-1)-2})} = \\sqrt(2^{(2^{k-2})}\\) perfect matchings.\n" . 
    "  So, any combination of one perfect matching from one \\(Q_{k-1}\\) and one perfect matching from the other forms a perfect matching in \\(Q_k\\).\n" . 
    "  Therefore, \\(Q_k\\) has at least \\({\\sqrt(2^{(2^{k-2})})^2} = 2^{(2^{k-2})}\\) perfect matchings.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "";
$thm = "";
$pf = "";

#print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "";
$thm = "";
$pf = "";

#print ptex::thm($name, $name, $thm . ptex::pf($pf));
#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
