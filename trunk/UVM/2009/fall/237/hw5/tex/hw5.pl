#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("amssymb","amsmath","latexsym","graphicx","enumerate", "color");

my ($course, $hw) = (237, 5);
my ($author,
    $title) = ("Blake Farman", "$course: Homework $hw");

my ($beq, $eeq) = ("\\begin{eqnarray*}", "\\end{eqnarray*}");
my ($bar, $ear) = ("\\begin{array}", "\\end{array}");

my $otherArgs = "\\sloppy\n"."\\definecolor{lightgray}{gray}{0.5}\n" ."\\setlength{\\parindent}{0pt}\n";
print ptex::preamble($documentClass, \@docClassArgs, \@texPackages, $author, $title, 1, $otherArgs);

print "\\section*{6.3}\n" .
    "\\subsection*{3}\n" .
    "\\subsubsection*{a)}\n" .
    ptex::math("y^{''} = ty") . "\n" .
    ptex::math("y_1 = y") . "\n" .
    ptex::math("y_2 = y^{'}") . "\n" .
    ptex::math("y_1^{'} = y_2") . "\n" .
    ptex::math("y_2^{'} = ty") . "\n" .
    "\\subsubsection*{b)}\n" .
    ptex::math("y^{''} = 2ty^{'} -2y") . "\n" .
    ptex::math("y_1 = y") . "\n" .
    ptex::math("y_2 = y^{'}") . "\n" .
    ptex::math("y_1^{'} = y_2") . "\n" .
    ptex::math("y_2^{'} = 2ty_2 - 2y_1") . "\n" .
    "\\subsubsection*{c)}\n" .
    ptex::math("y^{''} = ty^{'} + y") . "\n" .
    ptex::math("y_1 = y") . "\n" .
    ptex::math("y_2 = y^{'}") . "\n" .
    ptex::math("y_1^{'} = y_2") . "\n" .
    ptex::math("y_2^{'} = ty_2+y_1") . "\n" .
    "\\newpage\n" .
    "\\section*{6.6}\n" .
    "\\subsection*{2}\n" .
    "\\subsubsection*{a)}\n" .
    ptex::math("y^{'} = y - y^{2}") . "\n" .
    "Fixed points at y = 0,1.  0 is unstable, 1 is stable.\n" .
    ptex::math("f_{y} = 1 - 2y") . "\n" .
    ptex::math("f_{y}(0) = 1") . "\n" .
    ptex::math("f_{y}(1) = -1") . "\n" .
    "Assuming -1 is small, then not stiff.\n" .
    "\\subsubsection*{b)}\n" .
    ptex::math("y^{'} = 10(y -y^{2})") . "\n" .
    "Fixed points at y = 0,1.  0 is unstable, 1 is stable.\n" .
    ptex::math("f_{y} = 10(1 - 2y)") . "\n" .
    ptex::math("f_{y}(0) = 10") . "\n" .
    ptex::math("f_{y}(1) = -10") . "\n" .
    "Stiff.\n" .
    "\\subsubsection*{c)}\n" .
    ptex::math("y^{'} = -10\\sin(y)") . "\n" .
    "Fixed points at " . 
    ptex::inlineMath("y = 2n\\pi") . 
    " and " . 
    ptex::inlineMath("y = (2n+1)\\pi, \\forall n \\in \\mathbb{Z}") . "\\\\\n" .
    ptex::inlineMath("y = 2n\\pi") . " stable, " . ptex::inlineMath("\\forall n \\in \\mathbb{Z}") . "\\\\\n" .
    ptex::inlineMath("y = (2n+1)\\pi") . " unstable, " . ptex::inlineMath("\\forall n \\in \\mathbb{Z}") ."\\\\\n" .
    ptex::math("f_{y} = -10cos(y)") . "\n" .
    ptex::math("y = 2n\\pi \\Rightarrow f_{y} = -10, \\forall n \\in \\mathbb{Z}") . "\n" .
    ptex::math("y = (2n+1)\\pi \\Rightarrow f_{y} = 10, \\forall n \\in \\mathbb{Z} ") . "\n" .
    "Stiff.\n" .
    "\\newpage\n";
print "1)\n";
my $M = ptex::printMatrix([[2, "c"],["c",1]], "cc");
my $theta = ptex::printMatrix([["\\theta_{1}^{'}"],["\\theta_{2}^{'}"]], "c");
my $F = ptex::printMatrix([["-2\\sin(\\theta_{1} - s(\\theta_{2}^{'})^2"], ["-\\sin(\\theta_{2}) + s(\\theta_1^{'})^2"]], "c");

print ptex::math("$M$theta=$F");

print ptex::math("\\theta_1 = u_1") .
    ptex::math("\\theta_2 = u_2") .
    ptex::math(" \\theta_1^{'} = u_3") .
    ptex::math("\\theta_2^{'} = u_4");
$M = ptex::printMatrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 2 , "c"], [0, 0, "c", 1]], "cccc");
my $U = ptex::printMatrix([["u_1"], ["u_2"], ["u_3"], ["u_4"]], "c");
$F = ptex::printMatrix([["u_3"], ["u_4"], ["-2\\sin(\\theta_{1} - s(\\theta_{2}^{'})^2"], ["-\\sin(\\theta_{2}) + s(\\theta_1^{'})^2"]], "c");
print ptex::math("$M$U^{'}=$F");

print "2) The default initial condition results in semi-periodic motion.\\\\\n";
print "3) There is some sort of perturbation happening, which is most likely due to roundoff error in the calculations.\\\\\n";
print "\\newpage\n";
print "6) The stability plot is assymetric since there are multiple possibilities for the position of the second bob for symmetric positions of the first bob.\n";
print "\\end{document}\n";
