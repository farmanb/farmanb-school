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
    $course) = (3, 
		"Math-333");

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
my $mb = "\\bar\\mu";

my $name = "1"; 
my $thm = "If \\(E\\) is a \\($mb\\)-measurable subset of \\(X\\), then show that for every \\(A \\subseteq X\\) we have \\[$mb(E \\cup A) + $mb(E \\cap A) = $mb(A) + $mb(A).\\]\n";
my $pf = "Observe that since \\(E\\) is \\($mb\\)-measurable\n" . 
    $beq .
    ptex::printEqnArray([["$mb(E \\cup A)", "$mb((E \\cup A) \\cap E) + $mb((E \\cup A) \\cap E^{c})"],
				    ["", "$mb(E) + $mb(A \\cap E^{c}),"]], "=") . 
    $eeq . 
    "and\n" . 
    "\\[$mb(A) = $mb(A \\cap E) + $mb(A \\cap E^{c}).\\]" .
    "Hence the desired equality follows directly" . 
    $beq .
    ptex::printEqnArray([["$mb(E \\cup A) + $mb(A \\cap E)", "$mb(E) + $mb(A \\cap E^{c}) + $mb(A \\cap E)"],
			 ["", "$mb(E) + $mb(A)."]], "=") . 
    $eeq;

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2"; 
$thm = "Show that a subset \\(E\\) of \\(X\\) is \\($mb\\)-measurable if and only if for each \\(\\varepsilon > 0\\)  there is a measurable set \\(F\\) such that \\(F \\subseteq E\\) and \\($mb(E \\setminus F) < \\varepsilon\\).";
$pf = "Suppose \\(E \\subseteq X\\) is \\($mb\\)-measurable.\n" . 
    "Let \\(\\varepsilon > 0\\) be given and take \\(F = E\\).\n" .
    "Then \\($mb(E \\setminus F) = 0 < \\varepsilon\\), as desired.\n\n" . 
    "Conversely, assume for each \\(\\varepsilon > 0\\) there exists a \\($mb\\)-measurable set \\(F\\) such that \\(F \\subseteq E\\) and \\($mb(E \\setminus F) < \\varepsilon\\).\n" . 
    "Observe that \\(E = F \\cup (E \\setminus F)\\) and \\(E^c \\subseteq F^c\\), so that by the sub-additivity of \\($mb\\)" . 
    $beq .
    ptex::printEqnArray([["$mb(A)", "$mb((A \\cap E) \\cup (A \\cap E^{c}))"]], "=") . 
    ptex::printEqnArray([["", "$mb(A \\cap E) + $mb(A \\cap E^{c})"]], "\\leq") . 
    ptex::printEqnArray([["", "$mb(A \\cap F) + $mb(A \\cap (F \\setminus E)) + $mb(A \\cap E^{c})"], 
			 ["", "$mb(A \\cap F) + $mb(F \\setminus E) + $mb(A \\cap F^{c})."]],"\\leq") .
    $eeq . 
    "Now, since \\(F\\) is \\($mb\\)-measurable \\[$mb(A \\cap F) + $mb(F \\setminus E) + $mb(A \\cap F^{c}) = $mb(A) + $mb(F \\setminus E),\\]\n" . 
    "so it follows that \\[$mb(A) \\leq $mb(A \\cap E) + $mb(A \\cap E^{c}) < $mb(A) + \\varepsilon.\\]\n" . 
    "Since this inequality holds for all \\(\\varepsilon > 0\\), \\($mb(A) = $mb(A \\cap E) + $mb(A \\cap E^{c})\\).\n" . 
    "Therefore \\(E\\) is \\($mb\\)-measurable by Theorem 14.2.";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "3"; 
$thm = "Let \\(X = \\{1,2,3,4\\}\\) and let \\(S = \\{\\emptyset,X,\\{1,2\\},\\{3,4\\}\\}\\).\\\\\n" . 
    "(a) Show that \\(S\\) is a \\(\\sigma\\)-algebra.\\\\\n" . 
    "(b) Let \\(\\mu : S \\rightarrow [0,\\infty]\\) by \\(\\mu(A) = |A|\\) for all \\(A \\in S\\).  Prove that \\(\\mu\\) is a measure on \\(S\\).\\\\\n" . 
    "(c) Let \\(\\mu^{*}\\) be the Carath\\\'eodory extension of \\(\\mu\\).  Find \\(\\mu^{*}(\\{1\\})\\) and \\(\\mu^{*}(\\{2,3,4\\})\\).  Deduce that \\(\\{1\\}\\) is not a \\(\\mu^{*}\\)-measurable set.\n";
