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
    $course) = (1, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("", 
	       "$course: Homework $num\\\\\nSolutions");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => "Thursday, January 21, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "1.1.5 ";
my $thm = "Prove or Disprove:  If every vertex of a simple graph, \\(G\\), has degree 2, then \\(G\\) is a cycle.\n";
my $pf = "Counterexample:  Consider a simple, disconnected graph with all vertices having degree 2.\n" .
    "  Let \\(G\\) have two connected components;  let one be a 4-cycle and let the other be a 3-cycle.\n" . 
    "  Now, each of the connected components is a cycle by itself.\n" .
    "  Hence, each vertex has degree two,  however G is not a cycle.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.1.10";
$thm = "Prove or Disprove:  The complement of a simple, disconnected graph must be connected.\n";
$pf = "Let \\(G\\) be a simple, disconnected graph and let \\(u,v \\in V(G)\\), with \\(u \\neq v\\).\n" . 
    "  It must be that either \\(u\\) and \\(v\\) belong to the same connected component, or they do not.\\\\\n\n" . 
    "If \\(u\\) and \\(v\\) do not belong to the same connected component, then \\(uv \\not \\in E(G)\\) implies that \\(uv \\in E(\\overline{G})\\).\n" . 
    "  Therefore, there exists a path between \\(u\\) and \\(v\\) in \\(\\overline{G}\\).\\\\\n\n" . 
    "If \\(u\\) and \\(v\\) belong to the same connected component, then there exists some \\(w \\in V(G)\\) such that \\(w\\) does not belong to the same connected component as \\(u\\) and \\(v\\).\n" . 
    "  This guarantees \\(uw \\not \\in E(G)\\) and \\(vw \\not \\in E(G)\\), which implies that \\(uw \\in E(\\overline{G})\\) and \\(vw \\in E(\\overline{G})\\).\n" . 
    "  Therefore, there exists a path between \\(u\\) and \\(v\\) in \\(\\overline{G}\\) which passes through \\(w\\).\\\\\n\n" . 
    "Since \\(u\\) and \\(v\\) were chosen arbitrarily, it must always be the case that there exists a path between between any two vertices of a disconnected graph in the complement.\n" . 
    "  Therefore, the complement of a simple, disconnected graph is connected.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.1.12";
$thm = "Determine whether or not the Petersen graph is bipartite and find the size of its largest independent set.\n";
$pf = "The Petersen graph contains a five cycle, which is not bipartite.  Therefore, the Petersen graph is not bipartite.\\\\\n\n" . 
    "Two vertices in the Petersen graph are non-adjacent if and only if they share a common element of the 5-element set, from which its vertices are 2-element subsets.\n" . 
    "  In order to be an independent set, each vertex must share one common element, so the largest independent set must be of size at most 4.\n" . 
    "  The set \\(\\left\\{12, 13, 14, 15\\right\\}\\) exhibits such a set.\n" . 
    "  Therefore, the largest independent set is of size 4.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";

print ptex::endDoc();
