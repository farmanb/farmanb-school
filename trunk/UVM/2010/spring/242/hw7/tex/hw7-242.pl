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
    $course) = (7, 
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
    "isCP" => 1
};

my ($beq, $eeq) = ("\\begin{eqnarray*}", "\\end{eqnarray*}");

print ptex::preamble($p);

my $name = "1";
my $thm = "Decide which of the following functions have bounded variation on \\([0,1]\\), where in each case \\(f(0)\\) is defined to be \\(0\\).  (Justify your answers.)\n\n" . 
    "(a) \\(f(x) = \\sin(" . ptex::frac(1,"x") . ")\\)\n\n" . 
    "(b) \\(f(x) = x\\sin(" . ptex::frac(1,"x") . ")\\)\n\n" . 
    "(c) \\(f(x) = x^2\\sin(" . ptex::frac(1,"x") . ")\\).\n";
my $pf = "(a) Let \\(P_n\\) be the points \\(\\{".ptex::frac(2, "\\pi(1+2n)")."\\} \\cup \\{0,1\\}, n \\not = 0\\).\n" . 
    "  Then for any interval not containing 0 or 1, the distance between \\(f\\) evaluated at the endpoints is \\[|\\sin(".ptex::frac("\\pi(1+2i)",2).") - \\sin(".ptex::frac("\\pi(1+2(i+1))",2).")| = 2.\\]\n" . 
    "  Hence, given any upper bound, \\(M\\), of \\(V_f(b)\\) there exists some \\(N \\in \\mathbb{N}\\) such that on the partition \\(P_N\\), \\(\\sum_{i=0}^N |f(x_{i+1}) - f(x_i)| \\geq 1 + 2N > M\\)." . 
    "  Therefore, \\(V_f\\) is unbounded.\n\n" . 
    "  (b) Using the same definition of \\(P_n\\) as above, the distance between \\(f\\) evaluated at the endpoints is \\[|" . 
    ptex::frac("\\pi(1+2i)",2) .
    "\\sin(".ptex::frac("\\pi(1+2i)",2).") - ". 
    ptex::frac("\\pi(1+2(i+1))",2)."\\sin(".ptex::frac("\\pi(1+2(i+1))",2).")| = |" . 
    ptex::frac("\\pi(1+2i)",2) . "+" .
    ptex::frac("\\pi(1+2(i+1))",2).
    "|.\\]" . 
    "  After some routine algebra, it is easy to show that the right hand side above is bounded below by \\(" . ptex::frac(1,"4\\pi i") ."\\)." .
    "  Hence, \\(V_f(b) \\geq " .ptex::frac(1,"4\\pi")."\\sum_{i=1}^n " .ptex::frac(1,"i")."\\), which can be made as large as desired.\n" . 
    "  Therefore, \\(V_f\\) is unbounded.\n\n" . 
    "  (c) From 241, \\(f\\) is differentiable on \\((0,1),\\) with derivative \\[f'(x) = 2x\\sin(".ptex::frac(1,"x").") - \\cos(".ptex::frac(1,"x").")\\] and \\(|f'(x)| \\leq 3\\)." . 
    "  Therefore, \\(f\\) is of bounded variation on \\([0,1]\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $eps = "\\varepsilon";

$name = "2";
$thm = "If \\(g\\) is of bounded variation on \\([a,b]\\), prove that \\(V_g - g\\) is increasing on \\([a,b]\\).\n";
$pf = "Let \\(x,y \\in (a,b)\\) with \\(x \\leq y\\).\n" .
    "  Let \\(P\\) be some partiton of \\([a,x]\\) and let \\(P' = P \\cup \\{y\\}\\) be a partition of \\([a,y]\\).\n" . 
    "  Then by the definition of \\(V_g(x)\\),\n" . 
    $beq . "\n" . 
    ptex::printEqnArray([["V_g(y) - V_g(x)", "\\left(\\sum_{i=0}^{n-1} |g(x_{i+1}) - g(x_i)| + |g(y) - g(x)|\\right) - \\left(\\sum_P |g(x_{i+1}) - g(x_i)|\\right)"]], "\\geq") .
    ptex::printEqnArray([["", "|g(y) - g(x)|"]], "=") .
    ptex::printEqnArray([["", "g(y) - g(x)."]], "\\geq") .
    $eeq . "\n" .
    "Hence, \\(V_g(y) - g(y) - (V_g(x) - g(x)) \\geq 0\\) implies \\(V_g - g\\) is increasing as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3";
$thm = "Calculate (with brief justification) the following Riemann-Stieltjes integrals:\n\n" . 
    "(a) \\(\\int_0^{\\pi} \\cos(x)d(\\sin(x))\\)\n\n" . 
    "(b) \\(\\int_{-\\pi}^{\\pi} \\cos(x)d(|\\sin(x)|)\\)\n\n" . 
    "(c) \\(\\int_0^2 x^3 d([x])\\), where [x] is the greatest integer function.\n";
$pf = "(a) Since \\(\\sin(x)\\) is continuous on \\([0,\\pi]\\) and differentiable on \\((0,\\pi)\\), it follows that \\[\\int_0^{\\pi} \\cos(x)d(\\sin(x)) = \\int_0^{\\pi} \\cos^{2}(x)dx.\\]\n" . 
    "  With a little routine calculus, we have \\(\\int_0^{\\pi} \\cos(x)d(\\sin(x)) = " .ptex::frac("\\pi",2)."\\).\n\n" . 
    "  (b) Note that \\(|\\sin(x)|\\) is equal to \\(\\sin(x)\\) on \\([0,\\pi]\\) and \\(-\\sin(x)\\) on \\([-\\pi,0]\\).\n" . 
    "  Rewriting the integral yields " . 
    "\\[\\int_{-\\pi}^{\\pi} \\cos(x)d(|\\sin(x)|) = \\int_{-\\pi}^{0} \\cos(x)d(|-\\sin(x)|) + \\int_{0}^{\\pi} \\cos(x)d(|\\sin(x)|).\\]\n" . 
    "  Then, \\(\\sin(x)\\) and \\(-\\sin(x)\\) are continuous on their respective closed intervals and differentiable on the interiors of those intervals.\n" . 
    "  Therefore, " . 
    "\\[\\int_{-\\pi}^{\\pi} \\cos(x)d(|\\sin(x)|) = \\int_0^{\\pi} \\cos^{2}(x)dx - \\int_{-\\pi}^{0} \\cos(x)\\sin(x)dx = 0.\\]\n\n" . 
    "  (c)  Since \\([x]\\) is non-decreasing and has only jump discontinuities at the points \\(x = 1\\) and \\(x = 2\\), the function is of bounded variation.\n" . 
    "  Futhermore, everywhere that \\(g\\) is continuous, \\(g\\) is also constant and \\(\\int fd(g_c) =  \\int fg'dx = 0\\)." .
    "  Then, the value of the integral is \\(f\\) evaluated at the jump discontinuities of \\(g\\) multiplied by the distance of the jump.\n" . 
    "  Therefore, \\[\\int_0^2 x^3 d([x]) = (1^3)(1-0) + (2^3)(2-1) = 9.\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
