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
    $course) = (5,
		"Math-333");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Monday, October 11, 2010",
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

my ($beq,$eeq) = ("\\begin{eqnarray*}\n", "\\end{eqnarray*}\n");
my $mb = "\\bar\\mu";

my $name = "1"; 
my $thm = "Let \\(f: \\mathbb{R} \\rightarrow \\mathbb{R}\\) be a differentiable function.  Show that \\(f'\\) is Lebesgue measurable.\n";
my $pf = "Since \\(f\\) is differentiable, for every real sequence \\(\\{a_n\\}_{n=1}^{\\infty}\\) converging to \\(a\\), the sequence \\(\\{".ptex::frac("f(a_n) - f(a).","a_n - a") ."\\}\\) converges to \\(f'(a)\\).\n" . 
    "Then define the function \\(g_n\\) by\n" . 
    "\\[g_n: \\mathbb{R} \\rightarrow \\mathbb{R}\\]" . 
    "\\[a \\mapsto n(f(a + " . ptex::frac(1,'n') . ") - f(a)).\\]" . 
    "Since \\(f\\) is differentiable, it is also continuous and therefore Lebesgue measurable, from which it follows, by Theorem 16.5, that \\(g_n\\) is also Lebesgue measurable for each \\(n\\).\n" .
    "Moreover, \\(g_n \\rightarrow f'\\) everywhere on \\(\\mathbb{R}\\), by construction.\n" . 
    "Therefore \\(f'\\) is Lebesgue measurable by Theorem 16.6.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "Let \\((X,S,\\mu)\\) be a measure space and let \\(f: \\mathbb{R} \\rightarrow \\mathbb{R}\\) be a measurable function.\n" .
    "Show that\n\n" . 
    "(a) \\(|f|^p\\) is a measurable function for all \\(p \\geq 0\\), and\n\n" . 
    "(b) if \\(f(x) \\not = 0\\) for each \\(x \\in X\\), then \\(" . ptex::frac(1, 'f') . "\\) is a measurable function.\n";
$pf = "(a) If \\(p = 0\\), then \\(|f|^p = 1\\), which is measurable.\n" . 
    "Assume \\(p > 0\\) and let \\(a \\in \\mathbb{R}\\) be given.\n" . 
    "Then \\(\\{x \\in X \\mid |f|^p \\leq a\\} = \\emptyset\\) if \\(a < 0\\) and\n" . 
    "\\[\\{x \\in X \\mid |f|^p \\leq a\\} = f^{-1}([-\\sqrt{a},\\sqrt{a}]), \\text{ if } a \\geq 0.\\]\n" . 
    "Therefore \\(|f|^p\\) measurable by Theorem 16.2.\n\n" . 
    "(b) Let \\(a \\in \\mathbb{R}\\) be given.\n" . 
    "By assumption, \\(f^{-1}(0) = \\emptyset\\), so consider the set\\\\ \\(A = \\{x \\in X \\mid " . ptex::frac(1, 'f') . "\\leq a\\}\\).\n"  .
    "It suffices to show that this set is measurable.\n" . 
    "Then\n" . 
    "\\[A = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "f^{-1}((-\\infty,0]) & \\text{if } a = 0,\\\\\n" .
    "f^{-1}([" . ptex::frac(1,'a') .",\\infty)) & \\text{if } a > 0,\\\\\n" . 
    "f^{-1}((-\\infty,".ptex::frac(1,'a')."]) & \\text{if } a < 0.\n" .
    "\\end{array}\n" .
    "\\right.\\]\n" .
    "Since each of these sets are measurable by Theorem 16.2, A is measurable for any \\(a\\).\n" . 
    "Therefore, \\(" . ptex::frac(1, 'f') . "\\) is a measurable function, by Theorem 16.2.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "Let \\(\\{f_n\\}\\) be a sequence of real-valued measurable functions on a measure space \\((X,S,\\mu)\\).  Then show the sets\n\n" . 
    "(a) \\(A = \\{x \\in X \\mid f_n(x) \\rightarrow \\infty\\}\\),\n\n" . 
    "(c) \\(C = \\{x \\in X \\mid \\lim f_n(x) \\text{ exists in } \\mathbb{R}\\}\\)\n\\\\". 
    "are measurable sets.\n";
