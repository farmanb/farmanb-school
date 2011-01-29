#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "amsart";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm","amssymb","calrsfs");

#Cover Page info.
my ($num,
    $course) = (7,
		"Math-333");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Friday, November 12, 2010",
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
my $mb = "\\bar\\mu";

my $name = "1"; 
my $thm = "Let \\(X\\) be a finite measure space and let \\(\\{f_n\\}\\) be a sequence of integrable functions on \\(X\\) that converges to a function \\(f\\) uniformly on all of \\(X\\).\n\n" . 
    "(a) Prove that \\(f\\) is integrable and \\(\\int f = \\lim \\int f_n\\)\n\n". 
    "(b) Give a counterexample to this if the measure space is \\(X = $N\\) with the counting measure by exhibiting \\(f_n\\) converging uniformly to the zero function but with \\(\\int f_n = 1\\) for all \\(n\\).\n";
my $pf = "(a) First observe that \\(f\\) is the limit of measurable functions and is thus measurable by Theorem 16.6.\n" . 
    "Since \\(\\{f_n\\}\\) converges uniformly to \\(f\\), for each \\(\\varepsilon > 0\\) there exists an \\(N \\in $N\\) such that" .
    "\\[f_N(x) - \\varepsilon < f(x) < f_N(x) + \\varepsilon\\]" .
    "holds for all \\(x \\in X\\).\n" . 
    "Since \\(X\\) is a finite measure space, it follows that \\(\\varepsilon \\chi_X\\) is integrable and thus \\(f_N(x) - \\varepsilon \\chi_X\\) is also integrable.\n". 
    "Hence the inequality above can be expressed equivalently as\n" . 
    "\\[f_N(x) - \\varepsilon\\chi_X < f(x) < f_N(x) + \\varepsilon\\chi_X,\\]" . 
    "which proves that \\(f\\) is integrable by Theorem 22.6 and moreover,\n" . 
    "\\[{\\int f_N(x) - \\varepsilon\\chi_X} < {\\int f(x)} < {\\int f_N(x) + \\varepsilon\\chi_X}.\\]" . 
    "Letting \\(\\varepsilon\\) tend to zero, it follows that \\({\\int f(x)} = \\lim {\\int f_n(x)}\\), as desired.\n\n" . 
    "b) Let \\(A_n = \\{1,2, \\ldots, n\\}\\) and take \\(f_n = " . ptex::frac(1,"n") ."\\chi_{A_n}\\).\n" . 
    "For each \\(n\\), \\[\\int f_nd\\mu = " . ptex::frac(1,"n") . "n = 1 \\quad \\text{and} \\quad \\lim_{n\\rightarrow\\infty} f_n = 0.\\]\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "Let \\(f,g \\in L^1($R)\\) and let \\(x \\in $R\\).\n" . 
    "Assume the function\n" . 
    "\\[F_x:$R \\rightarrow $R \\quad \\text{by} \\quad F_x(y) = f(x-y)g(y)\\]\n" . 
    "is integrable for almost all \\(x\\).\n" . 
    "Define the \\it{convolution} of \\(f\\) and \\(g\\) by\n" . 
    "\\[f\\star g: $R \\rightarrow $R \\quad \\text{by} \\quad (f \\star g)(x) = \\int_{-\\infty}^{\\infty}f(x-y)g(y)dy.\\]\n" . 
    "Prove the following:\n\n" . 
    "(a) \\(f \\star g \\in L^1($R)\\) and \\(" . ptex::norm("f\\star g") . "_1 \\leq " . ptex::norm("f"). "_1\\cdot" . ptex::norm("g") . "_1\\).\n\n" . 
    "(b) \\(f \\star g = g \\star f\\) a.e.";
