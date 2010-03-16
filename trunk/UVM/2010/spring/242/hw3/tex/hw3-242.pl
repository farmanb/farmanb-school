#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm");

#Cover Page info.
my ($num,
    $course) = 
    (3, "Math-242");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("Blake Farman", "$course: Homework $num");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    #"date" => "",
    "isCP" => 1
};
print ptex::preamble($p);
#print ptex::preamble($documentClass, \@docClassArgs, \@texPackages, $title, $author, 1,"");

my $d = sub{
    my ($var, $arg) = (@_);
    return "D" . $var->("a") . "($arg)";
};

my $rp = ptex::bb("R","p");
my $rn = ptex::bb("R","n");

my $fcn = sub{
    my $name = shift;
    return sub { my $arg = shift;
		 return "$name($arg)";
    }
};

my $f = sub{
    my $arg = shift;
    return ptex::dot(($fcn->("g"))->($arg),"v");
};

my $def = sub{
    my $var = shift;
    return ptex::lim("x", "a") . 
	ptex::frac(ptex::norm($var->("x") . " - " .  $var->("a") . " - " . $d->($var, "x-a")),ptex::norm("x-a"));
};

my $name = "1";
my $thm = "Let \\(A\\) be an open subset of " . 
    ptex::inlineMath($rn) . 
    " and let " .
    ptex::inlineMath(ptex::fcn("g", "A", $rp)) . 
    ".  Fix some " . 
    ptex::inlineMath("v\\in" . $rp) . 
    " and define " . 
    ptex::inlineMath(ptex::fcn("f","A",ptex::bb("R"))) . 
    " by " . 
    ptex::inlineMath("f(x) = g(x)\\cdot v") . 
    " for all \\(x\\in A\\), where the dot is the usual dot product in \\($rp\\).  Prove that if \\(g\\) is differentiable at \\(a\\in A\\) , then \\(f\\) is also differentiable at \\(a\\) and that ". 
    ptex::math(ptex::dot($d->($fcn->("f"),"u") . " = " . ptex::parens($d->($fcn->("g"), "u")), "v") . "\\text{, for all } u \\in \\mathbb{R}^n") . 
    "where again the dot is the usual dot product in \\($rp\\)." ;

my $pf = "Let \\(B = g(A)\\) be an open subset of \\(\\mathbb{R}^p\\) and let \\(h: B \\rightarrow \\mathbb{R}\\) be the linear transformation defined by \\(h(y) = " . ptex::dot("y", "v") . "\\), for all \\(y \\in B\\)." . 
    "  Using the result from homework 2, exercise 1, \\(h\\) is differentiable at every \\(b \\in B\\) and its derivative is itself, \\(Dh(b)(u) = h\\), for all \\(u \\in $rn\\).\\\\\n\n" .
    "  Now, rewriting \\(f\\) as \\(f = h \\circ g\\), by the Chain Rule \\(f\\) is differentiable at \\(a\\) and its derivative, \\(Df(a)(u)\\), is \\[Dh(b) \\circ (Dg(a)(u)).\\]\n". 
    "  Since \\(Dh(b)(u) = h\\), we have \\[Df(a)(u) = " . ptex::dot("(Dg(a)(u))", "v,") . "\\text{ for all } u \\in \\mathbb{R}^n\\]\n" . 
    "as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2";
$thm = "Let \\(f(x,y,z) = (x + y + z, (xyz)^2)\\) and let \\(g(x,y) = (x^2 + y^3, 5xy)\\).  For an arbitary point \\(P = (a,b,c) \\in \\mathbb{R}^3\\) compute the Jacobian matrix of \\(g \\circ f\\) at \\(P\\) in two ways:\\\\\n" . 
    "(i) first compute \\(g \\circ f\\) at \\(P\\), and then calculate its Jacobian matrix directly,\\\\\n" . 
    "(ii) compute \\(Dg(f(P))\\) and \\(Df(P)\\), and then use the Chain Rule.\n";
