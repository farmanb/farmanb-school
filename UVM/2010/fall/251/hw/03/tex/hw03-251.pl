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
    $course) = (3, 
		"Math-251");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Friday, September 24, 2010",
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

my $name = "1"; 
my $thm = "For each fixed non-zero \\(k \\in \\mathbb{Q}\\), the map" . 
    "\\[\\varphi : \\mathbb{Q} \\rightarrow \\mathbb{Q}\\]" . 
    "\\[q \\mapsto kq\\]" . 
    "is an automorphism of \\(\\mathbb{Q}\\).\n"; 
my $pf = "Let \\(p,q \\in \\mathbb{Q}\\) be distinct.\n" . 
    "Since \\(k\\) is fixed, by the left cancellation law \\(\\varphi(p)  = \\varphi(q)\\) only if \\(p = q\\).\n" . 
    "Hence \\(\\varphi\\) is injective.\n\n" . 
    "To see that \\(\\varphi\\) is surjective, let \\(p\\) be given and observe that there exists some \\(q \\in \\mathbb{Q}\\) such that \\(\\varphi(q) = p\\).\n" . 
    "Since \\(k\\) is non-zero, take \\(q = " . ptex::frac("p","k") . "\\).\n" . 
    "Then \\(\\varphi(q) = p\\).  Therefore \\(\\varphi\\) is a bijection.\n\n" . 
    "It remains only to show that \\(\\varphi\\) is a homomorphism.\n" . 
    "Let \\(p,q \\in \\mathbb{Q}\\) be given.\n" . 
    "Then" . 
    $beq .
    ptex::printEqnArray([["\\varphi(p+q)", "k(p+q)"],
				    ["", "kp + kq"],
				    ["", "\\varphi(p) + \\varphi(q)."]] , "=") . 
    $eeq . "\n". 
    "Therefore, \\(\\varphi\\) is an automorphism of \\(\\mathbb{Q}\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "Let \\(G\\) be any group and let \\(A = G\\).  Show that the maps defined by \\(g \\cdot a = gag^{-1}\\) do satisfy the axioms of a (left) group action.\n"; 
$pf = "i) Let \\(g_1, g_2 \\in G\\) and \\(a \\in A\\) be given.\n" . 
    "Then\n" . 
    $beq .
    ptex::printEqnArray([["(g_1g_2)\\cdot a", "g_1g_2a(g_1g_2)^{-1}"],
				    ["", "g_1(g_2ag_2^{-1})g_1^{-1}"],
				    ["", "g_1 \\cdot (g_2 \\cdot a)."]] , "=") . 
    $eeq . "\n" . 
    "ii) Let \\(a \\in A\\) be given.\n".
    "Since \\(A = G\\), observe that \\(1a = a1 = a\\) and \\(1^{-1} = 1\\).\n" .
    "So it follows that\n" . 
    $beq .
    ptex::printEqnArray([["1 \\cdot a", "1a1^{-1}"],
				    ["", "1a1"],
				    ["", "a."]] , "=") . 
    $eeq . "\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "Let \\(G\\) be a group and let \\(G\\) act on itself by left conjugation, so each \\(g\\in G\\) maps \\(G\\) to \\(G\\) by \\[x \\mapsto gxg^{-1}.\\]\n" . 
    "For fixed \\(g \\in G\\), prove that conjugation by \\(g\\) is an automorphism of \\(G\\).\n" . 
    "Deduce that \\(x\\) and \\(gxg^{-1}\\) have the same order for all \\(x\\) in \\(G\\) and that for any subset \\(A\\) of \\(G\\), \\(|A| = |gAg^{-1}|\\), where \\(gAg^{-1} = \\{gag^{-1} \\mid a \\in A\\}\\).\n"; 
