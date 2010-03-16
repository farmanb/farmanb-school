#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("amssymb","amsmath","latexsym","graphicx","enumerate", "color");

my ($course, $hw) = (237, 6);
my ($author,
    $title) = ("Blake Farman", "$course: Homework $hw");

my ($beq, $eeq) = ("\\begin{eqnarray*}", "\\end{eqnarray*}");
my ($bar, $ear) = ("\\begin{array}", "\\end{array}");

my ($partA, $partB, $partC) = (ptex::subsubsection("a"), 
			       ptex::subsubsection("b"),
			       ptex::subsubsection("c"));
my ($p2, $p4, $p6, $p12) =(ptex::subsection(2),
			   ptex::subsection(4),
			   ptex::subsection(6),
			   ptex::subsection(12));

my $otherArgs = "\\sloppy\n"."\\definecolor{lightgray}{gray}{0.5}\n" ."\\setlength{\\parindent}{0pt}\n";
print ptex::preamble($documentClass, \@docClassArgs, \@texPackages, $author, $title, 1, $otherArgs);


print ptex::section("4.1");
print $p2 .
    $partA;

my $A = ptex::printMatrix([[1,1,0],[0,1,1],[1,2,1],[1,0,1]], "ccc");
my $AT = ptex::printMatrix([[1,0,1,1], [1,1,2,0],[0,1,1,1]], "cccc");
my $ATA = ptex::printMatrix([[3,3,2], [3,6,3], [2,3,3]], "ccc");
my $b = ptex::printMatrix([[2],[2],[3],[4]], "c");
my $ATb = ptex::printMatrix([[9],[10],[9]], "c");
my $xc = ptex::printMatrix([[2],[ptex::frac(-1,3)], [2]], "c");
my $r = ptex::printMatrix([[ptex::frac(1,3)], [ptex::frac(1,3)], [ptex::frac(-1,3)], [0]], "c");
my $se = ptex::frac(1,3);
my $rmse = ptex::frac(ptex::sqrt(3), 6);

print ptex::math("A^{T}A=$AT$A=$ATA") .
    ptex::math("A^{T}b= $AT$b = $ATb") .
    ptex::math("x_{c} = $xc") .
    ptex::math("r = $b-$A$xc = $r") .
    ptex::math("SE = $se") .
    ptex::math("RMSE = $rmse");


print $partB;

$A = ptex::printMatrix([[1,0,1], [1,0,2], [1,1,1],[2,1,1]], "cccc");
$AT = ptex::printMatrix([[1,1,1,2], [0,0,1,1], [1,2,1,1]], "cccc");
$ATA = ptex::printMatrix([[7,3,6], [3,2,2], [6,2,7]], "ccc");
$b = ptex::printMatrix([[2],[3],[1],[2]], "c");
$ATb = ptex::printMatrix([[10],[3],[11]], "c");
$xc = ptex::printMatrix([[1],[-1], [1]], "c");
$r = ptex::printMatrix([[0],[0],[0],[0]], "c");
$se = 0;
$rmse = 0;

print ptex::math("A^{T}A=$AT$A=$ATA") .
    ptex::math("A^{T}b= $AT$b = $ATb") .
    ptex::math("x_{c} = $xc") .
    ptex::math("r = $b-$A$xc = $r") .
    ptex::math("SE = $se") .
    ptex::math("RMSE = $rmse");

print $p4;