$pf = "(a) For each \\(M,N \\in \\mathbb{N}\\) let \\[E_{M,N} = \\{x \\in X \\mid f_n(x) \\geq M \\text{, for each } n \\geq N\\}\\] and observe that \\(A = \\cap_{M=1}^{\\infty}\\cup_{N=1}^{\\infty}E_{M,N}.\\)\n" . 
    "Then for each fixed \\(M\\),\\\\ \\(E_{M,N} = \\cup_{N=1}^{\\infty}\\cap_{n=N}^{\\infty} f_n^{-1}([M,\\infty)),\\) so \\(E_{M,N} \\in \\Lambda\\) for each \\(M,N\\).\n" . 
    "Moreover, \\[A = \\bigcap_{M=1}^{\\infty}\\bigcup_{N=1}^{\\infty}\\bigcap_{n=N}^{\\infty}f_n^{-1}([M,\\infty)).\\]" . 
    "Therefore, \\(A \\in \\Lambda\\), as desired.\n\n" . 
    "(b) For each \\(M,N \\in \\mathbb{N}\\) let \\[E_{M,N} = \\{x \\in X \\mid |f_n(x) - a| < " . ptex::frac(1, 'M') . "\\text{, for each } n \\geq N\\}\\] and observe that \\(C = \\cap_{M=1}^{\\infty}\\cup_{N=1}^{\\infty}E_{M,N}.\\)\n" . 
    "Then for each fixed \\(M\\),\\\\ \\(E_{M,N} = \\cup_{N=1}^{\\infty}\\cap_{n=N}^{\\infty} |f_n - a|^{-1}((-\\infty,".ptex::frac(1,'M') . "))\\).\n" . 
    "Since \\(|f_n - a|\\) is a measurable function by Theorem 16.5, then it follows from Theorem 16.2 that \\(E_{M,N} \\in \\Lambda\\) for each \\(M,N\\).\n" . 
    "Moreover, \\[A = \\bigcap_{M=1}^{\\infty}\\bigcup_{N=1}^{\\infty}\\bigcap_{n=N}^{\\infty}|f_n-a|^{-1}([M,\\infty)).\\]" . 
    "Therefore, \\(C \\in \\Lambda\\), as desired.\n\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "Let \\(X = \\mathbb{R}\\) and let \\[S = \\{E \\subseteq X \\mid \\text{either } E \\text{ or } E^{c} \\text{ is finite or countable}\\}.\\]\n" . 
    "Let \\(\\mu:S \\rightarrow [0,\\infty] \\) be defined by\n" . 
    "\\[ \\qquad \\mu(E) = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "0 & \\text{if } E \\text{ is countable or finite,}\\\\ \n" .
    "1 & \\text{if } E \\text{ is uncountable}.\n" .
    "\\end{array}\n" .
    "\\right.\\]\n" .
    "Let \\(f: \\mathbb{R} \\rightarrow \\mathbb{R}\\) be a measurable function.\\\\\n" .
    "(a) Show that there is a unique integer \\(n\\) such that \\(f^{-1}([n,n+1))\\) is uncountable, and for every other integer \\(k\\), \\(f^{-1}([k,k+1))\\) is countable.\n" . 
    "Then let \\[A = \\{a \\in \\mathbb{R} \\mid f^{-1}((a,\\infty)) \\text{ is countable}\\}\\]\n" . 
    "and deduce that \\(A\\) is bounded below.\\\\\n" . 
    "(b) Let \\(c = \\inf{A}\\).  Show that \\(\\{x \\in \\mathbb{R} \\mid f(x) > c\\}\\) is countable.\\\\\n" . 
    "(c) Deduce from (b) that for each \\(d < c\\), \\(\\{x \\in \\mathbb{R} \\mid f(x) < d\\}\\) is countable.\\\\\n" . 
    "(d) Deduce from (b) and (c) that there is a unique real number \\(c\\) such that \\(f(x) = c\\) for all but a countable number of \\(x \\in \\mathbb{R}\\), i.e., if a function \\(f\\) is measurable then it is constant a.e.\n";
$pf = "(a) Suppose first that there were no such integer \\(n\\) for which \\(f^{-1}([n,n+1))\\) were uncountable.\n" . 
    "Then \\(f^{-1}(\\mathbb{R})\\) would indeed be countable and thus \\(f\\) would not be defined except on a set of measure zero, i.e. \\(f\\) would be undefined almost everywhere.\n" . 
    "Hence there must exist at least one such interval.\n\n" . 
    "Assume there were two such intervals, \\([n,n+1)\\) and \\([m,m+1)\\).\n" . 
    "Let \\(A = f^{-1}([n,n+1))\\) and let \\(B = f^{-1}([m,m+1))\\).\n" .
    "By the previous homework set, \\(A \\cap B \\not = \\emptyset\\), indeed the intersection is necessarily co-countable.\n" . 
    "Hence, \\(A = B\\) except possibly on a set of measure zero, \\((A \\cap B)^c\\).\n" .
    "Therefore, it must be the case that \\(m = n\\).\n\n" .
    "Whenever \\(a < n\\), \\([n,n+1) \\subseteq (a,\\infty)\\) and thus \\(f^{-1}((a,\\infty))\\) is not countable.  Hence, \\(A\\) is bounded below by \\(n\\).\n\n". 
    "Whenever \\(f(x) > c\\), \\(f(x) \\in A\\).  Hence \\(\\{x \\in R \\mid f(x) > c\\} = f^{-1}(A)\\), which is countable by its construction.\n\n" .
    "(c) Since \\(c = \\inf{A}\\), it must be the case that \\(f^{-1}([c,\\infty))\\) is uncountable as otherwise there would exist some element \\(c' < c\\) of \\(A\\), such that \\(f^{-1}((c',\\infty))\\) is countable.\n" . 
    "Then whenever \\(d < c\\), it follows that \\(\\{x \\in R \\mid f(x) < d\\} = f^{-1}((-\\infty, d))\\) must be countable.\n\n" . 
    "(d) Now by (b) and (c), \\(f^{-1}(\\{c\\}^c)\\) is countable, so it must be the case that \\(f^{-1}(\\{c\\})\\) is uncountable.\n" . 
    "Therefore, \\(f = c\\) except on a set of measure zero, namely \\(f^{-1}(\\{c\\}^c)\\).";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "Find all measurable functions for the measure space in Exercise 3 of Homework 4.\n";
$pf = "From the previous homework, the measure space \\((X,S,\\mu)\\) with \\(S = \\{\\emptyset, A\\}\\) for some \\(A \\subset X\\), has measurable sets \\(\\Lambda_{\\mu^*} = \\{E \\subseteq X \\mid A \\subseteq E \\text{ or } E \\subseteq A^c\\}\\).\n". 
    "Then for any measurable function, \\(f:X \\rightarrow \\mathbb{R}\\), exactly one of the following hold for the preimage of an open set \\(O \\subset \\mathbb{R}\\):\n" .
    "either \\(f^{-1}(O) \\subseteq A^c\\) or \\(A \\subseteq f^{-1}(O)\\).\n" . 
    "";

print "\\newpage\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