$pf = "Fix \\(g \\in G\\) and let \\(\\varphi\\) be defined by\n" . 
    "\\[\\varphi : G \\rightarrow G\\]\n" .
    "\\[x \\mapsto gxg^{-1}.\\]\n" . 
    "Let \\(\\alpha,\\beta \\in G\\) be distinct.\n" . 
    "Since \\(g\\) is fixed, by the cancellation laws \\(\\varphi(\\alpha) = \\varphi(\\beta)\\) only if \\(\\alpha = \\beta\\).\n" . 
    "Hence \\(\\varphi\\) is injective.\n\n" . 
    "Now let \\(\\beta \\in G\\) be given.  To see \\(\\varphi\\) is surjective, observe that there exists some \\(\\alpha \\in G\\) such that \\(\\varphi(\\alpha) = \\beta\\).\n" .
    "Namely take \\(\\alpha = g^{-1}{\\beta}g\\).\n" .
    "Then \\(\\varphi(\\alpha) = \\beta\\).\n" .
    "Therefore \\(\\varphi\\) is a bijection.\n\n" . 
    "It remains only to show that \\(\\varphi\\) is a homomorphism.\n". 
    "Let \\(\\alpha, \\beta \\in G\\) be given.  Then\n" . 
    $beq .
    ptex::printEqnArray([["\\varphi(\\alpha\\beta)", "g\\alpha \\beta g^{-1}"],
				    ["", "(g\\alpha g^{-1})(g\\beta g^{-1})"],
				    ["", "\\varphi(\\alpha)\\varphi(\\beta)."]] , "=") . 
    $eeq . 
    "Therefore \\(\\varphi\\) is an automorphism of \\(G\\).\n\n" . 
    "That \\(|A| = |gAg^{-1}|\\) follows immediately from the bijective property of \\(\\varphi\\).\n" . 
    "To see \\(x\\) and \\(gxg^{-1}\\) have the same order for all \\(x\\) in \\(G\\), let \\(n = |x|\\) and consider \\(\\varphi(x^n)\\).\n" . 
    "From the previous homework set, \\(\\varphi(x^n) = \\varphi(x)^n\\) implies \\((gxg^{-1})^n\\) = 1 and thus \\(|gxg^{-1}| \\leq n\\).\n" . 
    "Now suppose there exists some \\(k<n\\) such that \\((gxg^{-1})^k = 1\\).\n" . 
    "Then\n" . 
    $beq .
    ptex::printEqnArray([["\\varphi(x^k)", "(gxg^{-1})^k"],
			 ["", "1"],
			 ["", "\\varphi(1)."]] , "=") . 
    $eeq . 
    "Since \\(\\varphi\\) is injective, this implies \\(x^k = 1\\).\n" . 
    "This is a contradiction.\n" . 
    "Therefore, \\(x\\) and \\(gxg^{-1}\\) have the same order.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "Show that the specified subset is or is not a subgroup of the given group.\n"; 