$b = ptex::printMatrix([["b_1"], ["b_2"], ["\\vdots"], ["b_m"]], "c");
$ATb = ptex::printMatrix([["b_1"], ["b_2"], ["\\vdots"], ["b_n"]], "c");
$r = ptex::printMatrix([[0], ["\\vdots"], [0], ["b_{n+1}"], ["\\vdots"], ["b_m"]], "c");
$A = ptex::printMatrix([[1,"\\cdots", 0],[0,"\\ddots", 0], ["\\vdots", "", 1], [0, "\\cdots", 0]], "ccc");
print "A is m by n, \\(m \\geq n\\). Each column of A is \\(e_{i}\\) for \\(\\mathbb{R}^{m}\\), so \\(A^{T}A\\) is \\(I\\) for \\(\\mathbb{R}^{n}\\).\\\\\n" .
    "Then, \\(A^{T}b\\) is\n" .  
    ptex::math($ATb) .
    "\nfor b an \\(m \\times 1\\) vector.  Then, \\(A^{T}Ax = x = b\\).\n" . 
    ptex::math(" \\Rightarrow r = $b - $A$ATb = $r") .
    ptex::math("\\left|r\\right| = \\sqrt(b_{n+1}^{2} + \\cdots + b_m^2)");
print $p12;

$A = ptex::printMatrix([[1,0,0], [1,0,1], [1,1,0], [1,1,1], [1,1,2]], "ccc");
$AT = ptex::printMatrix([[1,1,1,1,1,], [0,0,1,1,1], [0,1,0,0,1]], "ccccc");
$ATA = ptex::printMatrix([[5,3,4], [3,3,3], [4,3,6]], "ccc");
$b = ptex::printMatrix([[3], [2], [3], [5], [6]], "c");
$ATb = ptex::printMatrix([[19],[14],[19]], "c");
$xc = ptex::printMatrix([[2], [ptex::frac(5,3)], [1]], "c");

print ptex::math("A^{T}A=$AT$A=$ATA") .
    ptex::math("A^{T}b= $AT$b = $ATb") .
    ptex::math("x_{c} = $xc") .
    ptex::math("z = 2 + " . ptex::frac(5,3) . "x + y");
print ptex::section("4.2");

print $p2;
my $F3 = ptex::printMatrix([[1,1,0], 
			    [1, ptex::frac(1,2), ptex::frac(ptex::sqrt(3),2)],
			    [1, ptex::frac(-1,2), ptex::frac(ptex::sqrt(3),2)], 
			    [1, -1, 0], 
			    [1, ptex::frac(-1,2), ptex::frac("-" . ptex::sqrt(3),2)],
			    [1, ptex::frac(1,2), ptex::frac("-" . ptex::sqrt(3),2)]], "ccc");
my $F4 = ptex::printMatrix([[1,1,0,1], 
			    [1, ptex::frac(1,2), ptex::frac(ptex::sqrt(3),2),ptex::frac(-1,2)],
			    [1, ptex::frac(-1,2), ptex::frac(ptex::sqrt(3),2),ptex::frac(-1,2)], 
			    [1, -1, 0, 1], 
			    [1, ptex::frac(-1,2), ptex::frac("-" . ptex::sqrt(3),2), ptex::frac(-1,2)],
			    [1, ptex::frac(1,2), ptex::frac("-" . ptex::sqrt(3),2), ptex::frac(-1,2)]], "cccc");
my $F3T = ptex::printMatrix([[1,1,1,1,1,1],
			     [1, ptex::frac(1,2), ptex::frac(-1,2), -1, ptex::frac(-1,2),ptex::frac(1,2)],
			     [0, ptex::frac(ptex::sqrt(3), 2), ptex::frac(ptex::sqrt(3), 2), 0, ptex::frac("-" . ptex::sqrt(3), 2), ptex::frac("-" .ptex::sqrt(3), 2)]], "cccccc");
my $F4T = ptex::printMatrix([[1,1,1,1,1,1],
			     [1, ptex::frac(1,2), ptex::frac(-1,2), -1, ptex::frac(-1,2),ptex::frac(1,2)],
			     [0, ptex::frac(ptex::sqrt(3), 2), ptex::frac(ptex::sqrt(3), 2), 0, ptex::frac("-" . ptex::sqrt(3), 2), ptex::frac("-" .ptex::sqrt(3), 2)],
			     [1, ptex::frac(-1,2), ptex::frac(-1,2), 1, ptex::frac(-1,2), ptex::frac(-1,2)]], "cccccc");