$pf = "i) Let \\(h(x,y,z) = (g \\circ f)(P) = ((a+b+c)^2 + (abc)^6, 5(a+b+c)(abc)^2)\\).  \\(Dh(P)\\) is then the following matrix.\n" . 
    ptex::center(ptex::math(ptex::printMatrix([["2(a+b+c) + 6a^5(bc)^6", "2(a+b+c) + 6b^5(ac)^6", "2(a+b+c) + 6c^5(ab)^6"],
				  ["5(abc)^2 + 10(a+b+c)a(bc)^2", "5(abc)^2 + 10(a+b+c)b(ac)^2", "5(abc)^2 + 10(a+b+c)c(ab)^2"],
				 ], "ccc"))) .
    "\n\n" . 
    "ii)" . 
    ptex::center(ptex::math("Df(P) = " . ptex::printMatrix([[1,1,1],
					       ["2a(bc)^2","2b(ac)^2","2c(ab)^2"]],"ccc"))) . 
    ptex::center(ptex::math("Dg(P) = " . ptex::printMatrix([["2a", "3b^2"],
							   ["5b", "5a"]], "cc"))) . 
    ptex::center(ptex::math("Dg(f(P)) = " . ptex::printMatrix([["2(a+b+c)", "3(abc)^4"],
							       ["5(abc)^2", "5(a+b+c)"]], "cc"))) . 
    "Using the Chain Rule yields " . ptex::inlineMath("Dh(P) =" .  ptex::dot("Dg(f(P))","Df(P)")) . ":" . 
    ptex::center(ptex::math(ptex::printMatrix([["2(a+b+c)", "3(abc)^4"],
					       ["5(abc)^2", "5(a+b+c)"]], "cc") . 
			    ptex::printMatrix([[1,1,1],
					       ["2a(bc)^2","2b(ac)^2","2c(ab)^2"]],"ccc"))) . 
    "which results in the following matrix: " . 
    ptex::center(ptex::math(ptex::printMatrix([["2(a+b+c) + 6a^5(bc)^6", "2(a+b+c) + 6b^5(ac)^6", "2(a+b+c) + 6c^5(ab)^6"],
					       ["5(abc)^2 + 10(a+b+c)a(bc)^2", "5(abc)^2 + 10(a+b+c)b(ac)^2", "5(abc)^2 + 10(a+b+c)c(ab)^2"],
					      ], "ccc")));

print "{\\bf 2.}\n" . $thm . "\\\\\n\n" . $pf . "\n\n";
#print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3";
$thm = "Let \\(A\\) be an open subset of \\($rn\\) and let \\(f: A \\rightarrow \\mathbb{R}\\) be differentiable on \\(A\\).\n" . 
    "Fix a positive integer \\(p\\) and define \\(g: A \\rightarrow \\mathbb{R}\\) by \\(g(x) = f(x)^p\\).  Prove that \\(g\\) is differentiable on \\(A\\) and express its derivative in terms of the derivative of \\(f\\).";
$pf = "Let \\(B = f(A)\\) be an open subset of \\(\\mathbb{R}\\) and let \\(h: B \\rightarrow \\mathbb{R}\\) be defined by \\(h(y) = y^p\\), for all \\(y \\in B\\)." . 
    "  From 1-variable calculus, \\(h\\) is a polynomial and thus differentiable at every \\(b = f(a)\\in B\\), with derivative \\(Dh(b)(u) = " . ptex::dot("p(b^{p-1})","u")  . "\\), for all \\(u \\in \\mathbb{R}\\).\\\\\n\n" .
    "  Now, rewriting \\(g\\) as \\(g = h \\circ f\\), by the Chain Rule \\(g\\) is differentiable at \\(a \\in A\\) and its derivative, \\(Dg(a)(u)\\), is \\[Dh(b) \\circ (Df(a)(u)).\\]\n". 
    "  Therefore, \\[Dg(a)(u) = " . ptex::dot("p({f(a)}^{p-1})", "(Df(a)(u))")  . "\\text{, for all } u \\in \\mathbb{R}^n.\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