$pf = "a) Assume the functions \\(f\\) and \\(g\\) are Borel measurable functions.\n" .
    "Consider the integral\n" . 
    "\\[\\int\\int |f(x-y)||g(y)|dxdy.\\]\n". 
    "Since \\(f,g \\in L^1($R)\\) and \\(g\\) does not depend on \\(x\\), it can be rewritten as\n" . 
    "\\[\\int\\int |f(x-y)||g(y)|dxdy = \\int |g(y)|\\int |f(x-y)|dxdy.\\]\n" . 
    "Moreover, observing that, for fixed \\(y\\), \\(f(x-y)\\) is just a translation of \\(f\\) by \\(y\\) and that standard Lebesgue measure is translation invariant, it follows that\n". 
    "\\[\\int |g(y)|\\int |f(x-y)|dxdy = \\int |f(x-y)|dx\\int |g(y)|dy.\\]\n" . 
    "Therefore by Tonelli's Theorem the integral\n" . 
    "\\[\\int\\int F_x(y)dydx = \\int\\int f(x-y)g(y)dxdy\\]\n" . 
    "exists.\n" . 
    "Now it follows from the definition of the iterated integral that\n" . 
    "\\[\\int (f \\star g)(x)dx\\]\n" .
    "exists and it follows from the integrability of \\(f\\star g\\) that it is measurable.\n" .
    "Therefore by the Corollary to 22.6, \\(|f \\star g|\\) is also integrable and thus \\(f \\star g \\in L^1($R)\\).\n" . 
    "Finally, observe that \\[" . ptex::norm("f\\star g") . "_1 = \\int |(f\\star g)(x)|dx \\leq \\int\\int|f(x-y)||g(y)|dxdy =" . ptex::norm("f"). "_1\\cdot" . ptex::norm("g") . "_1.\\]\n\n" . 
    "b) Since any two identified elements of \\(L^1($R)\\) have the same integral, it suffices to show that \\(\\int f\\star g = \\int g \\star f\\).\n" . 
    "Observe that by the result of part (a), the following holds\n" . 
    "\\[\\int (g\\star f)(x)dx = \\int g(x-y)dx \\int f(y)dy.\\]\n" .
    "Moreover, by the translation invariance of Lebesgue measure \\(\\int f(x-y)dx = \\int f(y)dy = \\int f(x)dx\\) and \\(\\int g(x-y)dx = \\int g(x)dx = \\int g(y)dy\\), so it follows that\n" . 
    "\\[\\int (f \\star g)(x)dx = \\int (g \\star f)(x)dx\\]\n". 
    "and the proof is complete.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

my $l = "\\langle";
my $r = "\\rangle";

$name = "3"; 
$thm = "Prove that in any Hilbert space \\(H\\), for all \\(\\alpha, \\beta \\in H\\)\n" . 
    "\\[".ptex::norm("\\alpha + \\beta")."^2 + " . ptex::norm("\\alpha - \\beta") . "^2 \\,=\\, 2(" . ptex::norm("\\alpha") . "^2 + " . ptex::norm("\\beta") . "^2).\\]\n" . 
    "Deduce that \\(L^1([0,1])\\) is not a Hilbert space.\n";