$pf = "a)\\(H = \\{a + ai \\mid a \\in \\mathbb{R}\\} \\subseteq \\mathbb{C}\\).\n" . 
    "Let \\(a = \\alpha + i\\alpha, b = \\beta + i\\beta\\) be given.  Then \\(ab = (\\alpha + \\beta) + i(\\alpha + \\beta)\\).\n" .
    "Hence \\(H\\) is closed under addition.\n" . 
    "Furthermore, for any \\(a \\in H\\), its inverse \\(-a = (-\\alpha) + i(-\\alpha) \\in H\\) implies \\(H \\leq \\mathbb{C}\\).\n\n" . 
    "b) \\(H = \\{\\alpha + i\\beta \\mid \\alpha^2 + \\beta^2 = 1\\} \\subseteq \\mathbb{C}\\).\n" .
    "Let \\(a = \\alpha + i\\beta, b = \\gamma + i\\delta\\) be given.\n" .
    "Then\n". 
        $beq .
    ptex::printEqnArray([["|ab|", "(\\alpha\\gamma - \\beta\\delta)^2 + (\\alpha\\delta + \\beta\\gamma)^2"],
			 ["", "(\\alpha\\gamma)^2 - 2\\alpha\\beta\\gamma\\delta + (\\beta\\delta)^2 + (\\alpha\\delta)^2 + 2\\alpha\\beta\\gamma\\delta + (\\beta\\gamma)^2"],
			 ["", "\\gamma^2(\\alpha^2 + \\beta^2) + \\delta^2(\\alpha^2 + \\beta^2)"],
			 ["", "\\gamma^2 + \\delta^2"],
			 ["", "1."]], "=") . 
    $eeq . 
    "Hence \\(H\\) is closed under addition.  So for any \\(a \\in H\\) consider \\(a^{-1} = " . ptex::frac("\\alpha - i\\beta", "\\alpha^2 + \\beta^2") ."\\).  Then \\(a^{-1} = \\bar{a} \\in H\\) implies \\(H\\) is closed under inverses.\n" . 
    "Therefore, \\(H \\leq \\mathbb{C}\\).\n\n" . 
    "c) \\(H = \\{".ptex::frac("p","q") . " \\in \\mathbb{Q} \\mid (q,n) = q, \\text{fixed } n \\in \\mathbb{Z}^+\\} \\subseteq \\mathbb{Q}\\).\n" . 
    "Let \\(x,y \\in H\\) be given.\n" .
    "Then \\[x+y = " . ptex::frac("p","q") . "+" . ptex::frac('r','s') . " = " . ptex::frac('ps + rq', 'qs') . ".\\]\n" .
    "If \\(qs \\leq n\\), then \\(qs\\) divides \\(n\\).\n" . 
    "So, assume that \\(qs > n\\).\n" . 
    "If this is the case, then it must be that g = \\((q,s) > 1\\).\n" . 
    "Then \\[" . ptex::frac('ps + rq', 'qs') . " = " . ptex::frac('(gj)p + (gk)r', 'g^2(jk)') . "\\text{, for some } j,k \\in \\mathbb{Z}.\\]\n" . 
    "So the denominator becomes \\(gjk\\), where \\(g, j \\text{ and } k\\) are all necessarily relatively prime factors of \\(n\\) and thus \\(gjk \\leq n\\).\n" . 
    "Therefore, \\(H\\) is closed under addition.\n" . 
    "Furthermore, for any \\(x \\in H\\), \\(x^{-1} = -x \\in H\\) implies that \\(H\\) is closed under inverses.\n" . 
    "Therefore, \\(H \\leq \\mathbb{Q}\\).\n\n" . 
    "d) \\(H = \\{".ptex::frac("p","q")."\\in \\mathbb{Q} \\mid (n,q) = 1, \\text{fixed } n \\in \\mathbb{Z}^+\\} \\subseteq \\mathbb{Q}\\)". 
    "Let \\(x,y \\in H\\) be given.\n" . 
    "Then \\[x+y = " . ptex::frac("p","q") . "+" . ptex::frac('r','s') . " = " . ptex::frac('ps + rq', 'qs') . ".\\]\n" . 
    "Since \\((q,n) = 1\\) and \\((s,n) = 1\\), \\((qs,n) = 1\\) which implies \\(x+y \\in H\\).\n" .
    "Hence \\(H\\) is closed under addition.\n" .
    "Furthermore, for any \\(x \\in H\\), \\(x^{-1} = -x \\in H\\) implies \\(H\\) is closed under inverse.\n" .
    "Therefore, \\(H \\leq \\mathbb{Q}\\).\n\n" .
    "e) \\(H = \\{a > 0 \\in \\mathbb{R} \\mid a^2 \\in \\mathbb{Q}\\} \\subseteq \\mathbb{R}\\).\n". 
    "Let \\(x,y\\in H\\) be given.  Then since \\(\\mathbb{Q}\\) is closed under the commutiative multiplication operation, \\((xy)^2 = x^2y^2 \\in \\mathbb{Q}\\).\n" . 
    "Hence \\(xy \\in H\\) implies \\(H\\) is closed under multiplication.\n" . 
    "Furthermore, since each \\(x\\in H\\) is non-zero, it is invertible and its inverse \\(" . ptex::frac(1,"x") . " \\in H\\).\n" . 
    "Therefore \\(H \\leq \\mathbb{R}\\).\n\n" . 
    "a) The set of 2-cycles in \\(S_n\\) for \\(n \\geq 3\\) is not closed under composition.\n". 
    "Let \\(\\sigma = (1 \\quad 2)\\) and let \\(\\tau = (2 \\quad 3)\\).\n" .
    "Then\n" . 
    $beq .
    ptex::printEqnArray([["\\sigma \\tau", "(1 \\quad 2)(2 \\quad 3)"],
			 ["", "(1 \\quad 2 \\quad 3)."]], "=") . 
    $eeq . 
    "Therefore the set of 2-cycles in \\(S_n\\) for \\(n \\geq 3\\) is not a subgroup.\n\n" . 
    "b) The set of reflections in \\(D_{2n}\\) for \\(n \\geq 3\\) is not closed under the group operation.\n" .
    "Take \\(s\\) and \\(sr^2\\) for example:" .
    "\\[s(sr^2) = r^2.\\]\n" .
    "Therefore the set of reflections in \\(D_{2n}\\) for \\(n \\geq 3\\) is not a subgroup.\n\n" . 
    "c) \\(H = \\{x \\in G \\mid |x| = n\\} \\cup \\{1\\} \\subseteq G\\).\n" . 
    "Let \\(x\\in H\\) be given.  In order to be closed, \\(x^2\\) must be an element of \\(G\\).\n" .
    "However, \\((x^2)^" . ptex::frac("n",2) ." = 1\\) implies that the order of \\(x^2\\) is strictly less than \\(n\\).\n" .
    "Therefore \\(H\\) is not a subgroup of \\(G\\).\n\n" . 
    "d)\\(H = \\{x \\in \\mathbb{Z} \\mid x \\equiv 1 (2)\\} \\cup \\{0\\} \\subseteq \\mathbb{Z}\\).\n" .
    "Since the sum of any two odd integers is always even, \\(H\\) is not closed under addition.  Therefore \\(H\\) is not a subgroup.\n" . 
    "\n\n" . 
    "e)\\(H = \\{x \\in \\mathbb{R} \\mid x^2 \\in \\mathbb{Q}\\} \\subseteq \\mathbb{R}^+\\).\n" . 
    "Take the two elements \\(\\sqrt(2),\\sqrt(3)\\in H\\).  The square of their sum is the irrational number \\[(\\sqrt(2) + \\sqrt(3))^2 = 2 + 2\\sqrt(2)\\sqrt(3) + 3.\\]\n" . 
    "Hence \\(H\\) is not a subgroup.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "Let \\(A\\) and \\(B\\) be groups.  Prove that the following sets are subgroups of the direct product \\(A \\times B\\):\n\n" . 
    "a) \\(G_1 = \\{(a,1) \\mid a \\in A\\}\\)\n\n" . 
    "b) \\(G_2 = \\{(1,b) \\mid b \\in B\\}\\)\n\n" . 
    "c) \\(G_3 = \\{(a,a) \\mid a \\in A\\}\\), where here we assume \\(B = A\\).\n\n"; 
