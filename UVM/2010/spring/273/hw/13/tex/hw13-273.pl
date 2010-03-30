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
    $course) = (13, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("", 
	       "Thursday, March 18, 2010",
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

my $name = "3.3.4";
my $thm = "Let \\(G\\) be a \\(k\\)-regular bipartite graph.  Prove that \\(G\\) can be decomposed into \\(r\\)-factors if and only if \\(r\\) divides \\(k\\).\n";
my $pf = "Let \\(G\\) be a \\(k\\)-regular, bipartite graph such that \\(G\\) decomposes into \\(n\\) \\(r\\)-factors, \\(G_1, \\ldots, G_n\\).\n" . 
    "  Since these \\(r\\)-factors decompose \\(G\\), \\(E(G) = E(G_1) + \\ldots + E(G_n)\\)\n" .
    "  Using proposition 1.3.3 and some trivial algebra, \\[n = " . ptex::frac("k", "r") .".\\]\n" .
    "  Therefore, \\(r\\) must divide \\(k\\).\n\n" . 
    "  Conversely, let \\(r \\equiv 0 \\text{ (mod }k)\\).\n" . 
    "  Since \\(G\\) is \\(k\\)-regular and bipartite, \\(G\\) has a perfect matching.\n" .
    "  Removing a perfect matching from \\(G\\) yields bregular, bipartite graphs with smaller edge sets (but the same vertex set), which also have perfect matchings.\n" . 
    "  Then, successively removing perfect matchings from the resulting graphs yields smaller and smaller edge sets until only an independent set remains\n" .
    "  So, there are \\(k\\) perfect matchings, \\(M_1, \\ldots, M_k\\).\n" .
    "  Since \\(r\\) divides \\(k\\), collect these \\(k\\) perfect matchings of \\(G\\) into groups of size \\(r\\).\n" . 
    "  For each collection of perfect matchings, form an r-factor from the union of the perfect matchings.\n" .
    "  These \\(r\\)-factors are guaranteed to decompose \\(G\\) since \\(M_i \\cap M_j \\not = \\phi\\) if and only if \\(i = j\\) by their construction.\n" .
    "  Therefore, \\(G\\) is \\(r\\)-factorable.\n";
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.3.7";
$thm = "For each \\(k > 1\\), construct a \\(k\\)-regular simple graph having no 1-factor.\n";
$pf = "Let \\(k\\) be even and let \\(G\\) be \\(K_{k+1}\\).\n" . 
    "  Let \\(S = \\phi\\).\n" . 
    "  Then, \\(o(G-S) = 1 > 0\\).\n" . 
    "  Therefore, by Tutte's condition, \\(G\\) does not have a 1-factor.\n\n". 
    "  Let \\(k\\) be odd and construct \\(G\\) in the following way.\n" . 
    "  Start with \\(K_{k+1}\\) and remove a perfect matching.\n" . 
    "  Add in a new vertex and connect it to any \\(k\\) vertices.\n" . 
    "  There are now \\(k+1\\) vertices of degree \\(k\\) and one vertex of degree \\(k-1\\).\n" . 
    "  Create \\(k\\) copies of this graph so that there are now \\(k\\) vertices of degree \\(k-1\\).\n" . 
    "  Now add in a new vertex and connect it to all the vertices of degree \\(k-1\\)." . 
    "  The constructed graph is now \\(k\\)-regular.\n" . 
    "  Let \\(S\\) be the set consisting only of this last vertex added to the graph.\n" . 
    "  Then, \\(G-S\\) has \\(k\\) components, each with \\(k+2\\) vertices.\n" . 
    "  Since \\(k\\) was assumed to be at least 1, \\(\\text{o}(G-S) = k > |S|\\), which violates Tutte's condition\n". 
    "  Therefore, \\(G\\) does not have a 1-factor.\n";
    
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3.3.8";
$thm = "Prove that if a graph \\(G\\) decomposes into 1-factors, then \\(G\\) has no cut-vertex.  Draw a connected 3-regular simple graph that has a 1-factor and has a cut-vertex.\n";
$pf = "Let \\(G\\) be such that \\(G\\) decomposes into 1-factors, \\(G_1, \\ldots, G_n\\).\n" . 
    "  Assume that \\(v \\in V(G)\\) is a cut vertex.\n". 
    "  Let \\(S = \\{v\\}\\).\n" .
    "  Since \\(G\\) must have even order, \\(G-S\\) has odd order and hence must have at least one odd component, say \\(X\\).\n" .
    "  Hence, for some \\(x \\in V(X)\\), \\(v\\) and \\(x\\) must be adjacent in any 1-factor.\n\n" .
    "  Consider that since \\(v\\) is a cut vertex, for some some \\(u \\not \\in V(X)\\), \\(uv \\in E(G)\\).\n" . 
    "  Since \\(G_1, \\ldots, G_n\\) decompose \\(G\\), then for some \\(G_i\\), \\(uv \\in E(G_i)\\).\n" . 
    "  However, by hypothesis, \\(G_i\\) is necessarily a 1-factor and so \\(ux \\in E(G_i)\\).\n" . 
    "  Then \\(\\deg(v) > 1\\), but this contradicts the definition of a 1-factor.\n" . 
    "  Therefore, \\(G\\) does not have a cut vertex.\\\\\n\n" .
    "Below is a  3-regular, simple graph with a cut vertex and its 1-factor." .
    ptex::center(ptex::graphic("./imgs/graph.png",.25) . "\n\n" . 
		 ptex::graphic("./imgs/match.png",.25));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
