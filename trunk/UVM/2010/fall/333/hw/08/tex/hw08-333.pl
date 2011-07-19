#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "amsart";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","amssymb");

#Cover Page info.
my ($num,
    $course) = (8,
		"Math-333");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Monday, November 29, 2010",
	       "$course: Homework $num\\\\\n");

my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => $date,
    "isCP" => 0,
    "other" => "\\openup 5pt" 
};


print ptex::preamble($p);

my ($R,$N,$Z) = ("\\mathbb{R}","\\mathbb{N}", "\\mathbb{Z}");
my ($beq,$eeq) = ("\\begin{eqnarray*}\n", "\\end{eqnarray*}\n");
my $l = "\\langle";
my $r = "\\rangle";

my $name = "1"; 
my $thm = "For each \\(n \\in $N\\), let \\(e_n = \\chi_{\\{n\\}}\\).\n" . 
    "Show that the family of functions \\(\\{e_n\\}_{n \\in $N}\\) is an orthonormal basis for the Hilberspace \\(\\ell^2($N)\\).\n";
my $pf = "Observe first that for any \\(n \\in $N\\) the function \\(\\chi_{\\{n\\}} \\in \\ell^2($N)\\) is the sequence \\(a_n = 1\\) and \\(a_k = 0\\) for each \\(k \\not = n\\).\n" . 
    "Then for any two integers \\(m \\not = n\\) write\n" . 
    "\\[e_m = a_1,a_2,\\ldots \\quad \\text{and} \\quad e_n = b_1,b_2,\\ldots\\]\n" . 
    "The inner product is then\n" . 
    "\\[$l e_m,e_n $r = \\sum_{k=1}^{\\infty} a_k \\cdot b_k = 0\\cdot0 + \\ldots + a_m \\cdot 0 + \\ldots 0 \\cdot b_n + \\ldots = 0.\\]\n" . 
    "Hence the \\(e_n\\) are pairwise orthogonal.\n". 
    "Moreover, for each \\(n \\in $N\\)\n" . 
    "\\[".ptex::norm("e_n")."_2 = \\left(\\int |\\chi_{\\{n\\}}|^2 d \\mu \\right)^{".ptex::frac(1,2)."} = 1.\\]\n" . 
    "Therefore \\(\\{e_n\\}_{n \\in $N}\\) forms an orthonormal basis of \\(\\ell^2($N)\\).";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "Let \\(\\{e_i\\}_{i \\in I}\\) be an orthonormal basis in a Hilbert space and let \\(x\\) be a unit vector, i.e, \\(". ptex::norm("x") . " = 1\\).\n" . 
    "Show that for each \\(k \\in $N\\) the set \\(\\{i \\in I \\mid \\left| $l x, e_i $r \\right| \\geq " . ptex::frac(1,'k') . "\\}\\) has at most \\(k^2\\) elements.\n";
$pf = "By Parseval's Identity and the hypotheses\n". 
    "\\[" . ptex::norm('x') . "^2 = \\sum_{i \\in I} \\left| $l x, e_i $r \\right|^2 = 1.\\]\n" . 
    "Let \\(J = \\{i \\in I \\mid \\left| $l x, e_i $r \\right| \\geq " . ptex::frac(1,'k') . "\\}\\) and suppose to the contrary that \\(|J| > k^2\\).\n" . 
    "Then \n" . 
    "\\[" . ptex::norm('x') . "^2 \\geq \\sum_{j \\in J} " .ptex::frac(1,'k^2') . "> k^2\\cdot " . ptex::frac(1,'k^2') . " = 1.\\]" . 
    "However, this contradicts the assumption that \\(x\\) is a unit vector.\n" . 
    "Therefore, it must be the case that \\(|J| \\leq k^2\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "Let \\(\\{\\varphi_n\\}\\) be an orthonormal sequence of vectors in the Hilbert space \\(L^2([0,2\\pi])\\).\n" . 
    "Suppose that for each continuous function \\(f\\) in \\(L^2([0,2\\pi])\\) we have\n" . 
    "\\[".ptex::norm('f')."^2 = \\sum_{n=1}^{\\infty}\\left| $l f, \\varphi_n $r \\right|^2.\\]\n" . 
    "Show that \\(\\{\\varphi_n\\}\\) is an orthonormal basis.\n";
