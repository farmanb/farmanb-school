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
    (7, "Math-273");

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
    "date" => "Thursday, February 11, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "1.3.4\n";
my $thm = "Prove that the graph below is isomorphic to \\(Q_4\\).\n";
my $pf = "\n\n" . 
    ptex::center(ptex::graphic("imgs/4.png"));    

print ptex::thm($name, $name, $thm . ptex::pf($pf));


$name = "1.3.8\n";
$thm = "Which of the following are graphic sequences?  Provide a consrtuction or a proof of impossibility for each.\n";
$pf = "a)\n\n" . 
    ptex::center(ptex::graphic("imgs/8.png")) . "\n\n" . 
    "d) 5,5,5,4,2,1,1,1\n\n" . 
    "4,4,3,1,0,1,1\n\n" . 
    "3,2,1,0,0,0\\\\\n\n" . 
    "The degree sequence reduces to a sequence which has no simple graph representation, thus by theorem 1.3.31, this sequence is not graphic.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.3.9\n";
$thm = "In a league with two divisions of 13 teams each, determine whether it is possible to schedule a season with each team playing nine games against teams within its division and four games against teams in the other division.\n";
$pf = "This graph has a subgraph with 13 vertices of degree 9.  This is an odd number of vertices with an odd degree.  Therefore, this graph is not possible.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