$pf = "(a) Since \\(\\emptyset^c = X \\) and \\(\\{1,2\\}^c = \\{3,4\\} \\), \\(S\\) is closed under complements.\n\n" . 
    "Let \\(\\{A_i\\}_{i=1}^{\\infty} \\subseteq S\\) be given.\n" . 
    "Since \\(S\\) is a finite set, the union \\(\\bigcup_{i=1}^{\\infty} A_i\\) reduces, in all cases, to a finite union.\n" . 
    "Hence, to see \\(S\\) is closed under countable unions, it suffices to show \\(\\{1,2\\} \\cup \\{3,4\\} = X \\in S\\).\n\n" . 
    "Closure under intersections follows directly from closure under unions and complements.\n  Therefore, \\(S\\) is a \\(\\sigma\\)-algebra.\n\n" . 
    "(b) To see \\(\\mu\\) is a measure on \\(S\\), observe first \\(\\mu(\\emptyset) = 0\\).\n" . 
    "Now let \\(\\{A_i\\}_{i=1}^{\\infty} \\subseteq S\\) be a disjoint sequence satisfying \\(\\bigcup_{i=1}^{\\infty}A_i \\in S.\\)\n" . 
    "Since \\(\\{1,2\\}\\) and \\(\\{3,4\\}\\) are the only disjoint, non-empty elements of \\(S\\), in order to show additivity it suffices to show that \\[\\mu(\\{1,2\\} \\cup \\{3,4\\}) = 4 = \\mu(\\{1,2\\}) + \\mu(\\{3,4\\}).\\]" . 
    "Therefore, \\(\\mu\\) is a measure on \\(S\\).\n\n" . 
    "(c) The smallest possible covers of \\(\\{1\\} \\text{ and } \\{2,3,4\\}\\) are \\(\\{1,2\\}\\) and \\(X\\), respectively.\n" . 
    "Hence, \\[\\mu^{*}(\\{1\\}) = 2 \\quad \\text{and} \\quad \\mu^{*}(\\{2,3,4\\}) = 4.\\]\n" .
    "Now, to see \\(\\{1\\}\\) is not \\(\\mu^*\\)-measurable, consider\n" . 
    $beq .
    ptex::printEqnArray([["\\mu^{*}(X \\cap \\{1\\}) + \\mu^{*}(X \\cap \\{1\\}^c)", "\\mu^{*}(\\{1\\}) + \\mu^{*}(\\{2,3,4\\}"], 
			 ["", "6"]], "=") .
			 ptex::printEqnArray([["", "\\mu(X)."]], ">") . 
    $eeq . 
    "Therefore, by Theorem 15.2, \\(\\{1\\}\\) is not \\(\\mu^*\\)-measurable.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "4"; 
$thm = "Let \\(X\\) be an uncountable set and, as in Homework Set \\#2, let \\[S = \\{E \\subseteq X \\mid E or E^{c} \\text{ is finite or countable}\\},\\]" . 
    "\\[\\mu:S \\rightarrow [0,\\infty] \\qquad \\text{ by } \\qquad \\mu(E) = \\left\\{\n" .
    "\\begin{array}{ll}\n" . 
    "0 & \\text{if } E \\text{ is countable or finite,}\\\\ \n" .
    "1 & \\text{if } E \\text{ is uncountable}.\n" .
    "\\end{array}\n" .
    "\\right.\\]\n" . 
    "You may assume \\(S\\) is a \\(\\sigma\\)-algebra and \\(\\mu\\) is a measure on \\(S\\).  Let \\(\\mu^{*}\\) be the Carath\\'eodory extension of \\(\\mu\\).\\\\\n" . 
    "(a) Find the value of \\(\\mu^{*}(A)\\) for every subset \\(A\\) of \\(X\\).\\\\\n" . 
    "(b) Find all \\(\\mu^{*}\\)-measurable subsets of \\(X\\).\\\\\n";
