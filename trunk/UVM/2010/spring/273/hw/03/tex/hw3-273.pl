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
    (3, "Math-273");

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
    "date" => "Thursday, January 28, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $name = "1.1.25\n";
my $thm = "Prove that the Petersen graph has no cycle of length 7.\n";
my $pf = "Suppose that the Petersen graph has a cycle of length 7, \\(C\\).\n" . 
    "  Consider some vertex, \\(v\\), on \\(C\\).\n" . 
    "  There are 6 other vertices on \\(C\\), of which 2 are reachable from \\(v\\) by a path of length \\(1\\) , two are reachable by a path of length \\(2\\) and two are reachable from a path of length \\(3\\).\n" . 
    "  Each vertex which is not adjacent to \\(v\\) shares a common vertex to which both are adjacent.\n" . 
    "  Those two which are reachable by a path of length \\(1\\) are adjacent, so they do not share a common vertex and those two which are reachable by a path of length \\(2\\) share the vertex along that path.\n" . 
    "  All that remains are the two vertices, call them \\(s \\text{ and } t\\), which are reachable by a path of length \\(3\\).\n\n" . 
    "  Consider \\(s\\).\n" .
    "  Suppose there was a vertex on \\(C\\) to which both \\(v\\) and \\(s\\) were adajcent.\n" . 
    "  Call this vertex \\(w\\).\n" . 
    "  Then there would be a cycle of length \\(5\\) containing the \\(vs\\)-path on \\(C\\) of length \\(3\\), and the \\(vs\\)-path through \\(w\\) of length \\(2\\)." . 
    "  This is acceptable, however this also creates a second cycle consisting of the \\(sw\\)-path of length \\(3\\) along \\(C\\) and the \\(sw\\) edge.\n" . 
    "  This second cycle has length \\(4\\), which contradicts the fact that the Petersen graph has girth \\(5\\)." . 
    "  Hence, it must be that \\(w\\) is not on \\(C\\)." . 
    "  Similarly, the same holds true for \\(t\\).\n\n" . 
    "  So it must be that \\(v\\) and \\(s\\) are adjacent to some \\(a\\), which is not on \\(C\\), and that \\(v\\) and \\(t\\) are adjacent to some \\(b\\), which also is not on \\(C\\).\n" . 
    "  Since the Petersen graph is \\(3\\)-regular and \\(v\\) is already adjacent to two vertices on \\(C\\), if \\(v\\) is adjacent to both \\(a\\) and \\(b\\), which are not on \\(C\\), it must be that \\(a = b\\).\n" . 
    "  Then \\(s\\) and \\(t\\), which must be adjacent on \\(C\\), are both adjacent to a third vertex, \\(a\\).\n" . 
    "  This implies that \\(sta\\) is a \\(3\\)-cycle.\n" . 
    "  This contradicts the fact that the Petersen graph has girth \\(5\\).\n" . 
    "  Therefore, the Petersen graph does not have a \\(7\\)-cycle.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));


$name = "1.2.4\n";
$thm = "Let \\(G\\) be a loopless graph.  For \\(v \\in V(G)\\) and \\(e \\in E(G)\\), describe the adjacency and incidence matrices of \\(G-v\\) and \\(G-e\\) in terms of the corresponding matrices for \\(G\\).\n";
$pf = "Deleting a vertex, \\(v\\), from \\(G\\) results in deleting the corresponding row and column from the adjaceny matrix.\n" . 
    "  In the incidence matrix, the corresponding row for \\(v\\) is deleted and so is the column for any edge incident \\(v\\).\n\n" . 
    "  Deleting an edge, \\(e = uv\\), from \\(G\\) results in no changes along the rows of either the incidence or adjaceny matrices, however,  the \\(u,v\\) and \\(v,u\\) entries are decremented by \\(1\\) and the column corresponding to \\(e\\) in the incidence matrix is deleted.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