my $F3TF3 = ptex::printMatrix([[6,0,0], [0,3,0], [0,0,3]], "ccc");
my $F4TF4 = ptex::printMatrix([[6,0,0,0], [0,3,0,0], [0,0,3,0], [0,0,0,3]], "cccc");

print ptex::math("$F3T$F3=$F3TF3");
print ptex::math("$F4T$F4=$F4TF4");

print $partA;
$b = ptex::printMatrix([[0],[2], [0], [-1], [1] ,[1]], "c");
my $F3Tb = ptex::printMatrix([[3],[2],[0]], "c");
my $F4Tb = ptex::printMatrix([[3],[2],[0],[-3]], "c");
$xc = ptex::printMatrix([[ptex::frac(1,2)], [ptex::frac(2,3)], [0]], "c");

my $F3xc = ptex::frac(1,6) . ptex::printMatrix([[7],[5],[1],[-1],[1],[5]], "c");
my $F4xc = ptex::frac(1,6) . ptex::printMatrix([[1],[8],[4],[-7],[4],[8]], "c");

$r = ptex::frac(1,6) . ptex::printMatrix([[-7], [7], [-1], [-5], [5], [1]], "c");

my $r1 = ptex::math("r = $b - $F3$xc = $b - $F3xc = $r");
print ptex::math("$F3T$b = $F3Tb") . "\n";
print ptex::math("$F3TF3$xc=$F3Tb") . "\n";

print ptex::math("$F4T$b = $F4Tb") . "\n";
$xc = ptex::printMatrix([[ptex::frac(1,2)], [ptex::frac(2,3)], [0], [-1]], "c");
$r = ptex::frac(1,6) . ptex::printMatrix([[-1], [4], [-4], [1], [2], [-2]], "c");
my $r2 = ptex::math("r = $b - $F4$xc = $b - $F4xc = $r");

print ptex::math("$F4TF4$xc=$F4Tb") ."\n" ;

print ptex::math("F_3 = " . ptex::frac(1,2) . " + " . ptex::frac(2,3) . "\\cos(2\\pi t)\n") . "\n";
print ptex::math("F_4 = " . ptex::frac(1,2) . " + " . ptex::frac(2,3) . "\\cos(2\\pi t) - \\cos(4\\pi t)\n") . "\n";

print "$r1\n" .
    ptex::math("\\left| r \\right| = " . ptex::frac("5" . ptex::sqrt(6), 6)) .
    "$r2\n" .
    ptex::math("\\left| r \\right| = " . ptex::sqrt(ptex::frac(7,6)));

print $partB;

$b = ptex::printMatrix([[4],[2],[0],[-5],[-1],[3]], "c");
$F3Tb = ptex::printMatrix([[3], [12], [0]], "c");
$F4Tb = ptex::printMatrix([[3], [12], [0], [-3]], "c");
$xc = ptex::printMatrix([[ptex::frac(1,2)],[4],[0]], "c");

$F3xc = ptex::frac(1,2) . ptex::printMatrix([[9], [5], [-3], [-7], [-3], [5]], "c");
$F4xc = ptex::frac(1,2) . ptex::printMatrix([[3], [8], [0], [-13], [0], [8]], "c");

$r = ptex::frac(1,2) . ptex::printMatrix([[-1], [-1], [3], [-3], [1], [1]], "c");
$r1 = ptex::math("r = $b - $F3$xc = $b - $F3xc = $r");

print ptex::math("$F3T$b = $F3Tb");
print ptex::math("$F4T$b = $F4Tb");

print ptex::math("$F3TF3$xc=$F3Tb");

$xc = ptex::printMatrix([[ptex::frac(1,2)],[4],[0],[-1]], "c");
$r = ptex::frac(1,2) . ptex::printMatrix([[5], [-4], [0], [3], [-2], [-2]], "c");
$r2 = ptex::math("r = $b - $F4$xc = $b - $F4xc = $r");
print ptex::math("$F4TF4$xc=$F4Tb");