$pf = "Since \\(H\\) is a Hilbert space the equality above can be rewritten in terms of inner products as\n" . 
    "\\[$l\\alpha + \\beta, \\alpha + \\beta$r + $l\\alpha - \\beta, \\alpha - \\beta$r = 2($l \\alpha,\\alpha $r + $l \\beta, \\beta $r).\\]\n" . 
    "By the bilinearity of the inner product, the left hand side can be rewritten as\n" . 
    "\\[$l\\alpha,\\alpha + \\beta$r + $l\\beta, \\alpha + \\beta$r + $l\\alpha, \\alpha - \\beta$r - $l \\beta, \\alpha - \\beta$r \\]\n" . 
    "and by the transitivity of the inner product it becomes\n" . 
    "\\[$l\\alpha + \\beta, \\alpha$r + $l\\alpha + \\beta, \\beta $r + $l \\alpha - \\beta, \\alpha $r - $l \\alpha - \\beta, \\beta $r.\\]\n" . 
    "Applying bilinearity once more yields" . 
    "\\[$l\\alpha, \\alpha$r + $l \\beta, \\alpha $r + $l\\alpha, \\beta $r + $l \\beta, \\beta $r  + $l \\alpha, \\alpha $r - $l \\beta, \\alpha $r - $l \\alpha, \\beta $r + $l \\beta, \\beta $r,\\]\n" . 
    "which can be rearranged to obtain the desired equality,\n" . 
    "\\[$l\\alpha + \\beta, \\alpha + \\beta$r + $l\\alpha - \\beta, \\alpha - \\beta$r = 2($l \\alpha,\\alpha $r + $l \\beta, \\beta $r).\\]\n" . 
    "Consider the two functions \\(x\\) and \\(1-x\\).\n" . 
    "\\[\\left(\\int_0^1 dx\\right)^2 + \\left(\\int_0^{" . ptex::frac(1,2) . "} dx - 2\\int_0^{" . ptex::frac(1,2) . "}xdx + 2\\int_{" . ptex::frac(1,2) . "}^1 xdx - \\int_{" . ptex::frac(1,2) . "}^1 dx\\right)^2 = " . ptex::frac(5,4) . "\\]\n" . 
    "and\n" . 
    "\\[2\\left[\\left(\\int_0^1xdx\\right)^2 + \\left(\\int_0^1dx - \\int_0^1 xdx\\right)^2\\right] = " . ptex::frac(25,8) .".\\]\n" . 
    "Therefore the equality above does not hold and thus \\(L^1([0,1])\\) is not a Hilbert space.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "Prove that the \\(L^1\\)-norm and the \\(L^2\\)-norm are not equivalent on the space \\(L^1($R) \\cap L^2($R)\\).\n";
$pf = "Let \\(A_n = (". ptex::frac(1,"n+1"). "," . ptex::frac(1,"n") ."]\\) and consider the sequence of functions \\(\\{f_n\\}_{n=1}^{\\infty} \\subseteq L^1($R) \\cap L^2($R)\\) defined by \\(f_n = \\sqrt{n}\\chi_{A_n}\\).\n" . 
    "Now take the limit of the ratio of the norms,\n" . 
    "\\[\\lim_{n \\rightarrow \\infty}" . ptex::frac(ptex::norm("f_n") . "_1", ptex::norm("f_n"). "_2")." = \\lim_{n\\rightarrow \\infty}" . ptex::frac("\\sqrt{n}","n(n+1)") . ptex::frac("\\sqrt{n(n+1)}","\\sqrt{n}") . " = 0.\\]\n" . 
    "Hence, the norms of this function cannot possibly differ only by a constant.\n" . 
    "Therefore the \\(L^1\\)-norm and the \\(L^2\\)-norm are not equivalent on the space \\(L^1($R) \\cap L^2($R)\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "Prove that if \\(f \\in L^p(X) \\cap L^q(X)\\) for some \\(p \\leq q\\), then \\(f \\in L^r(X)\\) for every \\(r\\) with \\(p \\leq r \\leq q\\).\n";
$pf = "Since \\(f \\in L^p(X) \\cap L^q(X)\\), it follows that \\(|f|^p, |f|^q \\in L^1(X)\\) and \\(f\\) is a measurable function and from the previous homework exercises, \\(|f|^p\\), \\(|f|^q\\) and \\(|f|^r\\) are also measurable functions.\n" .
    "Moreover, \\(L^1(X)\\) is a Banach lattice, so it follows that \\(|f|^p \\wedge |f|^q, |f|^p \\vee |f|^q \\in L^1(X)\\) and \\(|f|^p \\wedge |f|^q \\leq |f|^r \\leq |f|^p \\vee |f|^q\\).\n". 
    "Therefore  \\(|f|^r\\) is integrable by Theorem 22.6 and thus \\(f \\in L^r(X)\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6"; 
