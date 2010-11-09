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
    $course) = (6,
		"Math-333");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Monday, October 25, 2010",
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
my $thm = "Let \\((X,S,\\mu)\\) be a measure space, and let \\(f: X \\rightarrow [0,\\infty)\\) be a function.\n" . 
    "Show that \\(f\\) is a measurable function if and only if there exist non-negative constants \\(c_1, c_2, \\ldots\\) and measurable sets \\(E_1, E_2, \\ldots\\) such that\n" . 
    "\\[f(x) = \\sum_{n=1}^{\\infty}{c_n \\chi_{E_n}(x)}\\]" . 
    "hold for each \\(x \\in X\\).";
my $pf = "Assume \\(f\\) is a measurable function so, by Theorem 17.7, there exists a sequence of simple functions \\(\\{\\varphi_n\\}_{n=1}^{\\infty}\\) such that \\(0 \\leq \\varphi_n(x) \\uparrow f(x)\\) holds for each \\(x \\in X\\).\n" . 
    "Define a sequence of simple functions \\(\\{\\psi_n\\}_{n=1}^{\\infty}\\) by \\(\\psi_1 = \\varphi_1\\) and \\(0 \\leq \\psi_n = \\varphi_n - \\varphi_{n-1}\\), for each \\(n >1\\).\n\n" . 
    "Now observe that for each \\(n\\),\n" . 
    "\\[\\sum_{i=1}^{n}{\\psi_n}(x) = \\varphi_n(x),\\]\n" . 
    "from which it follows that\n". 
    "\\[\\sum_{n=1}^{\\infty}{\\psi_n(x)} = \\lim_{n \\rightarrow \\infty} \\sum_{i=1}^{n}{\\psi_n(x)} = \\lim_{n \\rightarrow \\infty} \\varphi_n(x) = f(x).\\]" . 
    "Since each \\(\\psi_n\\) is simple, there exist non-negative constants \\(c_1, c_2, \\ldots\\) and measurable sets \\(E_1, E_2, \\ldots\\) such that\n" .
    "\\[\\sum_{n=1}^{\\infty}{\\psi_n(x)} = \\sum_{n=1}^{\\infty}{c_n \\chi_{E_n}(x)} = f(x),\\]" . 
    "as desired.\n\n" . 
    
    "Conversely, suppose there exist non-negative constants \\(c_1, c_2, \\ldots\\) and measurable sets \\(E_1, E_2, \\ldots\\) such that \n" . 
    "\\[f(x) = \\sum_{n=1}^{\\infty}c_n\\chi_{E_n}(x).\\]" . 
    "Let \\(\\varphi_n = \\sum_{i=1}^{n}{c_i\\chi_{E_i}}\\) and observe\n" . 
    "\\[f(x) = \\sum_{n=1}^{\\infty}{c_n\\chi_{E_n}(x)} = \\lim_{n \\rightarrow \\infty} \\sum_{i=1}^{n}{c_i\\chi_{E_i}(x)} = \\lim_{n\\rightarrow\\infty}\\varphi_n(x).\\]\n". 
    "Hence \\(f\\) is the limit of the simple, and thus also measurable, functions \\(\\varphi_n\\).\n" . 
    "Therefore, by Theorem 16.6, \\(f\\) is measurable.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "Consider the function \\(f: $R \\rightarrow $R\\) defined by \\(f(x) = 0\\) if \\(x \\not \\in (0,1]\\), and \\(f(x) = \\sqrt{n}\\) if \\(x \\in (" . ptex::frac(1,"n+1") . "," . ptex::frac(1,"n") . "]\\) for some \\(n\\).\n" . 
    "Show that f is an upper function and that \\(-f\\) is not an upper function.\n";