print ptex::math("F_3 = " . ptex::frac(1,2) . " + 4\\cos(2\\pi t)\n") . "\n";
print ptex::math("F_4 = " . ptex::frac(1,2) . " + 4\\cos(2\\pi t) - \\cos(4\\pi t)\n") . "\n";

print "$r1\n" .
    ptex::math("\\left| r \\right| = " . ptex::sqrt(ptex::frac(11,2))) . "\n" .
    "$r2\n" .
    ptex::math("\\left| r \\right| = " . ptex::sqrt(ptex::frac(29,2))) . "\n";

print $p4;
print $partA;

$A = ptex::printMatrix([[1, -2],[1, -1],[1,1],[1,2]], "cc");
$AT = ptex::printMatrix([[1,1,1,1], [-2,-1,1,2]], "cccc");
$ATA = ptex::printMatrix([[4,0],[0,1]], "cc");
$b = ptex::printMatrix([["\\log(4)"], ["\\log(2)"], [0], ["\\log(" .ptex::frac(1,2) . ")"]], "c");
$ATb = ptex::printMatrix([["\\log(4) + \\log(2) + \\log(".ptex::frac(1,2) . ")"], ["-2\\log(4) - \\log(2) + 2\\log(" . ptex::frac(1,2) .")"]], "cc");

print ptex::math("$AT$A = $ATA");
print ptex::math("$AT$b = $ATb");
print ptex::math("c_1 = e^{k} = e^{" . ptex::frac(1,4) . " (\\log(4) + \\log(2) + \\log(" . ptex::frac(1,2) ."))} = \\sqrt(2)");
print ptex::math("c_2 = " . ptex::frac(1,10) . "(2(\\log(" . ptex::frac(1,2) .") - \\log(4)) - \\log(2)) =" . ptex::frac(1,10) . "(2\\log(" . ptex::frac(1,8) . ") - \\log(2))");
print ptex::math("= " . ptex::frac(1,10) . "(\\log(" . ptex::frac(1,64) . ") - \\log(2)) = " . ptex::frac(1,10) . "(\\log(" . ptex::frac(1,"2^7") .  "))");
print ptex::math("\\Rightarrow c_2 = \\log(" . ptex::frac(1, "2^{" . ptex::frac(7,10) ." }") .")");


print $partB;
$A = ptex::printMatrix([[1,0], [1,1], [1,2], [1,3]], "cc");
$AT = ptex::printMatrix([[1,1,1,1], [0,1,2,3]], "cccc");
$ATA = ptex::printMatrix([[4,6],[6,14]], "cc");
$b = ptex::printMatrix([["\\log(10)"], ["\\log(5)"], ["\\log(2)"], [0]], "c");
$ATb = ptex::printMatrix([["\\log(100)"], ["\\log(20)"]], "cc");

print ptex::math("$AT$A = $ATA");
print ptex::math("$AT$b = $ATb");

print ptex::math("c_2 =" . ptex::frac(-3,10) . ptex::log(100) . "-" . ptex::log(ptex::exp(20, ptex::frac(2,3))) . "=" .
		 ptex::log(ptex::exp(2,ptex::frac(-1,5)) . ptex::exp(5, ptex::frac(-2,5))));

print ptex::math("6k + 14c_2 = " . ptex::log(ptex::exp(2,2) . "5"));
print ptex::math("k = " . ptex::frac(1,6) . ptex::parens(ptex::log(ptex::exp(2,2) . "5") . "-" . "14" .ptex::log(ptex::exp(2,ptex::frac(-1,5)) . ptex::exp(5, ptex::frac(-2,5)))));
print ptex::math("\\Rightarrow k = " . ptex::log(ptex::exp(2,ptex::frac(4,5)) . ptex::exp(5,ptex::frac(11,10))));
print ptex::math("\\Rightarrow c_1 =" . ptex::exp(2,ptex::frac(4,5)) . ptex::exp(5,ptex::frac(11,10)));