$thm = "Prove or disprove: \\(L^1([0,1]) = \\bigcup_{p > 1}L^p([0,1])\\).\n";
$pf = "Consider the function\n" . 
    "\\[f(x) = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "x\\log^2(x) & \\text{if } x \\in (0,1],\\\\ \n" .
    "0 & \\text{if } x = 0.\n" .
    "\\end{array}\n" .
    "\\right.\\]\n" .
    "Then observe that by two applications of L'H\\^opital's Rule\n" . 
    "\\[\\lim_{x\\rightarrow 0}x\\log^2(x) = \\lim_{x \\rightarrow 0} " . ptex::frac("\\log^2(x)",ptex::frac(1,"x")) ." = 0,\\]\n" .
    "so it follows that the function is continuous on \\([0,1]\\).\n" .
    #"Now defining \\(" . ptex::frac(1,"f(x)") . "\\) to be \\(0\\) at the endpoints the function \\(" . ptex::frac(1,"f(x)") . "\\) is continuous, except possibly at the endpoints, where \\(f(x) = 0\\) and thus continuous almost everywhere, hence measurable.\n" .
    "Moreover, letting \\(A = (0," . ptex::frac(1,2) . ")\\) it follows that \\(". ptex::frac(1,"f(x)")."\\chi_A\\) is integrable and, making the substitution \\(u = \\log(x)\\), its integral is given by" .
    #"Let \\(A = (0," . ptex::frac(1,2) . ")\\) and consider the function\n" . 
    #"\\[g(x) = f(x)\\chi_A.\\]\n" .
    #"First observe that after making the substitution \\(u = \\log(x)\\), " .
    "\\[\\int_{0}^{". ptex::frac(1,2) ."}" . ptex::frac("dx", "x\\log^2(x)")." = -\\int_{-\\log(2)}^{-\\infty}" . ptex::frac("du", "u^2") . " = " . ptex::frac(1,"\\log(2)"). ",\\]\n" .
    "and thus \\(f \\in L^1([0,1])\\).\n" .
    "Now, by the continuity of \\(f\\), there exists a \\(\\delta > 0\\) such that \\(f(x) < 1\\) whenever \\(0 \\leq x \\in V_{\\delta}(0)\\) and thus\n" .
    "\\[0 \\leq x^{p-1}\\log^{2p}(x) \\leq x\\log^2(x)\\]\n" .
    "implies that \\(x^{p-1}\\log^{2p}(x)\\) tends to zero as \\(x\\) tends to zero.\n" .
    "Then it follows that " .
    "\\[h(x) = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "x^{p-1}\\log^{2p}(x) & \\text{if } x \\in (0," . ptex::frac(1,2) . "],\\\\ \n" .
    "0 & \\text{if } x = 0.\n" .
    "\\end{array}\n" .
    "\\right.\\]\n" . 
    "is continuous on the interval \\([0," . ptex::frac(1,2) . "]\\).\n" . 
    "Since \\(g\\) is continuous on a compact interval, it follows that there exists an \\(M \\in $R\\) such that \\[x^{p-1}\\log^{2p}(x) \\leq M.\\]" . 
    "Hence\n" . 
    "\\[" . ptex::frac(1,"M") . " \\leq " . ptex::frac(1,"x^{p-1}\\log^{2p}(x)") . "\\]\n" . 
    "implies,\n" . 
    "\\[" . ptex::frac(1,"xM") . " \\leq " . ptex::frac(1,"xx^{p-1}\\log^{2p}(x)") . ".\\]\n" . 
    "Thus \\(". ptex::frac(1,"f(x)^p")."\\chi_A\\) is not integrable by comparison and thus is not in \\(L^p([0,1])\\), for any \\(p > 1\\).\n" . 
    "Therefore, \\(L^1([0,1]) \\not = \\bigcup_{p>1} L^p([0,1])\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