$pf = "Since \\(A\\) and \\(B\\) are both groups, for any two elements \\((x_1,1),(x_2,1) \\in G_1\\), \\((1,y_1),(1,y_2) \\in G_2\\) or \\((x_1,y_2),(x_2,y_2) \\in G_3\\)\n" . 
    "of the above subsets, their respective products \\((x_1x_2,1), (1,y_1y_2), (x_1x_2,y_1y_2)\\) are clearly an element of their respective subset.\n" . 
    "Hence the subsets are closed under the group operation.\n\n" . 
    "Moreover, any such elements have inverses which are elements of their respective subsets,\n" . 
    "\\((x,1)^{-1} = (x^{-1},1)\\),\n" . 
    "\\((1,y)^{-1} = (1,y^{-1})\\), and\n" . 
    "\\((x,y)^{-1} = (x^{-1}, y^{-1})\\).\n" . 
    "Therefore, all three sets are subgroups of \\(A \\times B\\).\n";
       
print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "6 a)"; 
$thm = "Prove that if \\(H\\) and \\(K\\) are subgroups of \\(G\\) then so is their intersection, \\(H \\cap K\\).\n"; 
$pf = "For any element \\(x \\in H \\cap K\\), \\(x \\in H\\) and \\(x \\in K\\) by definition.\n" . 
    "Since \\(H\\) and \\(K\\) are both subgroups of \\(G\\), \\(x^{-1} \\in H\\) and \\(x^{-1} \\in K\\) implies \\(H \\cap K\\) is closed under inverses.\n\n" . 
    "Similarly, for any \\(x,y \\in H \\cap K\\), \\(xy \\in K\\) and \\(xy \\in H\\) implies \\(H \\cap K\\) is closed under multiplication.\n" . 
    "Therefore \\(H \\cap K\\) is a subgroup of \\(G\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "b)"; 
