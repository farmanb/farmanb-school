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
    $course) = (5, 
		"Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("", 
	       "$course: Homework $num\\\\\nSolutions\\\\\n$school");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => "Thursday, February 4, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $k = sub{my $i = shift; return ptex::subs("K", $i)};
my $kn = ptex::inlineMath($k->("n"));
my $g = sub {my $i = shift; return ptex::subs("G", $i)};

my $name = "1.1.33\n";
my $thm = "For \\(n=5\\), \\(n=7\\), and \\(n=9\\), decompose \\(K_n\\) into copies of \\(C_n\\).\n";
my $pf = "\\(C_5:\\)\n\n" . 
    ptex::center(ptex::graphic("imgs/c5/1.png") . 
    ptex::graphic("imgs/c5/2.png")) . 
    "\n\n\\(C_7\\)\n\n" .
    ptex::center(ptex::graphic("imgs/c7/1.png") . 
    ptex::graphic("imgs/c7/2.png") . 
    ptex::graphic("imgs/c7/3.png")) . 
    "\n\n\\(C_9\\)\n\n" . 
    ptex::center(ptex::graphic("imgs/c9/1.png") . 
    ptex::graphic("imgs/c9/2.png") . 
    ptex::graphic("imgs/c9/3.png") . 
    ptex::graphic("imgs/c9/4.png"));
    

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.2.40\n";
$thm = "Let \\(P\\) and \\(Q\\) be paths of maximum length, \\(\\ell\\), in a connected graph \\(G\\).  Prove that \\(P\\) and \\(Q\\) have a common vertex.\n";
$pf = "  Assume \\(P\\) and \\(Q\\) have no common vertices.\n" . 
    "  Given that \\(G\\) is connected, there must exist at least one path between \\(P\\) and \\(Q\\).\n" . 
    "  Let \\(S\\) be the shortest of these paths.\n" . 
    "  \\(S\\) must contain exactly one vertex of \\(P\\) and of \\(Q\\), neither of which may be an endpoint of either maximum path, and \\(S\\) must have length at least one.\n\n" . 
    "  Note that at some point along \\(P\\) and at some point along \\(Q\\), \\(S\\) splits each of these into two paths of not necessarily equal length.\n" . 
    "  Of these four new paths, one contained by \\(P\\) and one contained by \\(Q\\) must have length at least\n" . 
    ptex::inlineMath(ptex::frac("\\ell",2)) .  ".\n" .
    "  Therefore, there exists a path from an endpoint of \\(P\\) to an endpoint of \\(Q\\) which passes through \\(S\\) and uses these two longer paths.\n"  .
    "  The length of this path is at least " . 
    ptex::inlineMath(ptex::frac("\\ell", 2) . "+" . ptex::frac("\\ell", 2) . "+ \\text{length}(S) \\geq \\ell + 1") . ".\n" .  
    "  This contradicts our assumption that \\(P\\) and \\(Q\\) were paths of maximum length.\n" . 
    "  Therefore, \\(P\\) and \\(Q\\) must have at least one common vertex.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
