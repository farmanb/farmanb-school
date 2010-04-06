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

my $name = "4.2.12"; my $thm = "Use Menger's Theorem to prove that
\\(\\kappa(G) = \\kappa'(G)\\) when \\(G\\) is 3-regular.\n"; my $pf =
"Let \\(G\\) be a 3-regular graph.\n" .  "  Let \\(S\\) be a minimum
vertex cut and let \\(H_1, H_2 \\subset G\\) be the two connected
components "; print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.2.14";
$thm = "A \\(u,v\\)-necklace is a list of cycles \\(C_1, \\ldots, C_k\\) such that \\(u \\in C_1\\), \\(v \\in C_k\\), consecutive cycles share one vertex, and non-consecutive cycles are disjoint.\n" . 
    "  Use induction on \\(\\text{d}(u,v)\\) to prove that a graph \\(G\\) is 2-edge-connected if and only if for all \\(u,v \\in V(G)\\) there is a \\(u,v\\)-necklace in \\(G\\).\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4.2.22";
$thm = "Suppose that \\(\\kappa(G) = k\\) and \\(\\text{diam}(G) = d\\).  Prove that \\(n(G) \\geq k(d-1) + 2\\) and \\(\\alpha(G) \\geq \\lceil " . ptex::frac("(1+d)", 2) ."\\rceil\\).\n" . 
    "  For each \\(k \\geq 1\\) and \\(d \\geq 2\\), construct a graph with connectivity \\(k\\) and diameter \\(d\\) for which equality holds in both bounds.\n";
$pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print "\\newpage";

$name = "4.2.23";
$thm = "Use Menger's Theorem (\\(\\kappa(x,y) = \\lambda(x,y)\\) when \\(xy \\not \\in E(G)\\)) to prove the K\\\"onig-Egerv\\\'ary Theorem (\\(\\alpha'(G) = \\beta(G)\\) when \\(G\\) is bipartite).\n";
$pf = "Let \\(G = A \\cup B\\) be a bipartite graph.\n" . 
    "  Form a new graph, \\(G'\\), from \\(G\\) by joining a vertex \\(s\\) to \\(A\\) and a vertex \\(t\\) to \\(B\\).\n" . 
    "  Observe that \\[G' = (A \\cup \\{t\\}) \\cup (B \\cup \\{s\\})\\] and as such, \\(G'\\) is still bipartite.\n\n" . 
    "  Let \\(k\\) be the maximum number of pairwise internally disjoint \\(s,t\\)-paths in \\(G'\\).\n" . 
    "  By Menger's Theorem, there exists some \\(S \\subseteq V(G)\\) such that \\(S\\) is a minimum \\(s,t\\)-cut and \\(|S| = k\\).\n" . 
    "  Note that since \\(s\\) and \\(t\\) were joined to \\(A\\) and \\(B\\) respectively, in order to disconnect \\(s\\) and \\(t\\) each edge of \\(G\\) must necessarily be deleted.\n". 
    "  Hence, \\(S\\) is necessarily a minimum vertex cover of \\(G\\).\n\n" . 
    "  Since any vertex cover of \\(G\\) must be at least as large as any matching of \\(G\\), it remains to show that there exists a matching of size \\(k\\).\n" . 
    "  Consider the collection of \\(k\\) pairwise internally disjoint \\(s,t\\)-paths." . 
    "  We will show that these paths, minus their endpoints, are in fact a matching of \\(G\\).\n\n" .
    "  Suppose there exists some such path from this collection which alternates between the partite sets, \\(A\\) and \\(B\\).\n" .
    "  If this were the case, then along this path there would exist some edge from \\(A\\) to \\(B\\).\n" . 
    ptex::center(ptex::graphic("imgs/graph.png",.5)) .
    "  Since each of the \\(s,t\\)-paths are internally disjoint, we can cut this edge between the partite sets out and, at the endpoints of this edge which has been cut, we can make those edges adjacent to \\(s\\) and \\(t\\).\n" .
    ptex::center(ptex::graphic("imgs/graph2.png",.5)) . 
    "  Hence, we now have \\(k+1\\) pairwise internally disjoint \\(s,t\\)-paths.\n" .
    "  This contradicts the assumption that there are at most \\(k\\) of these paths and thus it must be that no one of these paths alternates between the partite sets, \\(A\\) and \\(B\\).\n\n" . 
    "  Clearly, when we remove the endpoints of each of these paths we have \\(k\\) pairwise disjoint paths contained in \\(G\\), each of length 1.\n" . 
    "  Therefore, we have exhibited a matching of size \\(k\\) in \\(G\\) and thus \\(\\alpha'(G) = \\beta(G)\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));


#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
