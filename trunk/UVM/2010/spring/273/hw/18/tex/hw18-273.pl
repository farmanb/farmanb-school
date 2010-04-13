#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","amssymb");

#Cover Page info.
my ($num,
    $course) = (18, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Thursday, April 8, 2010",
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

my $name = "5.1.20"; 
my $thm = "Let \\(G\\) be a graph whose odd cycles are pairwise intersecting, meaning that every two odd cycles in \\(G\\) have a common vertex.  Prove that \\(\\chi(G) \\leq 5\\).\n"; 
my $pf = "Let \\(G\\) be a graph whose odd cycles are pairwise intersecting and let \\(C \\subseteq G\\) be an odd cycle.\n" . 
    "  Let \\(H \\subset G\\) be the subgraph induced by the vertices \\(V(G) \\setminus V(C)\\).\n" . 
    "  Clearly, \\(G \\subseteq C \\vee H\\).\n" . 
    "  Hence, it remains to show that \\(\\chi(C \\vee H) \\leq 5\\).\n\n" . 
    "  Since it was assumed that all the odd cycles of \\(G\\) are pairwise intersecting, it must be that any odd cycle contained by \\(H\\) must be disjoint from \\(C\\).\n" .
    "  However, it was assumed that the odd cycles of \\(G\\) are pairwise intersecting and so this must not be the case.\n" . 
    "  Hence, \\(\\chi(H) \\leq 2\\).\n" . 
    "  Therefore, \\[\\chi(C \\vee H) = \\chi(C) + \\chi(H) \\leq 5.\\]\n"; 

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5.1.31";
$thm = "Prove that a graph \\(G\\) is \\(m\\)-colorable if and only if \\(\\alpha(G \\Box K_m) \\geq n(G)\\).\n";
$pf = "Using propositions 5.1.7, 5.1.11 and some routine algebra, we obtain  \\[\\alpha(G \\Box K_m) \\geq " . ptex::frac("m|V(G)|", "\\max\\{\\chi(G), m\\}") . ".\\]\n\n" . 
    "  Assume \\(\\chi(G) \\leq m\\).\n" . 
    "  From this it follows directly that the right hand side of the above inequality equals \\(|V(G)|\\).\n\n" . 
    "  Conversely, assume \\(\\alpha(G \\Box K_m) \\geq |V(G)|\\)." . 
    "  Clearly, in order to satisfy the inequality \\(\\alpha(G \\Box K_m) \\geq |V(G)|\\), it must be that \\(\\chi(G) \\leq m\\).\n\n" . 
    "  Therefore, \\(G\\) is \\(m\\)-colorable if and only if \\(\\alpha(G \\Box K_m) \\geq |V(G)|\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