print $p6;
print $partA;
$A = ptex::printMatrix([[1,1],[1,2], [1,3], [1,4]], "cc");
$AT = ptex::printMatrix([[1,1,1,1], [1,2,3,4]], "cccc");
$ATA = ptex::printMatrix([[4,10],[10,30]], "cc");
$b = ptex::printMatrix([[ptex::log(3)], [ptex::log(2)], [ptex::log(ptex::frac(5,3))], [ptex::log(ptex::frac(5,4))]], "c");
$ATb = ptex::printMatrix([[ptex::log(ptex::frac(ptex::exp(5,2),2))], [ptex::log(ptex::exp(5,7) . ptex::exp(ptex::parens(ptex::frac(1,3)),2) . ptex::exp(ptex::parens(ptex::frac(1,2)),6))]], "cc");

print ptex::math("$AT$A = $ATA");
print ptex::math("$AT$b = $ATb");

print ptex::math("-2k = " . ptex::log(ptex::frac(ptex::exp(5,2),2)) . "-" . ptex::frac(2,5) . ptex::log(ptex::exp(5,7) . ptex::exp(ptex::parens(ptex::frac(1,3)),2) . ptex::exp(ptex::parens(ptex::frac(1,2)),6)));
print ptex::math("\\Rightarrow k = " . ptex::frac(-1,2) . ptex::parens(ptex::log(ptex::frac(ptex::exp(5,2),2)) . "-" . ptex::frac(2,5) . ptex::log(ptex::exp(5,7) . ptex::exp(ptex::parens(ptex::frac(1,3)),2) . ptex::exp(ptex::parens(ptex::frac(1,2)),6))));
print ptex::math(" = " . ptex::log(
		     ptex::frac(ptex::exp(5,ptex::frac(2,5)),
				ptex::exp(ptex::parens(3), ptex::frac(2,5)) . 
				ptex::exp(ptex::parens(2), ptex::frac(7,10)))));
print ptex::math("c_1 =". ptex::exp("k") . "=" .  ptex::frac(ptex::exp(5,ptex::frac(2,5)),
							     ptex::exp(ptex::parens(3), ptex::frac(2,5)) . 
							     ptex::exp(ptex::parens(2), ptex::frac(7,10))));

print ptex::math("10c_2 + 30" . ptex::log(
		     ptex::frac(ptex::exp(5,ptex::frac(2,5)),
				ptex::exp(ptex::parens(3), ptex::frac(2,5)) . 
				ptex::exp(ptex::parens(2), ptex::frac(7,10)))) . "=" . ptex::log(ptex::exp(5,7) . ptex::exp(ptex::parens(ptex::frac(1,3)),2) . ptex::exp(ptex::parens(ptex::frac(1,2)),6)));
print ptex::math("\\Rightarrow c_2 =" . 
		 ptex::frac(1,10) . 
		 ptex::parens(ptex::log(ptex::exp(5,7) .
					ptex::exp(ptex::parens(ptex::frac(1,3)),2) . 
					ptex::exp(ptex::parens(ptex::frac(1,2)),6)) .
			      "- 30" . ptex::log(ptex::frac(ptex::exp(5,ptex::frac(2,5)),
							    ptex::exp(ptex::parens(3), ptex::frac(2,5)) . 
							    ptex::exp(ptex::parens(2), ptex::frac(7,10))))));

print ptex::math("=" . 
		 ptex::frac(1,10) . 
		 ptex::parens(ptex::log(ptex::exp(5,7) .
					ptex::exp(ptex::parens(ptex::frac(1,3)),2) . 
					ptex::exp(ptex::parens(ptex::frac(1,2)),6)) . 
			      "- 6" . ptex::log(ptex::frac(ptex::exp(5,2),
							   ptex::exp(ptex::parens(3), 2) . 
							   ptex::exp(ptex::parens(2), ptex::frac(7,2))))));

