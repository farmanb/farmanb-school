#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;


my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("amssymb","amsmath","latexsym","graphicx","enumerate");

my ($course, $hw) = ("Math-330", 3);
my ($author,
    $title) = ("Blake Farman", "$course: Homework $hw");

print ptex::preAmble($documentClass, \@docClassArgs, \@texPackages, $title, $author);

my $periods = [1053,2318,4086,6560,9680,13510,17820,23160];

foreach my $i (@{[10,20,30,40,50,60,70,80]}){
    print "\\(\\mu = $i\\)\\\\\n" .
	"period \\(=" .  $periods->[($i-1)/10] . "\\)\\\\\n" .
	ptex::graphic("mu/$i.pdf") . 
	"\\newpage\n";
}

my ($bdm, $edm) = ("\\begin{displaymath}\n","\\end{displaymath}\n");
my ($beq, $eeq) = ("\\begin{eqnarray*}\n", "\\end{eqnarray*}\n");

print ptex::graphic("mu/muvp.png") .
    "\\(\\mu\\) (X-axis) vs. Period(T) (Y-axis)\\\\\n" .
    "\\(T \\propto O(\\mu)\\)\\\\\n" .
    #"\\newpage\n" .
    #"$bdm" .
    #"\\left(\n" .
    #"\\begin{array}{cc}\n" .
    #ptex::printArray([["x"], ["y"]]) .
    #"\\end{array}\n" .
    #"\\right)^{'}\n" .
    #"=\n" .
    #"\\left(\n" .
    #"\\begin{array}{cc}\n" .
    #ptex::printArray([["x+y-x(x^2 + y^2)"],
#		      ["y -x - y(x^2 + y^2)"]]) .
    #"\\end{array}\n" .
    #"\\right)\n" .
    #"$edm" .
    #"$bdm" .
    #"x = r(t)\\cos(\\theta(t))\n;y = r(t)\\sin(\\theta(t))\n" .
    #"$edm" .
    #$beq . 
    #ptex::printEqnArray([[ptex::frac("dx","dt"), ptex::frac("dx", "dr") . ptex::frac("dr","dt") . "+" . ptex::frac("dx", "d\\theta") . ptex::frac("d\\theta", "dt")],
#			 [ptex::frac("dy","dt"), ptex::frac("dy", "dr") . ptex::frac("dr","dt") . "+" . ptex::frac("dy", "d\\theta") . ptex::frac("d\\theta", "dt")]], "=") .
    #$eeq .
    "\\newpage\n" .
    "$bdm" .
    "\\left(\n" .
    "\\begin{array}{cc}\n" .
    ptex::printArray([["x"], ["y"]]) .
    "\\end{array}\n" .
    "\\right)^{'}\n" .
    "=\n" .
    "\\left(\n" .
    "\\begin{array}{cc}\n" .
    ptex::printArray([["x+y-x(x^2 + y^2)"],
		      ["y -x - y(x^2 + y^2)"]]) .
    "\\end{array}\n" .
    "\\right)\n" .
    "$edm" .
    ptex::graphic("part2/pred-prey.pdf") .
    "\\newpage\n" .
    "\\(\\mu = -1 < 0\\)\\\\\n" .
    ptex::graphic("part2/negmu.png") .
    "Phase portrait for " . 
    "$bdm" .
    "\\left(\n" .
    "\\begin{array}{cc}\n" .
    ptex::printArray([["x"], ["y"]]) .
    "\\end{array}\n" .
    "\\right)^{'}\n" .
    "=\n" .
    "\\left(\n" .
    "\\begin{array}{cc}\n" .
    ptex::printArray([["\\mu x+y-x(x^2 + y^2)"],
		      ["\\mu y -x - y(x^2 + y^2)"]]) .
    "\\end{array}\n" .
    "\\right)\n" .
    "$edm" .
    "\\\\\n" .
    "\\(\\mu < 0\\) creates a stable spiral at \\(r = 0\\)\\\\\n" .
    ptex::graphic("part2/phase_portrait.png") .
    "\\newpage\n" .
    "\\(\\mu = 1 > 0\\)\\\\\n" .
    ptex::graphic("part2/posmu.png") .    
    ptex::endDoc();