$pf = "Let \\(V = \\overline{\\text{Span}\\{\\varphi_n\\}}\\) and observe that\n" . 
    "\\[L^2([0,2\\pi]) = V \\oplus V^{\\perp}\\]\n" .
    "holds by Theorem 33.7.\n" .
    "Let \\(f\\) be an element of \\(V^{\\perp} \\subseteq L^2([0,2\\pi])\\), which, by Theorem 33.11, has a sequence of continuous functions of compact support, \\(\\{f_n\\} \\subseteq L^2([0,2\\pi])\\), that converges to \\(f\\) in the \\(L^2\\)-norm.\n" . 
    "Moreover, since \\(V\\) is closed and \\(f \\not \\in V\\), there exists an \\(n_0 \\in $N\\) such that \\(f_n \\in V^{\\perp}\\) and, consequently," .
    "\\[". ptex::norm('f_n') ."^2 = \\sum_{n=1}^{\\infty} \\left| $l f_n, \\varphi_n $r \\right|^2 = 0\\]" .
    "hold whenever \\(n \\geq n_0\\).\n" . 
    "From the above equality it follows that \\(f_n = 0\\) for each \\(n \\geq n_0\\).\n\n" . 
    
    "Let \\(\\varepsilon > 0\\) be given and take \\(n_1 \\in $N\\) such that\n" . 
    "\\[". ptex::norm('f') ."_2 \\,<\\, ". ptex::norm('f_n')."_2 +\\, \\varepsilon\\]" . 
    "holds whenever \\(n \\geq n_1\\).\n" . 
    "Let \\(N = \\max{\\{n_0,n_1\\}}\\) and observe that\n" . 
    "\\[". ptex::norm('f') ."_2 \\,<\\, ". ptex::norm('f_n')."_2 +\\, \\varepsilon = \\varepsilon\\]\n". 
    "holds whenever \\(n \\geq N\\).\n" . 
    "Since this inequality holds for all \\(\\varepsilon\\), it follows that \\(f = 0\\).\n" .
    "Therefore \\(L^2([0,2\\pi]) = V\\) implies that \\(\\{\\varphi_n\\}\\) is an orthonormal basis, as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "Prove that \\[\\sum_{n=1}^{\\infty} " . ptex::frac(1,"n^4") . " = " . ptex::frac("\\pi^4",90) . ".\\]\n";
$pf = "The Fourier coefficients for the function \\(x^2\\) are given by\n". 
    "\\[a_n = " . ptex::frac(1,'\\pi') . "\\int_{-\\pi}^{\\pi}x^2\\cos(nx)dx = " . ptex::frac("(-1)^n4","n^2") . ",\\]\n" . 
    "\\[a_0 = " . ptex::frac(1,'\\pi') . "\\int_{-\\pi}^{\\pi} x^dx = " . ptex::frac(2,3) . " \\pi^2 \\quad \\text{and}\\]\n" . 
    "\\[b_n = ". ptex::frac(1,'\\pi') ." \\int_{-\\pi}^{\\pi}x^2\\sin(nx)dx = 0.\\]\n" . 
    "Then by Parseval's Identity\n" . 
    "\\[" . ptex::frac(1,"\\pi") . ptex::norm("x^2") . "_2^2 = " . ptex::frac(2,5) . "\\pi^4 = " . ptex::frac('2\\pi^4',9) . " + 16\\sum_{n=1}^{\\infty}" . ptex::frac(1,'n^4') . ",\\]\n" . 
    "which rearranges with some simple algebra to\n". 
    "\\[\\sum_{n=1}^{\\infty}" . ptex::frac(1,'n^4') . " = " . ptex::frac('\\pi^4', 90) . ",\\]\n" . 
    "as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "If \\(f \\in L^2([0,1])\\) has the usual trigonometric Fourier coefficients \\(a_n\\) and \\(b_n\\), \\(n \\geq 0\\), prove that \\(\\sum" . ptex::frac('a_n','n') . "\\) and \\(\\sum" . ptex::frac('b_n','n') . "\\) converge absolutely.\n";
