#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm", "amssymb");

#Cover Page info.
my ($num,
    $course) = (9, 
		"Math-242");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("Blake Farman", 
	       "$course: Homework $num\\\\\n");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    #"date" => $date,
    "isCP" => 1,
    "other" => "\\openup 5pt"
};

my ($beq, $eeq) = ("\\begin{eqnarray*}", "\\end{eqnarray*}");

print ptex::preamble($p);

my $name = "1";
my $thm = "\n";
my $pf = "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $eps = "\\varepsilon";

$name = "2";
$thm = "\n";
$pf =  "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3";
$thm = "\n";
$pf = "\n";
    

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
