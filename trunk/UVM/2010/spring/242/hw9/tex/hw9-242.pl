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
my $pf = "(a) The Implicit Function Theorem guarantees a real valued fucntion \\(f\\) of class \\(C^1\\) defined on some neighborhood of \\(x=0\\) such that \\(F(x,f(x)) = 0\\) only if the determinant of the matrix\n" . 
    "  \\[det". ptex::parens(ptex::printMatrix([[ptex::frac("\\partial f", "\\partial y")]],"c"))." = -2y \\not = 0.\\]\n" . 
    "  However in order to satisfy \\(x - y^2 = 0\\) it must be that \\(y = 0\\).  Therefore, the Implicit Function Theorem does not guarantee such a function.\n\n" . 
    "  (b)  If the neighborhood around \\(x = 1\\) is restricted such that the point \\(x = 0\\) is not included, then the determinant above is non-zero and thus the Implicit Function Theorem guarantees a function \\(g(x) = y\\) such that \\(g\\) is injective and of class \\(C^1\\).\n" . 
    "  Then the values of \\(y\\) are those along the curve \\(y = \\pm" . ptex::sqrt("x") . "\\), so selecting \\(g(x) = +" . ptex::sqrt("x") . "\\) yields \\(g(x) > 0\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $eps = "\\varepsilon";

$name = "2";
$thm = "\n";
$pf =  "Let \\(F_1(x,y,u,v) = x^3 + ux + y\\) and \\(F_2(x,y,u,v) = uy+v^3 - x\\) be the component functions of \\(F\\).\n" .
    "The Implicit Function Theorem guarantees solutions for \\(u\\) and \\(v\\) in terms of \\(x\\) and \\(y\\) by injective, class \\(C^1\\) function in neighborhoods where " .ptex::math("det".ptex::parens(ptex::printMatrix([[0,"x"], ["y", "3v^2"]],"cc")) . " = -xy \\not = 0.")."\n" . 
    "  Hence, in a neighborhood where \\(x \\not = 0\\) and \\(y \\not = 0\\), \\(u\\) and \\(v\\) can uniquely be determined in terms of \\(x\\) and \\(y\\).\n\n" .
    "  When \\(F(x,y,u,v) = (0,0)\\), we have that \\(F_1(x,y,u,v) = F_1(x,y,u,v) = 0\\)." . 
    "  Since \\(F_1\\) does not contain any \\(u\\) terms, it is possible to solve for \\(v\\) explicitly in terms of \\(x\\) and \\(y\\), \\[v = ".ptex::frac("-x^3 - y","x").".\\]\n" . 
    "  Then this can be used to find the explicit function, \\[u = " . ptex::frac("x^4 + (x^3 + y)^3", "yx^3") . ".\\]". 
    "  Then calculating the partial of \\(u\\) with respect to \\(x\\) yields \\[" . ptex::frac("\\partial u", "\\partial x") . "=" . ptex::frac("(4x^3 + 9x^2(x^3 + y)^2)yx^3 - 3x^2y(x^4 + (x^3 + y)^3)", "(yx^3)^2").".\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3";
$thm = "\n";
$pf = "Define \\(F: \\mathbb{R}^4 \\rightarrow \\mathbb{R}^2\\) by \\(F = (F_1,F_2)\\) where \\(F_1(x,y,u,v) = x^2 - y^2 - u^3 +v^2 +4\\), \\(F_2(x,y,u,v) = 2xy + y^2 - 2u^2 +3v^4 + 8\\).\n" . 
    "  Then the Implicit Function Theorem guarantees functions \\(u(x,y)\\) and \\(v(x,y)\\) in a neighborhood where " . ptex::math("det" . ptex::parens(ptex::printMatrix([["-3u^2", "2v"], ["-4u", "12v^3"]],"cc")) . " = -36u^2v^3 + 8uv \\not = 0.") . "\n" .
    "  Hence for neighborhoods where \\(u \\not = 0\\), \\(v \\not = 0\\) and \\(uv^2 \\not = ".ptex::frac(2,9)."\\), there exist injective, \\(C^1\\) functions \\(u(x,y)\\) and \\(v(x,y)\\).\n" . 
    "  Since \\((F_1(2,-1,2,1),F_2(2,-1,2,1)) = (0,0)\\) and the neighborhoods of \\(u=2\\) and \\(v=1\\) can be made small enough to guarantee \\(uv^2 \\not = ".ptex::frac(2,9) .", \\text{ and } u,v \\not = 0\\),\n" . 
    " there exist functions \\(u(x,y)\\) and \\(v(x,y)\\) in some neighborhood of \\(x = 2\\) and \\(y = -1\\) such that \\(u(2,-1) = 2\\) and \\(v(2,-1) = 1\\).\n\n" . 
    "  Solving \\(F_1(x,y,u,v) = 0\\) for \\(v\\) and \\(F_2(x,y,u,v) = 0\\) for \\(u\\), then taking the partial derivatives of each with respect to \\(x\\) yields " . 
    ptex::math("v_x = " . ptex::frac("3u^2u_x - 2x","2v")) . 
    ptex::math("2uu_x = y + 6v^3 v_x.") . 
    "  Then substituting in \\(v_x\\) to the equation for \\(u_x\\) and rearranging with routine algebra yields " . ptex::math("u_x = " . ptex::frac("2y - 12v^2x","4u-18v^2u^2").".") . 
    "  So, at the point \\((2,-1,2,1)\\) \\[u_x = " . ptex::frac(13,32) . ".\\]";
    

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