$thm = "Prove that the intersection of arbitrary non-empty subgroups of \\(G\\) is a subgroup.\n"; 
$pf = "Let \\(I\\) be an arbitrary index set and let \\(G_i \\leq G\\), for each \\(i \\in I\\).\n" . 
    "Let \\(g_1,g_2 \\in \\bigcap_{i \\in I}G_i\\).\n" . 
    "Then by definition \\(g_1, g_2 \\in G_i\\), for each \\(i \\in I\\).\n" . 
    "Since each \\(G_i\\) is a subgroup it's necessarily closed under multiplication and inverses, so \\(g_1g_2 \\in \\bigcap_{i \\in I}G_i\\) and \\(g_1^{-1} \\bigcap_{i \\in I}G_i\\) implies \\(\\bigcap_{i \\in I}G_i \\leq G\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "7"; 
$thm = "Let \\(H\\) and \\(K\\) be subgroups of \\(G\\).  Prove that \\(H \\cup K\\) is a subgroup if and only if either \\(H \\subseteq K\\) or \\(K \\subseteq H\\).\n"; 
$pf = "To show that \\(H \\cup K \\leq G\\) implies \\(H \\subseteq K\\) or \\(K \\subseteq H\\), it suffices to show the contrapositive.\n" . 
    "Assume it is not the case that \\(H \\subseteq K\\) or \\(K \\subseteq H\\).\n" . 
    "Then there exist elements of \\(H \\cup K\\), \\(x \\in H\\) and \\(y \\in K\\)  such that \\(x,y \\not \\in H \\cap K\\).\n" . 
    #"In order for \\(H \\cup K\\) to be a subgroup of \\(G\\) the set must be closed under multiplication.\n" . 
    #"It then follows that at least one of \\(xy \\in H\\) or \\(xy \\in K\\) must hold.\n" . 
    #"Suppose \\(xy \\in H\\).  
    #"Note then that \\[x^{-1}(xy) = y \\not \\in H\\]  implies \\(xy \\not \\in H\\).  Furthermore,  \\[(xy)y^{-1} = x \\not \\in K\\] implies \\(xy \\not \\in K\\).\n" . 
    "Observe that \\[x^{-1}(xy) = y \\not \\in H \\qquad \\text{and} \\qquad (xy)y^{-1} = x \\not \\in K.\\]\n" .
    "Since \\(H\\) and \\(K\\) are both subgroups of \\(G\\), it follows that \\(xy \\not \\in H\\) and \\(xy \\not \\in K\\).\n" .
    "Hence \\(H \\cup K\\) is not closed under multiplication and thus it is not a subgroup of \\(G\\), as desired.\n\n" . 
    #"Therefore \\(H \\cup K \\leq G\\) implies either \\(H \\subseteq K\\) or \\(K \\subseteq H\\).\n\n" . 
    "Conversely, it suffices to assume that \\(H \\subseteq K\\).\n" . 
    "Then, by definition, for any \\(x,y \\in H \\cup K\\), \\(x,y \\in K\\).\n" . 
    "Since \\(K\\) is a subgroup of \\(G\\), \\(H \\cup K\\) is closed under multiplication and under inverses.  Hence \\(H \\cup K\\) is a subgroup of \\(G\\).\n" . 
    "Therefore, \\(H \\cup K\\) is a subgroup of \\(G\\) if and only if either \\(H \\subseteq K\\) or \\(K \\subseteq H\\).";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
