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
    $course) = ("Term Project", 
		"Math-255");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("Blake Farman", 
	       "$course: $num\\\\\n");

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

my $name = "36.2";
my $thm = "Use the formula \\({n \\choose k} = ". ptex::frac("n!","k!(n-k)!") . "\\)to prove the addition formula \\[{n \\choose k-1} + {n \\choose k} = {n+1 \\choose k}.\\]\n";
my $pf =  "Expanding the binomial coefficients using the factorial definition yields".
    "$beq\n" .
    ptex::printEqnArray([["{n \\choose k-1} + {n \\choose k} = {n+1 \\choose k}", ptex::frac("n!","(k-1)!(n-k+1)!") . "+" . ptex::frac("n!","(k)!(n-k)!")],
			 ["",ptex::frac("kn! + (n-k+1)n!","k!(n-k+1)!") . "."]], "=") .
    "$eeq\n" . 
    "  Then simplifying yields \n" . 
    "\\[" . ptex::frac("(n+1)!","k!(n+1-k)!") . " = {n+1 \\choose k}\\]" . 
    "  as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $eps = "\\varepsilon";

$name = "36.3";
$thm = "What is the value obtained if we add up a row \\[{n \\choose 0} + {n \\choose 1} + {n \\choose 2} + {n \\choose 3} + \\ldots + {n \\choose n-1} + {n \\choose n}\\] of Pascal's Triangle?  Compute some values, formulate a conjecture, and prove that your conjecture is corret.\n";
$pf =  "We will use induction on \\(n\\) to prove \\[\\sum_{k=0}^{n}{n\\choose k} = 2^n.\\]\n" . 
    "  As a base case, we see \\({1 \\choose 0} + {1 \\choose 1} = 2^1\\).\n" . 
    "  Assume the induction hypothesis holds up to \\(n > 1\\).\n" . 
    "  Using the result from (36.2), the inner terms of the sum can be expanded as follows\n" . 
    "  \\[\\sum_{k=0}^{n} {n \\choose k} = 1 + {n-1 \\choose 0} + {n-1 \\choose 1} + {n-1 \\choose 1} + \\ldots + {n-1 \\choose n-2} + {n-1 \\choose n-2} + {n-1 \\choose n-1} + 1.\\]\n" . 
    "  Since each term appears twice, we have \\[\\sum_{k=0}^{n} {n \\choose k} = 2\\sum_{k=0}^{n-1} {n \\choose k} = 2(2^{n-1}) = 2^n.\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "36.5";
$thm = "This exercise presupposes some knowledge of calculus.\n" . 
    "  If \\(n\\) is a positive integer, then putting \\(A = 1\\) and \\(B = x\\) in the formula for \\((A+B)^n\\) gives\n" . 
    "  \\[(1+x)^n = {n \\choose 0} + {n \\choose 1}x + {n \\choose 2}x^2 + {n \\choose 3}x^3 + \\ldots + { n \\choose n-1}x^{n-1} + {n \\choose n}x^n.\\]\n" . 
    "  In the previous exercise we noted that the binomial coefficient \\({n \\choose k}\\) makes sense even if \\(n\\) is not a positive integer.\n" . 
    "  Assuming that \\(n\\) is not a positive integer, prove that the infinite series\n" . 
    "  \\[(1+x)^n = {n \\choose 0} + {n \\choose 1}x + {n \\choose 2}x^2 + {n \\choose 3}x^3 + \\ldots\\] converges to the value \\((1 +  x)^n\\) provided that \\(x\\) satisfies \\(|x| < 1\\).";
$pf = "Let \\(f:\\mathbb{R} \\rightarrow \\mathbb{R}\\) be defined by \\(f(x) = (1+x)^{\\alpha}\\).\n" .
    "  By Taylor's Formula \\[(1+x)^{\\alpha} = \\sum_{k=0}^{\\infty} " .ptex::frac("f^{(k)}(0)","k!") . "x^k.\\]\n" . 
    "  Computing the \\(k^{th}\\) derivative of \\(f\\) in the normal way yields \\[f^{(k)}(x) = \\alpha(\\alpha-1)\\ldots(\\alpha-k+1)(1+x)^{\\alpha-k}.\\]\n" . 
    "  Hence evaluating this at the base point \\(a = 0\\) yields \\[(1+x)^{\\alpha} = \\sum_{k=0}^{\\infty} {\\alpha \\choose k} x^k.\\]" . 
    "  Taking \\(a_k = {\\alpha \\choose k}x^k\\), the Taylor series converges when \\[\\lim_{k \\rightarrow \\infty} \\left| ".ptex::frac("a_{k+1}", "a_k") ."\\right| < 1.\\]\n" . 
    "  Applying L'H\\^opital's Rule to the simplified limit yields \\[\\lim_{k \\rightarrow \\infty} \\left|" . ptex::frac("k+1", "n-k") . "\\right||x| = |x|.\\]\n" . 
    "  Therefore, the Binomial series converges when \\(|x| < 1\\).\n";
    #"  All that remains is to show that \\(\\lim_{n \\rightarrow \\infty}R_n(x,a) = 0\\) on the open neighborhood \\(B_1(0)\\)." .
    #"  First, consider the Lagrange form of the remainder when \\(x \\in (0,1)\\).\n" . 
    #"$beq\n" .
    #ptex::printEqnArray([["|R_n(x,0)|", "\\left| ".ptex::frac("\\alpha(\\alpha-1)\\ldots(\\alpha-n+1)","n!") . "(1+c_n)^{\\alpha-n}x^n\\right|, \\quad \\text{ for } c \\in (0,x)"],
    #["","\\left|" . ptex::frac("\\prod_{i=1}^{n}\\left(i - \\left(\\alpha+1\\right)\\right)","n!") . "(1+c_n)^{\\alpha}\\left(" . ptex::frac("x","1+c_n"). "\\right)^n\\right|"]],"=") .
    #ptex::printEqnArray([["", ptex::frac("n!", "n!"). "\\left|(1+c_n)^{\\alpha}\\left(" . ptex::frac("x","1+c_n"). "\\right)^n\\right|"]],"\\leq") .
    #ptex::printEqnArray([["", "\\left|(1+c_n)^{\\alpha}\\left(" . ptex::frac("x","1+c_n"). "\\right)^n\\right|."]],"\\leq") .
    #"$eeq\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
