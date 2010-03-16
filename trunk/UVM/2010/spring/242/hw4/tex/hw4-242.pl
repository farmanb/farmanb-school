#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm");

#Cover Page info.
my ($num,
    $course) = (4, 
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

#my $name = "1\n";
#my $thm = "Let \\(f(x) = \\ln(1+x)\\)\n" . 
#    "  a)  Find the Taylor series for \\(f(x)\\) expanded about the base point \\(a = 0\\).\n\n" . 
#    "  b)  Find the radius of convergence and interval of con;
#my $pf = "\n";

#print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $name = "2\n";
my $thm = "Let \\(g(x,y) = e^x\\arctan(y)\\).\n\n" . 
    "  a) Find the Taylor polynomial containing all terms of degree less than or equal to 4 for \\(g(x,y)\\), expanded about the base point \\((a,b) = (0,0)\\).\n" . 
    "  Call this polynomial \\(P_4(x,y)\\).\n\n" . 
    "  b) Estimate the error of \\(P_4(1,1)\\) using your favorite formula for the remainder.  (Your estimate may be \\emph{very} crude too!)\n";
my $pf = "a) Let \\(\\phi : [0,1] \\rightarrow \\mathbb{R}^2\\) be the function defined by \\(\\phi(t) = (tx,ty)\\), which parameterizes the line between \\((0,0)\\) and \\((1,1)\\).\n " . #part a
    "  Let \\(G : [0,1] \\rightarrow \\mathbb{R}\\) be defined by \\(G = g \\circ \\phi\\), so that \\(G(t) = e^{\\phi(t)}\\arctan(\\phi(t))\\).\n" . 
    "  Then \\[T_4(\\tau,a) = G(a) + \\sum_{k=1}^{4}" . ptex::frac(1,"k!") . "G^{(k)}(a)(\\tau - a)^k,\\]\n" . 
    "  where \\[G^{(k)}(a) = (x" . ptex::frac("\\partial", "\\partial x") ." + y" . ptex::frac("\\partial", "\\partial y") . ")^{k}g|_{\\phi(a)}, \\text{ for each } k \\in [0,n].\\]\n" . 
    "  When \\(a = 0\\) and \\(\\tau = 1\\), the resulting Taylor series is precisely that of \\(g(x,y)\\),\n" . 
    "  \\[T_4(1,0) = P_4(x,y) = y(1 + x + " . ptex::frac(1,2) .  "x^2 + " . ptex::frac(1,6). "x^3) - " .ptex::frac(1,3). "y^3(1+x) + " . ptex::frac(1,6) . "y^4.\\]\n\n" .
    #part b
    "  b) Using the Lagrange form, the remainder for \\(P_4\\) is the same as that of \\(T_4\\) when we fix \\((x,y) = (1,1)\\), \\(\\tau = 1\\) and \\(a = 0\\), \n" . 
    "  \\[R_5(1,0) = " . ptex::frac("G^{(5)}(c)(1-0)^5", "5!") .", \\text{ } c \\in (0,1).\\]\n" .
    "  Using the form of \\(G^{(k)}(a)\\) above and noting that \\(" . ptex::frac("\\partial^i g", "\\partial^i x") . " = g, \\text{ for each } i \\in \\mathbb{N}\\), we have\n" .
    "  \\[G^5(c) = g(\\phi(c)) + 5g_{y}(\\phi(c)) + 10g_{yy}(\\phi(c)) + 10g_{yyy}(\\phi(c)) + 5g_{yyyy}(\\phi(c)) + g_{yyyyy}(\\phi(c))\\]\n" .
    "  Let \\(u(t) = 1 + t^2\\).  Then \\(u'(t) = 2t\\) and \\(u''(t) = 2\\).  With this, we have the following partial derivatives of \\(g\\).\n" .
    $beq . "\n" .
    ptex::printEqnArray([["g(\\phi(c))", "e^c\\arctan(c)"],
			 ["g_y(\\phi(c))", ptex::frac("e^c", "u(c)")],
			 ["g_{yy}(\\phi(c))", ptex::frac("-e^c", "u(c)") . ptex::frac("u'(c)", "u(c)")],
			 ["g_{yyy}(\\phi(c))", "2" .ptex::frac("e^c", "u(c)") . "\\left( \\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)^2 - " . ptex::frac("1", "u(c)") . "\\right)"],
			 ["g_{yyyy}(\\phi(c))", ptex::frac("e^c", "u(c)") . "\\left( -6\\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)^3 + 8\\left(" . 
			  ptex::frac("u'(c)", "u(c)^2") . "\\right) + 4\\left(" .ptex::frac("1", "u(c)^2") ."\\right)\\right)"],
			 ["g_{yyyyy}(\\phi(c))", ptex::frac("e^c", "u(c)") . "\\left(24 \\left(" . ptex::frac("u'(c)", "u(c)"). "\\right)^4 - 60\\left(". 
			  ptex::frac("u'(c)^2", "u(c)^3") ."\\right) + 12\\left(" . ptex::frac("u'(c)", "u(c)^3") ."\\right) + 16\\left(". ptex::frac("u'(c)", "u(c)")."\\right)^2" . "\\right)"]], "=") .
    $eeq . "\n" . 
    "  Substituting these into the above equation for \\(G^{(5)}(\\phi(c))\\) and performing a little algebraic manipulation yields\n" . 
    $beq . "\n" .
    ptex::printEqnArray([["G^{(5)}(\\phi(c))", "e^c\\arccos(c) + " . ptex::frac("e^c", "u(c)") ."\\left[" . 
			  "5" . 
			  "+ 36 \\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)^2" . 
			  "\\right."]
			], "=") .
    ptex::printEqnArray([["", "40\\left(" . ptex::frac("u'(c)", "u(c)^2") . "\\right)" . 
			  "+ 20\\left(" .ptex::frac("1", "u(c)^2") ."\\right)" .
			  "24 \\left(" . ptex::frac("u'(c)", "u(c)"). "\\right)^4 " . 
			  "+ 12\\left(" . ptex::frac("u'(c)", "u(c)^3") ."\\right)"]], "+").
    ptex::printEqnArray([["",  "\\left.\\left." .
			  "\\left(" . "10 \\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)" . 
			  "+ 20 \\left(" . ptex::frac("1", "u(c)") . "\\right)" . 
			  "+ 30\\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)^3 " .
			  "+ 60\\left(" . ptex::frac("u'(c)^2", "u(c)^3") ."\\right)" .
			 "\\right.\\right)\\right]"]], "-") .
    $eeq . "\n" . 
    "  Comparing the distance between values of \\(u\\) and \\(u\\), we have \\(|u'(c) - u(c)| = |c^2 -2c+1| = (c-1)^2 = u(c) - u'(c) \\leq u(c)\\).\n" . 
    "  Equivalently, \\(-u(c) \\leq u'(c) - u(c) \\leq u(c)\\).\n" .
    "  Hence, \\(" . ptex::frac("u'(c)", "u(c)") . "\\leq 2\\), for each \\(c \\in (0,1)\\)." .
    "  Furthermore, since \\(u(c) > 1\\), we have \\(" . ptex::frac(1,"u(c)") . "< 1\\), for each \\(c \\in (0,1)\\).\n" .
    "Using these two inequalities and the triangle inequality yields the following.\n" . 
    $beq . "\n" .
    ptex::printEqnArray([["|G^{(5)}(\\phi(c))|", "e^c \\left|\\arccos(c)\\right| +" . ptex::frac("e^c", "u(c)") ."\\left[" . 
			  "5" . 
			  "+ 36 \\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)^2" . 
			  "\\right."]
			], "\\leq") .
    ptex::printEqnArray([["", "40 \\left(" . ptex::frac("u'(c)", "u(c)^2") . "\\right)" . 
			  "+ 20\\left(" .ptex::frac("1", "u(c)^2") ."\\right)" .
			  "24 \\left(" . ptex::frac("u'(c)", "u(c)"). "\\right)^4 " . 
			  "+ 12\\left(" . ptex::frac("u'(c)", "u(c)^3") ."\\right)"]], "+").
    ptex::printEqnArray([["",  "\\left." .
			  "\\left(" . "10 \\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)" . 
			  "+ 20 \\left(" . ptex::frac("1", "u(c)") . "\\right)" . 
			  "+ 30\\left(" . ptex::frac("u'(c)", "u(c)") . "\\right)^3 " .
			  "+ 60\\left(" . ptex::frac("u'(c)^2", "u(c)^3") ."\\right)" .
			  "\\right)\\right]"]], "+") .
    ptex::printEqnArray([["",  "e(" . ptex::frac("\\pi", 4) . " + 1177)."]], "\\leq") .
    $eeq . "\n" .
    "Therefore, \\[|R_5(1,0)| \\leq " . ptex::frac("e(" . ptex::frac("\\pi", 4) . " + 1177)", 120) . " \\approx 27\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