print ptex::math("=" . 
		 ptex::frac(1,10) . 
		 ptex::parens(ptex::log(ptex::exp(5,7) .
					ptex::exp(ptex::parens(ptex::frac(1,3)),2) . 
					ptex::exp(ptex::parens(ptex::frac(1,2)),6)) . 
			      "-" . ptex::log(ptex::frac(ptex::exp(5,12),
							 ptex::exp(ptex::parens(3), 12) . 
							 ptex::exp(ptex::parens(2), 21)))));
print ptex::math("=" .
		 ptex::frac(1,10) .
		 ptex::parens(ptex::log(ptex::frac(ptex::exp(5,7),ptex::exp(5,12)) .
					ptex::frac(ptex::exp(3,12), ptex::exp(3,2)) .
					ptex::frac(ptex::exp(2,21), ptex::exp(2,6)))));

print ptex::math("=" .
		 ptex::frac(1,10) .
		 ptex::parens(ptex::log(ptex::frac(ptex::exp(3,10) .
						   ptex::exp(2,15),
						   ptex::exp(5,5)))));

print ptex::math("\\Rightarrow c_2 = " . ptex::log(ptex::frac("3" . ptex::exp(ptex::parens(2), ptex::frac(3,2)), ptex::exp(5,ptex::frac(1,2)))));

print $partB;
$A = ptex::printMatrix([[1,1], [1,2], [1,3],[1,4]], "cc");
$AT = ptex::printMatrix([[1,1,1,1], [1,2,3,4]], "cccc");
$ATA = ptex::printMatrix([[4,10],[10,30]], "cc");
$b = ptex::printMatrix([[ptex::log(2)], [ptex::log(2)], [0], [ptex::log(ptex::frac(1,2))]], "c");
$ATb = ptex::printMatrix([[ptex::log(2)], [ptex::log(ptex::frac(1,2))]], "cc");

print ptex::math("$AT$A = $ATA");
print ptex::math("$AT$b = $ATb");

print ptex::math("-2k = " . ptex::log(ptex::frac(1,2))  ."-" . ptex::frac(2,5) . ptex::log(2) . 
		 "=" . ptex::log(ptex::frac(1,ptex::exp(2,ptex::frac(7,5)))));
print ptex::math("\\Rightarrow k = " . ptex::frac(-1,2) . ptex::log(ptex::frac(1,ptex::exp(2,ptex::frac(7,5)))) . "=" .
		 ptex::log(ptex::exp(2,ptex::frac(7,10))));

print ptex::math("10c_2 + 30" . ptex::log(ptex::exp(2,ptex::frac(7,10))) . "=" . ptex::log(2));
print ptex::math("\\Rightarrow c_2 =" . ptex::frac(1,10) . ptex::parens(ptex::log(2) . "-" . "30" . ptex::log(ptex::exp(2,ptex::frac(7,10)))) . "=" .
		 ptex::frac(1,10) . ptex::log(ptex::frac(1,ptex::exp(2,20))));
print ptex::math("\\Rightarrow c_2 =" . ptex::log(ptex::frac(1,4)));

print ptex::section("4.3");

print $p2;
print $partA;

my ($v1, $v2, $v3, $y1, $y2, $y3, $q1, $q2, $q3);
my ($r11, $r12, $r22);
my ($Q, $R, $q1q1T, $q2q2T);

($r11, $r12, $r22) = (3,6,3);
$A = ptex::printMatrix([[2,3], [-2,-6], [1,0]], "cc");
$q1 = ptex::printMatrix([[ptex::frac(2,3)],[ptex::frac(-2,3)], [ptex::frac(1,3)]], "c");
$q2 = ptex::printMatrix([[ptex::frac(-1,3)], [ptex::frac(-2,3)], [ptex::frac(-2,3)]], "c");
$q3 = ptex::printMatrix([[ptex::frac(2,3)],[ptex::frac(1,3)],[ptex::frac(-2,3)]], "c");

$Q = ptex::frac(1,3) . ptex::printMatrix([[2,-1,2],[-2,-2,1],[1,-2,-2]],"ccc");
$R = ptex::printMatrix([[$r11, $r12], [0,$r22], [0,0]], "cc");