$pf = "Let \\(A_i = \\{\\,x \\in X \\mid x \\in (" . ptex::frac("1","i+1") ."," . ptex::frac("1","i") . "]\\,\\}\\).\n" . 
    "Define step functions\n" . 
    "\\[\\varphi_n = \\sum_{i=1}^{n}{\\sqrt{i} \\chi_{A_i}}\\]\n" . 
    "and observe that \\(\\varphi_n(x) \\uparrow f(x)\\), for each \\(x \\in X\\).\n" . 
    "It remains only to show that \\(\\lim_{n\\rightarrow\\infty}\\int{\\varphi_n} < \\infty\\).\n" .
    "To that end, observe that for each \\(n\\)\n".
    $beq .
    ptex::printEqnArray([["\\int{\\varphi_n d\\lambda}", "\\sum_{i=1}^{n}{" . ptex::frac("\\sqrt{i}","i(i+1)") . "}"],
			 ["", "\\sum_{i=1}^{n}{" . ptex::frac("1","\\sqrt{i}(i+1)") . "}"]],"=") . 
    ptex::printEqnArray([["","\\sum_{i=1}^{n}{i^{-".ptex::frac("3","2")."}}."]], "\\leq") .
    $eeq . 
    "Now, from calculus, \\(\\sum_{n=1}^{\\infty}{i^{-".ptex::frac("3","2") ."}}\\) is a convergent \`p-series\'.\n" . 
    "Therefore\n" . 
    "\\[\\lim_{n\\rightarrow\\infty}\\int{\\varphi_n} \\leq \\lim_{n\\rightarrow\\infty}\\sum_{i=1}^{n}{i^{-".ptex::frac("3","2")."}} < \\infty,\\]\n" . 
    "as desired.\n\n" . 
    "The function \\(-f\\) is not an upper function because it is not bounded below, so it is not possible for any sequence of step functions \\(\\{\\varphi_n\\}\\) to satisfy \\(\\varphi_n \\leq f\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "Let \\(A\\) be a measurable set, and let \\(f\\) be an upper function.\n" . 
    "If \\(\\chi_A \\leq f\\) a.e., then show that \\(\\mu^*(A) < \\infty\\).\n";
$pf = "Let \\(\\{\\varphi_n\\}_{n=1}^{\\infty}\\) be a generating sequence of \\(f\\).\n" . 
    "Since \\(f \\geq \\chi_A\\) a.e., the sequence \\(\\{\\varphi_n \\wedge \\chi_A\\}_{n=1}^{\\infty}\\) is a sequence of step functions for which \\(\\varphi_n \\wedge \\chi_A \\uparrow \\chi_A\\) a.e.\n". 
    "Therefore, by Theorem 17.6,\n" . 
    "\\[\\mu^*(A) = \\lim_{n\\rightarrow\\infty} \\int{\\varphi_n \\wedge \\chi_A d\\mu} \\leq \\lim_{n\\rightarrow\\infty}\\int{\\varphi_n d\\mu} < \\infty.\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "Let \\(f:X \\rightarrow $R\\) be an upper function.  Prove that for every \\(\\varepsilon > 0\\) there is a \\(\\mu^*\\)-measurable set \\(E\\) such that \\(\\mu^*(E) < \\infty\\) and\n" . 
    "\\[\\left| \\int{f d\\mu} - \\int{\\chi_E f d\\mu}\\right| < \\varepsilon.\\]\n";
$pf = "Let \\(\\varepsilon > 0\\) be given.\n" . 
    "Let \\(\\{\\varphi\\}_{n=1}^{\\infty}\\) be a generating sequence for \\(f\\), so that \\(\\int{\\varphi_n d\\mu} \\uparrow \\int{f d\\mu}\\).\n" . 
    "Choose \\(N \\in $N\\) such that\n" . 
    "\\[\\left|\\int{f d\\mu} - \\int{\\varphi_{N} d\\mu}\\right| < \\varepsilon.\\]\n" . 
    "Since \\(\\varphi_{N}\\) is a step function, there exists a finite collection of sets, \\(E_1, E_2, \\ldots, E_m\\), each with finite measure which is the support of \\(\\varphi_{N}\\).\n" . 
    "Let \\(E = \\cup_{i=1}^m E_i\\) then observe that \\(\\chi_Ef\\) is still an upper function with \\(\\varphi_n \\leq \\chi_Ef\\), hence\n " . 
    "\\[\\left| \\int{f d\\mu} - \\int{\\chi_Efd\\mu}\\right| \\leq \\left|\\int{f d\\mu} - \\int{\\varphi_{N} d\\mu}\\right| < \\varepsilon,\\]" . 
    "as desired.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "For each of the following measure spaces find all upper functions and their integrals:\n\n" .
    "a) For a set \\(X\\), fix \\(A \\subsetneq X,\\, \\text{let } S = \\{\\emptyset,A\\}\\, \\text{and define }\\mu: S \\rightarrow [0,\\infty]\\) by \\(\\mu(\\emptyset) = 0,\\, \\mu(A) = 1\\).\n\n" . 
    "b) Let \\(X = $R\\), \\(S = \\{\\,E \\subseteq $R \\mid \\text{ either } E \\text{ or } E^c \\text{ is finite or countable}\\,\\}\\) and define \\(\\mu:S\\rightarrow[0,\\infty]\\) by" . 
    "\\[ \\qquad \\mu(E) = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "0 & \\text{if } E \\text{ is countable or finite,}\\\\ \n" .
    "1 & \\text{if } E \\text{ is uncountable}.\n" .
    "\\end{array}\n" .
    "\\right.\\]" . 
    "\n\n" . 
    "c) Let \\(X = $R\\), \\(S = \\{\\,[n,m) \\mid n,m \\in $Z \\text{ with } n\\leq m\\,\\}\\) and define \\(\\mu:S\\rightarrow[0,\\infty)\\) by \\(\\mu([n,m)) = m-n\\).\n\n";
