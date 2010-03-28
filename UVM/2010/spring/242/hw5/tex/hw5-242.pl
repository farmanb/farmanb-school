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
    $course) = (5, 
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
my $thm = "Let \\(\\{a_n\\}_{n=1}^{\\infty}\\) and \\(\\{b_n\\}_{n=1}^{\\infty}\\) be bounded sequences of real numbes.\n" . 
    "  Let \\(c_n = a_n + b_n\\) for all \\(n\\).\n\n" . 
    "  (a) Prove that \\(\\limsup c_n \\leq \\limsup a_n + \\limsup b_n\\).\n\n" . 
    "  (b) Give an explicit example of two sequences where you do \\emph{not} get equality in part (a).\n\n". 
    "  (c)  Prove that if \\(\\{a_n\\}_{n=1}^{\\infty}\\) converges, then you always get \\emph{equality} in part (a).\n";
my $pf = "Let \\(A_n = \\{a_n, a_{n+1}, \\ldots\\}\\), \\(B_n = \\{b_n, b_{n+1}, \\ldots\\}\\) and \\(C_n = \\{c_n, c_{n+1}, \\ldots\\}\\).\n" . 
    "  Let \\(x_n = \\sup A_n\\), \\(y_n = \\sup B_n\\) and \\(z_n = \\sup C_n\\) so that \\(\\limsup a_n = \\lim_{n \\rightarrow \\infty} x_n\\), \\(\\limsup b_n = \\lim_{n \\rightarrow \\infty} y_n\\) and \\(\\limsup c_n = \\lim_{n \\rightarrow \\infty} z_n\\).\n\n" . 
    "  (a)  Then for \\(n \\geq N\\), \\(a_n \\leq x_N\\) and \\(b_n \\leq y_N\\), so \\(c_n = a_n + b_n \\leq x_N + y_N\\) implies that \\(z_N \\leq x_N + y_N\\).\n". 
    "  Hence, by the order limit theorem, \\(\\lim_{n \\rightarrow \\infty} z_n \\leq \\lim_{n \\rightarrow \\infty} x_n + \\lim_{n \\rightarrow \\infty} y_n\\).\\\\\n\n" . 
    "  (b) Let \\(a_{2n} = 1, a_{2n+1} = -1, b_{2n} = -1, b_{2n+1} = " . ptex::frac(1,2) . "\\).\n".
    "  Then \\(c_{2n} = 0, c_{2n+1} = " . ptex::frac("-1",2) ."\\) and \\(\\limsup c_n = 0 < \\limsup a_n + \\limsup b_n = " .  ptex::frac(3,2). ".\\)\\\\\n\n" . 
    "  (c) Let \\(a = \\lim_{n \\rightarrow \\infty} a_n\\) and let \\(b = \\limsup b_n\\).  Let \\(\\{b_{n_k}\\} \\subseteq \\{b_n\\}\\) be such that \\(\\lim_{n \\rightarrow \\infty} b_n  = b\\).\n" . 
    "  Let \\(C_{n_k} = \\{a_{n_k} + b_{n_k}, a_{n_{k+1}} + b_{n_{k+1}}, \\ldots\\} \\subseteq C_n\\) and let \\(z_{n_k} = \\sup C_{n_k}\\).\n" . 
    "  Since \\(C_{n_k} \\subseteq C_n\\), \\(z_{n_k} \\leq z_n\\) for all \\(n\\), which implies that \\(\\lim_{n \\rightarrow \\infty} z_{n_k} \\leq \\lim_{n \\rightarrow \\infty} z_n\\).\n" . 
    "  Since \\(\\lim_{n \\rightarrow \\infty} a_n = a\\), any subsequence of \\(\\{a_n\\}\\) converges to the same limit." .
    "  Hence, \\[\\lim_{n \\rightarrow \\infty} c_{n_k} = \\lim_{n \\rightarrow \\infty} (a_{n_k} + b_{n_k}) = \\lim_{n \\rightarrow \\infty} a_{n_k} + \\lim_{n \\rightarrow \\infty} b_{n_k} = a + b.\\]" . 
    "  Then since \\(\\{c_{n_k}\\}\\) converges, \\[\\lim_{n \\rightarrow \\infty} z_{n_k} = a + b.\\]\n" . 
    "  Therefore, combining this lower bound with the result from part (a) yields \\[a+b \\leq \\lim_{n \\rightarrow \\infty} z_n \\leq a+b.\\] which implies that \\(\\limsup c_n = \\limsup a_n + \\limsup b_n\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2\n";
$thm = "Let \\(\\{a_n\\}_{n=1}^{\\infty}\\) be a bounded sequence of real numbers.  Prove that the real number \\(L\\) equals \\(\\limsup a_n\\) if and only if \\(L\\) has both of the following properties:\n\n" . 
    "(i) For every \\(\\varepsilon > 0\\) there are only finitely many terms \\(a_n\\) in the sequence with \\(a_n > L + \\varepsilon,\\) and\n\n" . 
    "(ii) For every \\(\\varepsilon > 0\\) there are infinitely many terms \\(a_m\\) in the sequence with \\(a_m > L - \\varepsilon\\).\n";
$pf = "Let \\(A_n = \\{a_n, a_{n+1}, \\ldots\\}\\) and let \\(x_n = \\sup A_n\\).\n" . 
    "  Then \\[L = \\lim_{n \\rightarrow \\infty} x_n = \\limsup a_n.\\]\n" . 
    "  Let \\(\\varepsilon > 0\\) be given.  There exists some \\(N \\in \\mathbb{N}\\) such that \\(x_n \\in B_{\\varepsilon}(L)\\) whenever \\(n \\geq N\\).\n" . 
    "  Then since \\(x_n\\) is necessarily decreasing, only a finite number of terms, \\(a_1, \\ldots, a_{N-1}\\), are larger than \\(L + \\varepsilon\\)." . 
    "  Now, take \\(N_2 > " . ptex::frac(1,"\\varepsilon") . "\\).\n". 
    "  Since \\(x_n\\) is a limit point of \\(A_n\\) for every \\(n\\), \\(B_{" . ptex::frac(1,"n") . "}(x_N) \\cap A_N \\not = \\phi\\) and \\(B_{" . ptex::frac(1,"n") . "}(x_N) \\subseteq B_{\\varepsilon}(L)\\), whenever \\(n \\geq N_2\\)." . 
    "  So for each \\(n \\geq N_2\\), select some element of \\(B_{" . ptex::frac(1,"n") . "}(x_N)\\), forming a sequence of terms, each larger than \\(L - \\varepsilon\\) and infinite in number.\n\n" . 
    "  Conversely, assume properties (i) and (ii) hold for \\(L\\).\n" . 
    "  Let \\(\\varepsilon > 0\\) be given.\n" .
    #"  Property (i) implies that there exists some \\(N_1 \\in \\mathbb{N}\\) such that \\(a_n < L + \\varepsilon\\) whenever \\(n \\geq N_1\\).\n" . 
    "  Property (ii) combined with the Bolzano-Weierstrass theorem implies that there exists some \\(\\{a_{n_k}\\} \\subseteq \\{a_n\\}_{n=1}^{\\infty}\\) such that \\(\\lim_{n_k \\rightarrow \\infty} a_{n_k}= L\\).\n" . 
    "  Hence \\(L\\) is a limit point of \\(\\{a_n\\}_{n=1}^{\\infty}\\).\n\n".
    "  Using that \\(\\limsup a_n = \\sup \\{x \\mid x \\text{ a limit point of }\\{a_{n_k}\\}\\subseteq\\{a_n\\}\\}\\), assume there exists a limit point of some subsequence, \\(L_2 > L\\).\n" . 
    "  Then \\(B_{|L_2 - (L+\\varepsilon)|}(L_2)\\) contains an infinite number of points of \\(\\{a_n\\}\\).\n" . 
    "  However, this contradicts property (i) and so it must be that there is no limit point larger than \\(L\\).\n" . 
    "  Therefore, \\(L = \\limsup a_n\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3\n";
$thm = "Prove that \\[\\limsup \\sin(n)  \\not = \\liminf \\sin(n)\\] so that the sequence \\(\\{\\sin(n)\\}_{n=1}^{\\infty}\\) does not converge.\n";
$pf = "Let \\(S_n = \\{sin(n), sin(n+1), \\ldots\\}\\).\n" . 
    "  Let \\(s_n = \\sup S_n\\) and let \\(i_n = \\inf S_n\\).\n". 
    "  First note that \\(\\sin(\\theta) > 0\\) when \\(\\theta \\in (2n\\pi, 2n\\pi + \\pi)\\) and that \\(\\sin(\\theta) < 0\\) when \\(\\theta \\in (2n\\pi + \\pi, 2n\\pi + 2\\pi)\\), for all \\(n \\in \\mathbb{N}\\).\n\n" . 
    #"  Also note that for any \\(n \\in \\mathbb{N}\\), \\(2n\\pi \\geq n\\).\n\n" . 
    "  Let \\(n \\in \\mathbb{N}\\) be given.  Notice then that \\[n \\leq 2n\\pi \\leq \\lceil 2n\\pi\\rceil < 2n\\pi + 1 < 2n\\pi + \\pi.\\]\n" . 
    "  So it follows that for any \\(n \\in \\mathbb{N}\\), there exists an integer, \\(\\lceil 2n\\pi \\rceil > n\\) such that \\(\\sin(\\lceil 2n\\pi \\rceil) > 0\\).\n" . 
    "  Hence, \\(s_n > 0\\).\n" . 
    "  Similarly, there exists an integer \\(\\lceil 2n\\pi+\\pi \\rceil \\in (2n\\pi + \\pi, 2n\\pi + 2\\pi)\\) such that \\(\\sin(\\lceil 2n\\pi+\\pi \\rceil) < 0\\), which implies that \\(i_n < 0\\).\n" . 
    "  Hence by the order limit theorem, \\[\\limsup \\sin(n) = \\lim_{n \\rightarrow \\infty} i_n < 0 < \\lim_{n \\rightarrow \\infty} s_n = \\limsup \\sin(n).\\]\n" . 
    "  Therefore, the sequence \\(\\{\\sin(n)\\}_{n=1}^{\\infty}\\) does not converge.";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