$q1q1T = ptex::frac(1,9) . ptex::printMatrix([[4,-4,2],[-4,4,-2],[2,-2,1]], "ccc");
$q2q2T = ptex::frac(1,9) . ptex::printMatrix([[1,2,2],[2,4,4],[2,4,4]], "ccc");

$v1 = ptex::printMatrix([[2],[-2],[1]], "c");
$v2 = ptex::printMatrix([[3],[-6],[0]], "c");
$v3 = ptex::printMatrix([[1],[0],[0]], "c");


$y1 = "$v1";
$y2 = "$v2  -  $q1q1T  $v2";
$y3 = "$v3 - $q1q1T $v3 - $q2q2T $v3";
print ptex::math("$A");

print ptex::math("y1 = $y1");
print ptex::math("q1 = $q1");
print ptex::math("y2 = $y2");
print ptex::math("q2 = $q2");
print ptex::math("y3 = $y3");
print ptex::math("q3 = $q3");

print ptex::math("$A = $Q$R");

print $partB;

($r11, $r12, $r22) = (6,-3,9);
$A = ptex::printMatrix([[-4,-4],[-2,7],[4,-5]], "cc");
$q1 = ptex::frac(1,3) . ptex::printMatrix([[-2], [-1], [2]], "c");
$q2 = ptex::frac(1,3) . ptex::printMatrix([[-2],[2],[-1]], "c");
$q3 = ptex::frac(1,9) . ptex::printMatrix([[1],[2],[2]], "c");

$Q = ptex::frac(1,9) . ptex::printMatrix([[-6,-6,1],[-3,6,2],[6,-3,2]],"ccc");
$R = ptex::printMatrix([[$r11, $r12], [0,$r22], [0,0]], "cc");

$q1q1T = ptex::frac(1,9) . ptex::printMatrix([[4,2,-4],[2,1,-2],[-4,-2,4]], "ccc");
$q2q2T = ptex::frac(1,9) . ptex::printMatrix([[4,-4,2],[-4,4,-2],[2,-2,1]], "ccc");

$v1 = ptex::printMatrix([[-4],[-2],[4]], "c");
$v2 = ptex::printMatrix([[-4],[7],[-5]], "c");
$v3 = ptex::printMatrix([[1],[0],[0]], "c");


$y1 = "$v1";
$y2 = "$v2  -  $q1q1T  $v2";
$y3 = "$v3 - $q1q1T $v3 - $q2q2T $v3";
print ptex::math("$A");

print ptex::math("y1 = $y1");
print ptex::math("q1 = $q1");
print ptex::math("y2 = $y2");
print ptex::math("q2 = $q2");
print ptex::math("y3 = $y3");
print ptex::math("q3 = $q3");

print ptex::math("$A = $Q$R");

print $p6;
print $partA;

