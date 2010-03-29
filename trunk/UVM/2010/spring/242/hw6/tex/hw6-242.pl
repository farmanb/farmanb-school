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
    $course) = (6, 
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

my $name = "1\n";
my $thm = "";
my $pf = "(a) By definition of \\(D\\), every point of \\(P_n\\), except for 0 and 1, has been removed from \\(D\\).\n" . 
    "  Hence, for every subset of \\(P, [x_i, x_{i+1}]\\), at least one of \\(x_i\\) and \\(x_{i+1}\\) is not an element of \\(D\\) and thus\n" . 
    "  \\[\\inf \\{f(x) \\mid x \\in [x_i, x_{i+1}]\\} = 0, \\text{ for every } [x_i, x_{i+1}] \\subseteq P_n.\\]" . 
    "  Therefore, \\[L(f,P_n) = 0, \\text {for all } n.\\]\n\n" . 
    "  (b)  Let \\(M_i = \\sup \\{f(x) \\mid x \\in [x_i, x_{i+1}]\\}\\).\n" .
    "  For every \\(P_n\\), there are \\(2^n\\) intervals of length " . ptex::inlineMath(ptex::frac(1,"3^n")) . " which contain points of \\(D\\).\n" . 
    "  Therefore, \\[U(f,P_n) = \\sum_{i=1}^{2^n} M_i\\left(".ptex::frac(1,3)."\\right)^n = \\left(" . ptex::frac(2,3) ."\\right)^n.\\]" . 
    "  (c)  Let \\(\\varepsilon > 0\\) be given.  Since \\(\\left(".ptex::frac(2,3)."\\right)^n \\rightarrow 0 \\text{ as } n \\rightarrow \\infty\\), there exists an \\(N \\in \\mathbb{N}\\) such that \\[U(f,P_n) - L(f,P_n) = U(f,P_n) < \\varepsilon.\\]\n" .
    "  Therefore, by Riemann's condition \\(f\\) is Riemann integral and, since \\(U(f,P_n)\\) is monotone decreasing, \\[\\int_a^b f = \\inf_p \\{U(f,P_n)\\} = \\lim_{n \\rightarrow \\infty} \\left(".ptex::frac(2,3)."\\right)^n = 0.\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $eps = "\\varepsilon";

$name = "2\n";
$thm = "Let \\(f\\) and \\(g\\) be (bounded) Riemann integrable functions on \\([a,b]\\).\n\n" . 
    "  (a) Prove that if \\(f(x) < g(x)\\) for all \\(x \\in [a,b]\\), then \\(\\int_a^b f \\leq \\int_a^b g\\).\n\n" . 
    "  (b) Use Riemann's Condition to prove \\(f + g\\) is also Riemann integrable and \\[\\int_a^b (f+g) = \\int_a^b f + \\int_a^b g.\\]\n";
$pf = "(a) Since \\(f(x) < g(x)\\) for all \\(x \\in [a,b]\\), it follows that for any choice of a partition \\(P\\) of \\([a,b]\\), \\(U(f,P) \\leq U(g,P)\\).\n" . 
    "  Since both \\(f\\) and \\(g\\) are Riemann integrable functions on \\([a,b]\\), it must be that \\[\\inf_P \\{U(f,P)\\} = \\int_a^b f \\leq \\int_a^b g = \\inf_P \\{U(g,P)\\}.\\]\n\n" . 
    "  (b) Let \\(\\varepsilon > 0\\) be given.  By Riemann's condition there exist partitions \\(P_1\\) and \\(P_2\\) of \\([a,b]\\) corresponding to \\(f\\) and \\(g\\) respectively such that on the common refinement \\(P_{\\varepsilon} = P_1 \\cup P_2\\) " .
    "  \\[U(f,P_{\\varepsilon}) - L(f,P_{\\varepsilon}) <" . ptex::frac("\\varepsilon",2) . " \\text{\\quad and\\quad} U(g,P_{\\varepsilon}) - L(g,P_{\\varepsilon}) < " .ptex::frac("\\varepsilon",2) . ".\\]\n" . 
    "  Since \\(\\sup f+g = \\sup f + \\sup g\\) and \\(\\inf f+g = \\inf f + \\inf g\\), it follows that " . 
    "  \\[U(f+g,P_{\\varepsilon}) - L(f+g,P_{\\varepsilon}) < \\varepsilon.\\]\n" . 
    "  Therefore, by Riemann's condition, \\(f + g\\) is Riemann integrable.\n\n" . 
    "  Continuing to use the same partition \\(P_{\\varepsilon}\\), " . 
    "$beq\n". 
    ptex::printEqnArray([["\\int_a^b (f+g)","U(f+g,P_{\\varepsilon})"]],"\\leq") . 
    ptex::printEqnArray([["", "L(f+g, P_{\\varepsilon}) + \\varepsilon"]],"<") .
    ptex::printEqnArray([["", "L(f,P_{\\varepsilon}) + L(g,P_{\\varepsilon}) + \\varepsilon"]], "=") .
    ptex::printEqnArray([["", "\\int_a^b f + \\int_a^b g + $eps."]], "\\leq") . 
    "$eeq\n" .
    "  Which implies that \\(\\int_a^b (f+g) \\leq \\int_a^b f + \\int_a^b g\\).\n" .
    "$beq\n" . 
    ptex::printEqnArray([["\\int_a^b f + \\int_a^b g", "U(f,P_{\\varepsilon}) + U(g,P_{\\varepsilon})"]],"\\leq") . 
    ptex::printEqnArray([["", "L(f,P_{\\varepsilon}) + L(g,P_{\\varepsilon}) + \\varepsilon"]],"<") .
    ptex::printEqnArray([["", "L(f+g, P_{\\varepsilon})  + \\varepsilon"]], "=") .
    ptex::printEqnArray([["", "\\int_a^b (f+g) + $eps."]], "\\leq") . 
    "$eeq\n" . 
    "  Which implies that \\(\\int_a^b f + \\int_a^b g \\leq \\int_a^b (f+g)\\).  Therefore, \\[\\int_a^b (f+g) = \\int_a^b f + \\int_a^b g.\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3\n";
$thm = "Let \\(f:[a,b] \\rightarrow \\mathbb{R}\\) be continuous and assume \\(f \\geq 0\\) on \\([a,b]\\), where \\(a<b\\).  Let \\(M\\) be the maximum value of \\(f\\) on \\([a,b]\\).  Prove that \\[\\lim_{n \\rightarrow \\infty} \\left(\\int_a^b f^n\\right)^{".ptex::frac(1,"n")."} = M.\\]\n";
$pf = "Let \\(g_n(x) = x^n\\) and let \\(h = g \\circ f = f^n\\).  Since both \\(f\\) and \\(g\\) are continuous on \\([a,b]\\), then so is \\(h\\) and thus \\(\\int_a^b h = \\int_a^b f^n\\) exists for each \\(n \\in \\mathbb{N}\\setminus\\{0\\}\\).\n\n" . 
    "  Noting that \\(f \\geq 0\\) for all \\(x \\in [a,b]\\), it follows that for \\([c,d] \\subseteq [a,b]\\), \\(\\int_c^d f \\leq \\int_a^b f\\).\n" . 
    "  Then let \\(\\varepsilon > 0\\) be given and let \\(c \\in [a,b]\\) be such that \\(f(c) = M\\).\n" .
    "  Since \\(f\\) is uniformly continuous, there exists some \\(\\delta > 0\\) such that for each \\(x \\in [c - \\delta, c+\\delta] \\cup [a,b]\\), \\(|f(x) - M| < \\varepsilon\\).\n" . 
    "  Hence, \\(\\sup \\{f(x) \\mid x \\in [c-\\delta, c+\\delta] \\cup [a,b]\\} \\geq M - $eps\\).\n" . 
    "  Then, \\[(M-$eps)(\\text{len}([c-\\delta, c+\\delta]\\cap [a,b])^{". ptex::frac(1,"n")."} \\leq \\int_{\\max\\{a,c-\\delta\\}}^{\\min\\{b,c+\\delta\\}} f^n \\leq \\int_a^b f^n \\leq M(b-a)^{".ptex::frac(1,"n")."}.\\]" . 
    "  So, we have that for arbitrary \\($eps\\), \\(M-$eps \\leq \\lim_{n \\rightarrow \\infty} \\left(\\int_a^b f^n\\right)^{".ptex::frac(1,"n")."} \\leq M\\)." . 
    "  Therefore, \\[\\lim_{n \\rightarrow \\infty} \\left(\\int_a^b f^n\\right)^{".ptex::frac(1,"n")."} = M.\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