$pf = "a) For this measure space, \\[\\Lambda_{\\mu^*} = \\{\\,E \\subseteq X\\mid A \\subseteq E \\text{ or } E \\subseteq A^c\\,\\}\\] and for any \\(E \\not = A\\) in \\(\\Lambda_{\\mu^*}\\), \\(\\mu^*(E) = \\infty\\).\n" . 
    "From the previous homework set, in order to be measurable, any upper function must be constant on the set \\(A\\).\n" .
    "Moreover, any upper function must have a finite integral.\n" . 
    "Since any function taking on a non-zero value anywhere outside \\(A\\) would have an infinite integral, the upper functions for this measure space are the functions which are constant on \\(A\\) and zero elsewhere.\n\n" .
    "To find the integral of any upper function, fix some \\(c \\in $R\\) and let \\(f:X \\rightarrow $R\\) be the function defined by\n" .
    "\\[ \\qquad f(x) = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "c & \\text{if } x \\in A,\\\\ \n" .
    "0 & \\text{if } x \\not \\in A.\n" .
    "\\end{array}\n" .
    "\\right.\\]" . 
    "\n\n" . 
    "Define a sequence of step functions \\(\\{\\varphi_n\\}_{n=1}^{\\infty}\\) by \\(\\varphi_n = c\\chi_A\\).\n" .
    "Then \\(\\varphi_n \\uparrow f\\) and \\[\\int{f d\\mu} = \\lim_{n\\rightarrow\\infty}\\int\\varphi_nd\\mu = \\lim_{n\\rightarrow\\infty}c\\mu(A) = c.\\]" .
    "\n\n" . 
    "b) From the previous homework set, a function is measurable in this measure space if and only if it is constant almost everywhere.\n".
    "Let \\(f\\) be any measurable function, so there exists some \\(c \\in $R\\) such that \\(f = c\\) a.e.\n" . 
    "Let \\(A = f^{-1}(\\{c\\})\\) and observe that since \\(\\{c\\}\\) is a closed set, \\(A\\) is measurable by Theorem 16.2 and \\(\\mu^{*}(A) = \\mu(A) = 1\\).\n" .
    "Define a sequence of step functions \\(\\{\\varphi_n\\}_{n=1}^{\\infty}\\) by \\(\\varphi_n = c\\chi_A\\).\n" .
    "Then \\(\\varphi_n \\uparrow f\\) and \\[\\int{f d\\mu} = \\lim_{n\\rightarrow\\infty}\\int\\varphi_nd\\mu = \\lim_{n\\rightarrow\\infty}c\\mu(A) = c.\\]\n" .
    "Therefore, the upper functions in this measure space are the measurable functions and their integral is as above." .
    "\n\n" . 
    #"c) The step functions for this measure space are constant on intervals of the form \\([m,n),\\, m,n \\in $Z\\).\n" . 
    #"Hence, in order to be upper, any function must at least be constant on such intervals.\n" . 
    #"Suppose \\(f\\) is upper so there exist step functions \\(\\{\\varphi_n\\}\\) such that \\(\\varphi_n\\uparrow f\\).\n " .
    #"In order to allow \\(\\varphi_n\\) to converge upwards to \\(f\\), \\(f\\) must be non-negative except possibly on a set of finite measure.\n" . 
    #"Since the step functions are constant on the intervals of the semiring, ";
    "c) The upper functions for this measure space are the functions constant on the sets of the semiring, non-negative except possibly on a set of finite measure and have the integral \\[\\sum_{z \\in $Z}f(z) < \\infty.\\]";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6"; 
$thm = "Let \\(g: $R \\rightarrow $R\\) by \\(g(x) = \\) the greatest integer \\it{less than \\(x\\)}.  Let \\(\\mu_g\\) be the Lebesgue-Stieltjes measure on \\($R\\) given by \\(g\\).\n\n" . 
    "a) What are the sets of \\(\\mu_g^*\\)-measure \\(0\\) in \\($R\\)?  What are the \\(\\mu_g^*\\)-measurable sets?\n\n" . 
    "b) Describe the step functions and upper functions in this measure space, and find their Lebesgue integrals.\n\n" . 
    "c) Find necessary and sufficient conditions on a function \\(f\\) for \\(f\\) to be \\(\\mu_g\\)-integrable.\n" . 
    "When \\(f\\) is integrable find \\(\\int{f d\\mu_g^*}\\)\n\n";