print "\\begin{verbatim}" .
    "clear". "\n" .
    "P = @(v) v*v'/(v'*v);". "\n" .
    "\n" .
    "A = [1 4;-1 1;1 1;1 0];". "\n" .
    "b = [3 1 1 -3]';". "\n" .
    "[m,n] = size(A);". "\n" .
    "\n" .
    "x = A(:,1);". "\n" .
    "\n" .
    "%Get the opposite sign of the first component of X.". "\n" .
    "sign = -1 * x(1) / norm(x(1));". "\n" .
    "\n" .
    "w = zeros(size(x));". "\n" .
    "w(1) = sign*norm(x);". "\n" .
    "\n" .
    "v = w - x;". "\n" .
    "\n" .
    "H1 = eye(size(P(v))) - 2*P(v);". "\n" .
    "\n" .
    "temp = H1*A;". "\n" .
    "\n" .
    "x = temp(2:m,2);". "\n" .
    "\n" .
    "w = zeros(size(x));". "\n" .
    "w(1) = norm(x);". "\n" .
    "\n" .
    "v = w - x;". "\n" .
    "temp = eye(size(P(v))) - 2*P(v);". "\n" .
    "H2 = [1 0 0 0;". "\n" .
    "    0 temp(1,1:3);". "\n" .
    "    0 temp(2,1:3);". "\n" .
    "    0 temp(3,1:3);];". "\n" .
    "\n" .
    "R = H2*H1*A". "\n" .
    "Q = H1*H2". "\n" .

    "d = Q'*b;". "\n" .

    "x = R\\d". "\n" .

    "error = norm(b-A*x)". "\n" .
    "\\end{verbatim}". "\n" .
    "\n" .
    "        \\color{lightgray} \\begin{verbatim}". "\n" .
    "R =\n" .
    "\n" .
    "   -2.0000   -2.0000\n" .
    "    0.0000    3.7417\n" .
    "         0    0.0000\n" .
    "         0    0.0000\n" .
    "\n" .
    "\n" .
    "Q =\n" .
    "\n" .
    "   -0.5000    0.8018   -0.0931    0.3138\n" .
    "    0.5000    0.5345   -0.2362   -0.6391\n" .
    "   -0.5000    0.0000    0.6086   -0.6161\n" .
    "   -0.5000   -0.2673   -0.7517   -0.3368\n" .
    "x =". "\n" .
    "\n" .
    "   -1.0000". "\n" .
    "    1.0000". "\n" .
    "\n" .
    "\n" .
    "error =". "\n" .
    "\n" .
    "    2.4495". "\n" .
    "\n" .
    "\\end{verbatim} \\color{black}" . "\n";

print $partB . "\n";

print "\\begin{verbatim}" . "\n" .
    "clear\n".
    "P = @(v) v*v'/(v'*v);\n".
    "\n".
    "A = [2 4; 0 -1; 2 -1; 1 3];\n".
    "b = [-1 3 2 1]';\n".
    "[m,n] = size(A);\n".
    "\n".
    "x = A(:,1);\n".
    "\n".
    "%Get the opposite sign of the first component of X.\n".
    "sign = -1 * x(1) / norm(x(1));\n".
    "\n".
    "w = zeros(size(x));\n".
    "w(1) = sign*norm(x);\n".
    "\n".
    "v = w - x;\n".
    "\n".
    "H1 = eye(size(P(v))) - 2*P(v);\n".
    "\n".
    "temp = H1*A;\n".
    "\n".
    "x = temp(2:m,2);\n".
    "\n".
    "w = zeros(size(x));\n".
    "w(1) = norm(x);\n".
    "\n".
    "v = w - x;\n".
    "temp = eye(size(P(v))) - 2*P(v);\n".
    "H2 = [1 0 0 0;\n".
    "    0 temp(1,1:3);\n".
    "    0 temp(2,1:3);\n".
    "    0 temp(3,1:3);];\n".
    "\n".
    "R = H2*H1*A\n".
    "Q = H1*H2\n".
    "\n".
    "d = Q'*b;\n".
    "\n".
    "x = R\\d \n".
    "\n".
    "error = norm(b-A*x)\n".
    "\\end{verbatim}\n".
    "\n".
    "        \\color{lightgray} \\begin{verbatim}\n".
    "R =\n".
    "\n".
    "   -3.0000   -3.0000\n".
    "   -0.0000    4.2426\n".
    "    0.0000   -0.0000\n".
    "    0.0000    0.0000\n".
    "\n".
    "\n".
    "Q =\n".
    "\n".
    "   -0.6667    0.4714   -0.3250   -0.4772\n".
    "         0   -0.2357   -0.8957    0.3771\n".
    "   -0.6667   -0.7071    0.2208    0.0825\n".
    "   -0.3333    0.4714    0.2084    0.7895\n".
    "\n".
    "\n".
    "x =\n".
    "\n".
    "    0.8333\n".
    "   -0.5000\n".
    "\n".
    "\n".
    "error =\n".
    "\n".
    "    3.0822\n".
    "\n" .
    "\\end{verbatim} \\color{black}\n";

print "\\end{document}\n";