$pf = "(a) Let \\(A \\subseteq X\\) be given.\n" . 
    "If \\(A \\in S\\), then \\(\\mu^*(A) = \\mu(A)\\) as in the previous homework, so assume \\(A \\not \\in S\\).\n" . 
    "Then \\(A\\) must necessarily be an uncountable set, which means \\(A\\) cannot possibly be covered by countable sets.\n" . 
    "So the smallest cover is necessarily the union of the fewest uncountable sets in which \\(A\\) is contained.\n" . 
    "Since all uncountable sets have the same measure, it suffices to choose \\(X\\) as a cover; so it must be the case that \\(\\mu^{*}(A) = 1\\).\n\n" . 
    "(b) From our work in class, \\(S \\subseteq \\Lambda_{\\mu*}\\).\n" . 
    "So consider any set \\(A \\not \\in S\\).\n" . 
    "Then both \\(A\\) and \\(A^c\\) are uncountable and by the argument above,\n" .
    $beq .
    ptex::printEqnArray([["\\mu^{*}(X \\cap A) + \\mu^{*}(X \\cap A^c)", "\\mu^{*}(A) + \\mu^{*}(A^c)"], 
			 ["", "\\mu(X) + \\mu(X)"]], "=") .
			 ptex::printEqnArray([["", "\\mu(X)."]], ">") . 
    $eeq . 
    "Hence, by Theorem 15.2, \\(A \\not \\in \\Lambda_{\\mu*}\\) for any \\(A \\not \\in S\\).\n  Therefore, \\(\\Lambda_{\\mu*} = S.\\)";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "5"; 
$thm = "Let \\(S = \\{[n,m) \\mid n,m \\in \\mathbb{Z} \\text{ with } n \\leq m\\}\\) and let\n". 
    "\\[\\mu : S \\rightarrow [0,\\infty) \\qquad \\text { by } \\qquad \\mu([n,m)) = m - n.\\]\n" . 
    "You may assume \\(S\\) is a semiring and \\(\\mu\\) is a measure on \\(S\\).  Let \\(\\mu^{*}\\) be the Carath\\'eodory extension of \\(\\mu\\) to an outer measure on all subsets of \\(\\mathbb{R}\\).\\\\\n" . 
    "(a) Find the value of \\(\\mu^{*}([a,b])\\) for every closed interval \\([a,b]\\) of \\(\\mathbb{R}\\).\\\\\n" . 
    "(b) Show that \\([0,1]\\) is not \\(\\mu^{*}-measurable\\).\\\\\n";
$pf = "(a) For any closed interval, the value of \\(\\mu^{*}([a,b])\\) is determined by \\(\\mu([m,n))\\), where \\([m,n)\\) is the smallest cover of \\([a,b]\\) with integer endpoints.\n" . 
    "For \\(b \\not \\in \\mathbb{Z}\\), \\([\\lfloor a \\rfloor, \\lceil b \\rceil )\\) is just such a cover.\n" . 
    "For \\(b \\in \\mathbb{Z}\\), \\([\\lfloor a \\rfloor, b+1 )\\) is the smallest cover, since \\(b\\) must be covered.\n" . 
    "Hence, \\[\\mu^*([a,b]) = \\left\\{" . 
    "\\begin{array}{ll}\n" . 
    "b+1-\\lfloor a \\rfloor & \\text{if } b \\in \\mathbb{Z},\\\\\n" .
    "\\lceil b \\rceil - \\lfloor a \\rfloor & \\text{if } b \\not \\in \\mathbb{Z}.\n" .
    "\\end{array}\n" .
    "\\right. \\]\n\n" . 
    "(b) To see that \\([0,1]\\) is not \\(\\mu^{*}\\)-measurable, consider the interval \\([0,2) \\in S\\).\n" . 
    $beq .
    ptex::printEqnArray([["\\mu^{*}([0,2) \\cap [0,1]) + \\mu^{*}([0,2) \\cap [0,1]^c)", "\\mu^{*}([0,1]) + \\mu^{*}((1,2))"], 
			 ["", "\\mu([0,2)) + \\mu([1,3))"]], "=") .
			 ptex::printEqnArray([["", "\\mu([0,2))."]], ">") . 
    $eeq . 
    "Therefore, by Theorem 15.2, \\([0,1]\\) is not \\(\\mu^{*}\\)-measurable.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));
#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