$pf = "a) The sets of \\(\\mu_g^*\\)-measure zero are the subsets of \\($Z^c\\).\n\n" . 
    "First observe that the largest interval contained by \\($Z^c\\) is that of the form \\((n,n+1)\\), where \\(n \\in $Z\\).\n" . 
    "Then\n" . 
    "\\[(n,n+1) \\subseteq \\bigcup_{m=1}^{\\infty}\\left[n + " . ptex::frac(1,'m') . ",n+1-" . ptex::frac(1,'m') . "\\right)\\]\n" . 
    "and for each \\(m \\in $N\\), \\(\\mu_g(\\left[n + " . ptex::frac(1,'m') . ",n+1-" . ptex::frac(1,'m') . "\\right)) = 0\\).\n". 
    "Hence\n" . 
    "\\[\\mu_g^*((n,n+1)) \\leq \\sum_{m=1}^{\\infty}\\mu_g\\left(\\left[n + " . ptex::frac(1,'m') . ",n+1-" . ptex::frac(1,'m') . "\\right)\\right) = 0.\\]\n" . 
    "Therefore, \\(\\mu_g^*((n,n+1)) = 0\\) and, since any subset \\(E\\) of \\($Z^c\\) can be covered by intervals of the form \\((n,n+1)\\), \\(\\mu_g^*(E) = 0\\) as well.\n\n" . 
    "Conversely, suppose \\(E \\not \\in $Z^c\\).\n" . 
    "Then there exists some \\(z \\in $Z\\) such that \\(z \\in E\\) with\n" . 
    "\\[\\{z\\} = \\bigcap_{n=1}^{\\infty}\\left[z,z+".ptex::frac(1,'n')."\\right).\\]\n" . 
    "Since \\(\\left[z,z+".ptex::frac(1,'n')."\\right) \\in S\\) for each \\(n\\) and \\(\\left[z,z+".ptex::frac(1,'n')."\\right) \\downarrow \\{z\\}\\),\n" . 
    "it follows from Theorem 15.4 that \\(\\{z\\}\\) is \\(\\mu_g^*\\)-measurable and its measure is\n" . 
    "\\[\\lim_{n \\rightarrow \\infty} g\\left(z + ".ptex::frac(1,'n')."\\right) - g\\left(z\\right) = z - \\left(z - 1\\right) = 1.\\]\n" . 
    "Therefore \\(\\mu_g^*(E) \\geq 1\\).\n\n" . 
    "The \\(\\mu_g^*\\)-measurable sets are the power set of \\($R\\).\n" . 
    "To see this, consider any subset \\(A\\) of \\($R\\), which can be written as\n" . 
    "\\[A = (A \\cap $Z) \\cup (A \\cap $Z^c).\\]\n" . 
    "Since \\(A \\cap $Z^c \\subseteq $Z^c\\), its measure is zero.\n" .
    "Furthermore, from above any integer is \\(\\mu_g^*\\)-measurable, so \\(A \\cap $Z\\) can be written as the union of measurable sets.\n" .
    "Therefore, since \\(\\Lambda_{\\mu_g^*}\\) is closed under unions, \\(A\\) is a \\(\\mu_g^*\\)-measurable set.\n\n" .
    #"By monotonicity, \\(\\mu_g(A) \\geq \\mu_g^*(A \\cap $Z)\\).\n" . 
    #"However, from the argument above \\(A \\cap $Z^{c} \\subseteq $Z^c\\) implies \\(\\mu_g^*(A \\cap $Z^c) = 0\\), from which it follows that\n" . 
    #"\\[\\mu_g^*(A \\cap $Z) + \\mu_g^*(A \\cap $Z^c) = \\mu_g^*(A \\cap $Z) \\leq \\mu_g(A).\\]\n" . 
    #"Therefore \\(\\mu_g(A) = \\mu_g^*(A \\cap$Z)\\).\n\n" . 
    "b) The step functions are the functions are the functions which attain only finitely many values on the integers and are zero off the integers.\n" .
    "The upper functions are the functions which attain negative values on only finitely many integers and have the integral\n" . 
    "\\[\\sum_{z \\in $Z}f(z) < \\infty.\\]\n" . 
    "Since the subsets of \\(Z^c\\) have measure zero, the upper functions need not be restricted on these sets as they do not add to the integral." .
    "\n\n" . 
    "c) Since any set contained by \\($Z^c\\) has measure zero, for a function \\(f\\) to be integrable it is both necessary and sufficient for\n" . 
    "\\[\\sum_{z \\in $Z} f(z) < \\infty.\\]" . 
    "In this case, the above sum is the integral of \\(f\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
