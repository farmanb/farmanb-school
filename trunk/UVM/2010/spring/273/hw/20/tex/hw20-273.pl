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
    $course) = (20, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Thursday, April 15, 2010",
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

my $name = "6.1.3"; 
my $thm = "Determine all \\(r,s\\) such that \\(K_{r,s}\\) is planar.\n"; 
my $pf = "  If either of \\((r,s)\\) equal 1, then a star suffices as a planar embedding of the graph.\n\n" . 
    "  If either of \\((r,s)\\) equal 2 and the other is at least as large as 2, then a planar embedding can be constructed as follows.\n" . 
    "  Take the two vertices of the smaller partite set and place them on the top and bottom of the graph, then place the vertices of the larger partite set in a straight line between top and bottom vertices.\n" .
    "  Since all the edges of the graph originate at either the top or bottom and pass to the center, the center vertices can be arranged such that no two edges cross.\n\n" .
    "  If both \\(r\\) and \\(s\\) are larger than 3, then \\(K_{3,3} \\subseteq K_{r,s}\\) and thus the graph is not planar since \\(K_{3,3}\\) is not planar.\n" . 
    "  Hence, \\(K_{r,s}\\) is planar as long as at least one of \\((r,s)\\) is strictly less than 3.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.12";
$thm = "Draw the five regular polyhedra as planar graphs.\n" . 
    "  Show that the octahedron is the dual of the cube and the icosahedron is the dual of the dodecahedron.\n";
$pf = "\n\n" . 
    ptex::center(
	ptex::graphic("imgs/tet.png") .
	ptex::graphic("imgs/cube.png") .
	ptex::graphic("imgs/oct.png") .
	ptex::graphic("imgs/dodec.png") .
	ptex::graphic("imgs/iso.png")
	) .
    "Below are the duals of the cube and dodecahedron drawn over the planar embeddings above.  The vertices marked * are the vertices of the dual.\n" . 
    ptex::center(
	ptex::graphic("imgs/dual1.png").
	ptex::graphic("imgs/dual2.png")
	);

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6.1.13";
$thm = "Find a planar embedding of the graph below.\n";
$pf = "\n\n" . 
    ptex::center(ptex::graphic("imgs/6-1-13.png"));

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
