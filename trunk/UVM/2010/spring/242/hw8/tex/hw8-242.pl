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
    $course) = (8, 
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
my $pf = "(a) Calculating the Jacobian matrix in the normal way yields" . ptex::math("Jf(x,y) = " . ptex::printMatrix([["3(x-y)^2", "-3(x-y)^2"], ["1", "1"]],"cc"). ".")." \n" .
    "  Then taking its determinant, we have " . 
    ptex::math("\\det(Jf(x,y)) = 6(x-y)^2.") ."\n" . 
    "  Therefore, the Inverse Function Theorem guarantees an inverse around each \\((a_1,a_2)\\) such that \\(a1 \\not = a2\\).\n\n" .
    "(b)  Let \\((x_0,y_0),(x_1,y_1) \\in R^2\\) be given.\n" . 
    "  Suppose \\(f(x_0,y_0) = f(x_1,y_1)\\)." . 
    "  Reducing the result yields \\(x_0 + y_0 = x_2 + y_2\\) and \\(x_0 - y_0 = x_1 - y_1\\).\n" . 
    "  Solving the second equation for \\(x_0\\) and using the result in the first equation yields \\(y_0 = y_1\\).\n" . 
    "  Solving either equation with this results yields \\(x_0 = x_1\\).\n" . 
    "  Therefore, by definition \\(f\\) is injective.\n\n" .
    "(c) With a few simple calculations, the inverse is " .
    ptex::math("f^{-1}(x,y) = \\left( " . ptex::frac(1,2) . "(y + \\sqrt[3] x), " . ptex::frac(1,2) . "(y - \\sqrt[3] x) \\right).") .
    "(d)  Calculating the Jacobian matrix from the inverse above," .
    ptex::math("Jf^{-1}(x,y) = " .ptex::printMatrix([[ptex::frac(1, "6\\sqrt[3] x^2"),ptex::frac(1,2)], [ptex::frac("-1", "6\\sqrt[3] x^2"),ptex::frac(1,2)]],"cc") . ".\n") .
    "Clearly \\(Jf(0,y)\\) does not exist.  Therefore the inverse is not of class \\(C^1\\) everywhere.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $eps = "\\varepsilon";

$name = "2";
$thm = "\n";
$pf =  "(a) Calculating the Jacobian in the usual way we have " . ptex::math("Jf(r,\\theta,\\varphi) = " .ptex::printMatrix([["\\cos(\\theta)\\sin(\\varphi)", "-r\\sin(\\theta)\\sin(\\varphi)", "r\\cos(\\theta)\\cos(\\varphi)"],
				     ["\\sin(\\theta)\\sin(\\varphi)", "r\\cos(\\theta)\\sin(\\varphi)","r\\sin(\\theta)\\cos(\\varphi)"],
				     ["\\cos(\\varphi)", "0","-r\\sin(\\varphi)"]],"ccc").  ".") . "\n" . 
    "Then with a few reductions by routine algebra,\\[\\det(Jf(r,\\theta,\\varphi)) = -r^2\\sin(\\phi).\\]\n" . 
    "  Therefore, the Inverse Function Theorem guarantees an inverese when \\(r \\not = 0\\) and \\(\\varphi \\not = 0\\).\n\n" . 
    "(b) Since the component functions are periodic, there does not exist a global inverse of \\(f\\).\n\n" . 
    "(c) By the Inverse Function Theorem, for \\(0,1,0 = f\\left(1," . ptex::frac("\\pi",2) ."," .ptex::frac("\\pi",2)."\\right)\\), we have" . 
    ptex::math("Jf^{-1}(0,1,0) = Jf\\left(1," . ptex::frac("\\pi",2) ."," .ptex::frac("\\pi",2)."\\right)^{-1} = " .ptex::printMatrix([[0,1,0],
				  [-1,0,0],
				  [0,0,-1]],"ccc") . ".");

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3";
$thm = "\n";
$pf = "To check that \\(Df(0,0)\\) is nonsingular, we show that the determinant of the Jacobian matrix of \\(f\\) is non-zero.\n"  .
    "  In order to compute the Jacobian matrix, since \\(f\\) is defined piecewise, we must compute " . 
    "\\[" . ptex::frac("\\partial f_1(0,0)", "\\partial x") . 
    " = \\lim_{x \\rightarrow 0} ".
    ptex::frac("f(x-0)-f(0)" , "x - 0") . 
    ".\\]" . 
    "  With some routine algebra, the limit reduces down to \n" .
    "\\[". ptex::frac("\\partial f_1(0,0)", "\\partial x") ." = \\lim_{x \\rightarrow 0} \\left( 1+x \\sin\\left(" . ptex::frac(1,"x")  . "\\right)\\right) = 1.\\]\n" . 
    "  Then using routine calculus to compute the other partial derivatives, we obtain\n" . 
    ptex::math("Jf(0,0) = " . ptex::printMatrix([["1","0"],[0,1]],
				 "cc").".\n") . 
    "  Then since \\(\\det(Jf(0,0)) = 1 \\not = 0\\), it follows that \\(Df(0,0)\\) is nonsingular.\n\n" . 
    "  To show \\(f\\) is not injective in any neighborhood, if we fix \\(y\\), then it suffices to show that \\(f_1(x,y)\\) is not injective in any neighborhood about 0.\n" . 
    "  When \\(x\\) is non-zero, \\[ " . ptex::frac("\\partial f_1(x,y)", "\\partial x") . " = 1 + 2x\\sin\\left(" . ptex::frac(1,"x")  . "\\right) - \\cos\\left(" . ptex::frac(1,"x")  . "\\right)\n\\] and \n" . 
    "  \\[" . ptex::frac("\\partial^2 f_1(x,y)", "\\partial x^2") . " = 2\\sin\\left(" . ptex::frac(1,"x")  . "\\right) - " .ptex::frac("2\\cos\\left(" . ptex::frac(1,"x")  . "\\right)", "x"). " - " . ptex::frac("\\sin\\left(" . ptex::frac(1,"x"). "\\right)" , "x^2")  .".\\]\n" . 
    "  First observe " . 
    ptex::math(ptex::frac("\\partial f_1(".ptex::frac(1,"2n\\pi").",y)", "\\partial x") . " = 0")  .
    " and " .
    ptex::math(ptex::frac("\\partial^2 f_1(".ptex::frac(1,"2n\\pi").",y)", "\\partial x^2") . " = -4n\\pi < 0") . "\n" . 
    "  By calculus, the points \\(x_n = " . ptex::frac(1,"2n\\pi"). "\\) are maxima and hence \\(f\\) can not be injective.  Similarly, using \\(y_n = -x_n\\), the same is true for points to the left of zero since cosine is an even function.\n\n" . 
    "  Furthermore, since \\({x_n}\\) is bounded below by 0 and monotone decreasing \\[\\lim_{x \\rightarrow \\infty} x_n = 0.\\]" . 
    "  Then let \\(\\varepsilon > 0\\) be given.  There exists an \\(N \\in \\mathbb{N}\\) such that \\(x_n \\in B_{\\epsilon}(0) \\subseteq \\mathbb{R}\\) whenever \\(n \\geq N\\).\n" . 
    "  So it follows that \\((x_n,y) \\in B_\\varepsilon(0,0) \\subseteq \\mathbb{R}^2\\) for some \\(y\\) and thus \\[Jf(x_n,y) = ".ptex::printMatrix([[0,0],[1,0]],"cc").".\\]" . 
    "  Hence \\(\\det(Jf(x_n,y)) = 0\\).\n" . 
    "  Therefore there does not exist a neighborhood of \\((0,0)\\) such that \\(Df(x,y)\\) is nonsingular for every \\((x,y)\\) in the neighborhood.\n";
    

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
