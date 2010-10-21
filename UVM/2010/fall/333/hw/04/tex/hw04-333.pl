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
    $course) = (4,
		"Math-333");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Monday, October 4, 2010",
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

my $name = "5"; 
my $thm = "Show that if a subset \\(E\\) of \\([0,1]\\) satisfies \\(\\lambda(E) = 1\\), then \\(E\\) is dense in \\([0,1]\\).\n";
my $pf = "The subset \\(E\\) is dense in \\([0,1]\\) if \\(\\overline{E} = [0,1]\\), where \\(\\overline{E}\\) is the set of all adherent points of \\(E\\).\n" . 
    "Hence it suffices to show that \\(\\lambda(E) = 1\\) implies \\(\\overline{E} = [0,1]\\).\n" . 
    "Then by Theorem 6.7, \\(\\overline{E}\\) is the intersection of all sets containing \\(E\\), from which it follows \\(\\overline{E} \\subseteq [0,1]\\).\n\n" . 
    "To see the reverse containment, suppose to the contrary that there exists an element \\(x\\) of \\([0,1]\\) such that \\(x\\) is not an element of \\(\\overline{E}\\).\n" . 
    "Then there exists some \\(\\varepsilon > 0\\) such that the intersection of the open \\(\\varepsilon\\)-neighborhood about \\(x\\), \\(V_{\\varepsilon}(x)\\), and \\(E\\) is empty.\n" . 
    "Consider that \\(V_{\\varepsilon}(x)\\) is a Borel set and thus \\(\\lambda^*\\)-measurable, so\n" . 
    $beq .
    ptex::printEqnArray([["\\lambda^*([0,1])", "\\lambda^*([0,1] \\cap V_{\\varepsilon}(x)) + \\lambda^*([0,1] \\cap V_{\\varepsilon}(x)^{c})"],
			["","\\lambda^*(V_{\\varepsilon}(x)) + \\lambda^*(E)"],
			["", "2\\varepsilon + 1"]], "=") .
    ptex::printEqnArray([["", "1."]], ">") .
    $eeq . 
    "However, this is a contradiction.\n" . 
    "Therefore, \\([0,1] \\subseteq \\overline{E}\\), thus completing the proof.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

#print "\\bibliographystyle{plain}" .
#    "\\bibliography{refs}";
print ptex::endDoc();