$pf = "By Parseval's Identity and using the complex orthonormal basis of \\(L^2([0,1])\\), \\(\\{e^{inx} \\mid n = 0, \\pm 1, \\pm 2, \\ldots\\}\\) it follows that\n" . 
    "\\[" . ptex::norm('f') . "_2^2 = \\sum_{n = - \\infty}^{\\infty} \\left| $l f, e^{inx} $r \\right|^2 = \\sum_{n=-\\infty}^{\\infty}|c_n|^2.\\]\n" . 
    "From the coefficient identities \\(c_0 = " . ptex::frac(1,2) . "a_0, c_n = " . ptex::frac(1,2) . "(a_n - ib_n), c_{-n} = " . ptex::frac(1,2) . "(a_n + ib_n)\\) the sum above, which can be rearranged since it converges absolutely, can be rewritten with a some simple algebra as\n" . 
    "\\[" . ptex::norm('f') . "_2^2 = \\sum_{n=1}^{\\infty}|c_n|^2 + \\sum_{n=1}^{\\infty}|c_{-n}|^2 + |c_0|^2 = " . ptex::frac(1,2) . "\\sum_{n=1}^{\\infty}|a_n|^2 + " . ptex::frac(1,2) . "\\sum_{n=1}^{\\infty}|b_n|^2 + " . ptex::frac(1,4) . "|a_0|^2 < \\infty\\]\n" .
    "Then by the Cauchy-Schwarz Inequality\n" . 
    "\\[\\sum_{n=1}^{\\infty} \\left|" . ptex::frac('a_n', 'n') ."\\right| \\leq \\left(\\sum_{n=1}^{\\infty} |a_n|^2\\right)^{" . ptex::frac(1,2) ."}\\left(\\sum_{n=1}^{\\infty} \\left|" . ptex::frac(1,'n') ."\\right|^2\\right)^{" . ptex::frac(1,2) ."}\\]\n" .
    "\\[\\sum_{n=1}^{\\infty} \\left|" . ptex::frac('b_n', 'n') ."\\right| \\leq \\left(\\sum_{n=1}^{\\infty} |b_n|^2\\right)^{" . ptex::frac(1,2) ."}\\left(\\sum_{n=1}^{\\infty} \\left|" . ptex::frac(1,'n') ."\\right|^2\\right)^{" . ptex::frac(1,2) ."}.\\]\n" . 
    "Since \\(" . ptex::frac(1,'n^2') ."\\) converges by Calculus, it follows that both \\(\\sum" . ptex::frac('a_n','n') . "\\) and \\(\\sum" . ptex::frac('b_n','n') . "\\) converge absolutely, as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#$name = "6"; 
#$thm = "Prove the following special case of the Riesz Representation Theorem:\n\n". 
#    "If \\(\\phi \\in L^2([0,1])^*\\), then there exists \\(f \\in L^2([0,1])\\) such that\n" . 
#    "\\[\\phi(g) = $l g, f $r, \\text{ for all } g \\in L^2([0,1]).\\]";
#$pf = " Let \\(\\{e_n\\}_{n \\in $N}\\) be an orthonormal basis for \\(L^2([0,1])\\).\n" . 
#    "Then for any \\(f \\in L^2([0,1])\\) \\[f = \\sum_{n \\in $N} $l f, e_n $r e_n.\\]\n" . 
#    "Then write" . 
#    "\\[\\phi(f) = \\phi(\\lim_{n \\rightarrow \\infty} \\sum_{k=1}^n $l f, e_n $r e_n).\\]\n". 
#    "Since \\(\\phi\\) is continuous, it follows that\n" . 
#    $beq .
#    ptex::printEqnArray([["\\phi(f)", "\\lim_{n \\rightarrow \\infty} \\phi(\\sum_{k=1}^n $l f, e_n $r e_n)"],
#			 ["", "\\lim_{n \\rightarrow \\infty} \\sum_{k=1}^n $l f, e_n $r \\phi(e_n)"]], "=") . 
#    $eeq . 
    #["", "\\lim_{n \\rightarrow \\infty} \\sum_{k=1}^n $l f, \\phi(e_n)e_n $r"],
    #["", "$l f, \\lim_{n \\rightarrow \\infty} \\sum_{k=1}^n \\phi(e_n)e_n $r"]], "=") . 
#    "\\[\\]\n";

#print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
