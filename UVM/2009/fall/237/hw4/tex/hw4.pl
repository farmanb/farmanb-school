#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("amssymb","amsmath","latexsym","graphicx","enumerate");

my ($course, $hw) = (237, 3);
my ($author,
    $title) = ("Blake Farman", "$course: Homework $hw");

my ($beq, $eeq) = ("\\begin{eqnarray*}", "\\end{eqnarray*}");
my ($bar, $ear) = ("\\begin{array}", "\\end{array}");

print ptex::preamble($documentClass, \@docClassArgs, \@texPackages, $author, $title);

print "\\section*{2.2}\n" .
    "\\subsection*{4}\n" . 
    "\\subsubsection*{a)}\n";

my $A = ptex::printMatrix([[3,1,2],[6,3,4],[3,1,5]], "ccc");
my $U = ptex::printMatrix([[3,1,2],[0,1,0],[0,0,3]], "ccc");
my $L = ptex::printMatrix([[1,0,0],[2,1,0],[1,0,1]], "ccc");
my $X = ptex::printMatrix([["x_1"], ["x_2"], ["x_3"]], "c");
my $B = ptex::printMatrix([[0],[1],[3]],"c");
my $C = ptex::printMatrix([["c_1"], ["c_2"], ["c_3"]], "c");
my $csol = ptex::printMatrix([[0],[1],[3]], "c");
my $xsol = ptex::printMatrix([[-1],[1],[1]], "c");

print ptex::math($A . "\n" .
		 $X . "\n" .
		 "=" . "\n" .
		 $B) . "\n";
print ptex::math("U =\n" . $U)
	        . "\n" .
    ptex::math("L =\n" . $L)
	        . "\n" .
    ptex::math("$L$C=$B") . "\n" .
    ptex::math("$C=$csol") . "\n" .
    ptex::math("$U$X=$csol") . "\n" .
    ptex::math("$X=$xsol") . "\n" .
    "\\subsubsection*{b)}\n";

$A = ptex::printMatrix([[4,2,0],[4,4,2],[2,2,3]], "ccc");
$U = ptex::printMatrix([[4,2,0],[0,2,2],[0,0,2]], "ccc");
$L = ptex::printMatrix([[1,0,0],[1,1,0],[ptex::frac(1,2),ptex::frac(1,2),1]], "ccc");
$B = ptex::printMatrix([[2],[4],[6]],"c");
$csol = ptex::printMatrix([[2],[2],[4]], "c");
$xsol = ptex::printMatrix([[1],[-1],[2]], "c");

print ptex::math($A . "\n" .
		 $X . "\n" .
		 "=" . "\n" .
		 $B) . "\n";
print ptex::math("U =\n" . $U)
	        . "\n" .
    ptex::math("L =\n" . $L)
	        . "\n" .
    ptex::math("$L$C=$B") . "\n" .
    ptex::math("$C=$csol") . "\n" .
    ptex::math("$U$X=$csol") . "\n" .
    ptex::math("$X=$xsol") . "\n" .    
    "\\section*{2.3}\n" .
    "\\subsection*{2}\n" . 
    "\\subsubsection*{a)}\n";

my ($a,$b,$c,$d) = (1,2,3,4);
$A = ptex::printMatrix([[$a,$b],[$c,$d]], "cc");
my $Ainv = ptex::printMatrix([[$d, -$b],[-$c,$a]], "cc");
my $cond = "||A||_{\\infty}||A^{-1}||_{\\infty}";

print ptex::math("A=$A") . "\n" .
    ptex::math("A^{-1}=" . ptex::frac(-1,2) ."$Ainv") . "\n" . 
    ptex::math("$cond=7*3=21") . "\n" .
    "\\subsubsection*{b)}\n";

($a,$b,$c,$d) = (1,2.01,3,6);
$A = ptex::printMatrix([[$a,$b],[$c,$d]], "cc");
$Ainv = ptex::printMatrix([[$d, -$b],[-$c,$a]], "cc");

print ptex::math("A=$A") . "\n" .
    ptex::math("A^{-1}=" . ptex::frac("-10^2", 3) ."$Ainv") . "\n" . 
    ptex::math("$cond=9(10^2)" . ptex::frac(8.01,3)) . "\n";

($a,$b,$c,$d) = (6,3,4,2);
$A = ptex::printMatrix([[$a,$b],[$c,$d]], "cc");
$Ainv = ptex::printMatrix([[$d, -$b],[-$c,$a]], "cc");

print "\\subsubsection*{c)}\n" .
    ptex::math("A=$A") . "\n" .
    ptex::math("A^{-1}=" . ptex::frac(1,0) ."$Ainv") . "\n" . 
    ptex::math("$cond D.N.E") . "\n" .
    "A is singular.\n" .
    "\\subsection*{6}\n" .
    "\\subsubsection*{a)}\n";

($a,$b,$c,$d) = (1,2,2,4.01);
$A = ptex::printMatrix([[$a,$b],[$c,$d]], "cc");
my $AXc = ptex::printMatrix([[2],[4.06]], "c");
my $xc = ptex::printMatrix([[-10],[6]], "c");
my $rsol = ptex::printMatrix([[1],[1.95]],"c");

$B = ptex::printMatrix([[3],[6.01]],"c");
$X = ptex::printMatrix([["x_1"], ["x_2"]], "c");
$xsol = ptex::printMatrix([[1,1]],"c");

my $fErr = ptex::frac("||x-x_c||_{\\infty}", "x_{\\infty}");
my $bErr = ptex::frac("||r||_{\\infty}", "||b||_{\\infty}");
my $mag = ptex::frac("||x-xc||_{\\infty}||b||_{\\infty}", "||x||_{\\infty}||r||_{\\infty}");

my $R = "r=$B-$AXc";

print ptex::math("$A$X=$B") .
    ptex::math("$R=$rsol") . "\n" .
    ptex::math("$fErr = 3.06") . "\n" .
    ptex::math("$bErr =" . ptex::frac(1.95,6.01)) . "\n" .
    ptex::math("$mag =" . ptex::frac("3.06(6.01)", 1.95) . "=" . ptex::frac(3.06*6.01,1.95)) .  "\n" .
    "\\subsubsection*{b)}\n";
$xc = ptex::printMatrix([[-100],[52]], "c");
$AXc = ptex::printMatrix([[4],[8.52]], "c");
$rsol = ptex::printMatrix([[-1],[-2.51]],"c");
$R = "r=$B-$AXc";

print ptex::math("$R=$rsol") . "\n" .
    ptex::math("$fErr = 7.52") . "\n" .
    ptex::math("$bErr =" . ptex::frac(2.51,6.01)) . "\n" .
    ptex::math("$mag =" . ptex::frac("7.52(6.01)", 2.51)) .  "\n" .
    "\\subsubsection*{c)}\n";

$xc = ptex::printMatrix([[-600],[301]], "c");
$AXc = ptex::printMatrix([[2],[7.01]], "c");
$rsol = ptex::printMatrix([[1],[-1]],"c");
$R = "r=$B-$AXc";

print ptex::math("$R=$rsol") . "\n" .
    ptex::math("$fErr = 601") . "\n" .
    ptex::math("$bErr =" . ptex::frac(1,6.01)) . "\n" .
    ptex::math("$mag = 601(6.01)") .  "\n" .
    "\\subsubsection*{d)}\n";
$xc = ptex::printMatrix([[-1],[-1]], "c");
$AXc = ptex::printMatrix([[-3],[-6.01]], "c");
$rsol = ptex::printMatrix([[6],[12.02]],"c");
$R = "r=$B-$AXc";

print ptex::math("$R=$rsol") . "\n" .
    ptex::math("$fErr = 2") . "\n" .
    ptex::math("$bErr =" . ptex::frac("2(6.01)",6.01) . "= 2" )  . "\n" .
    ptex::math("$mag =" . ptex::frac(2, 2) . "=1") .  "\n" .
    "\\subsubsection*{e)}\n";

$Ainv = ptex::printMatrix([[$d, -$b],[-$c,$a]], "cc");

print ptex::math("A=$A") . "\n" .
    ptex::math("A^{-1}= 10^2$Ainv") . "\n" . 
    ptex::math("$cond=10^2(6.01)^2") . "\n" .
    "\\subsection*{8}\n" . 
    "\\subsubsection*{a)}\n";
($a,$b,$c,$d) = (1,1,"1+\\delta",1);
$A = ptex::printMatrix([[$a,$b],[$c,$d]], "cc");
$Ainv = ptex::printMatrix([["$d", "-$b"],["-$c","$a"]], "cc");

print ptex::math("A=$A") . "\n" .
    ptex::math("A^{-1}=" . ptex::frac(-1,"\\delta") . "$Ainv") . "\n" . 
    ptex::math("$cond=" . ptex::frac(1,"\\delta") . "(2+d)^2") . "\n" .
    "\\subsubsection*{b)}\n";

$B = ptex::printMatrix([[2],["2 + \\delta"]],"c");
$xc = ptex::printMatrix([[-1],["3+\\delta"]], "c");
$AXc = ptex::printMatrix([["2+\\delta"],[2]], "c");
$rsol = ptex::printMatrix([["-\\delta"],["\\delta"]],"c");
$R = "r=$B-$AXc";

print print ptex::math("$A$X=$B") .
    ptex::math("$R=$rsol") . "\n" .
    ptex::math("$fErr = 2 + \\delta") . "\n" .
    ptex::math("$bErr =" . ptex::frac("\\delta", "2+\\delta") )  . "\n" .
    ptex::math("$mag =" . ptex::frac("(2+\\delta)^2", "\\delta")) .  "\n" .
    "\\section*{2.4}\n" .
    "\\subsection*{4}\n";

$X = ptex::printMatrix([["x1"],["x2"],["x3"]], "c");
$c = ptex::printMatrix([["c_1"], ["c_2"], ["c_3"]], "c");
$A = ptex::printMatrix([[4,2,0],[4,4,2],[2,2,3]], "ccc");
$B = ptex::printMatrix([[2],[4],[6]],"c");
$L = ptex::printMatrix([[1,0,0],[1,1,0],[ptex::frac(1,2), ptex::frac(1,2),1]], "ccc");
$U = ptex::printMatrix([[4,2,0],[0,2,2],[0,0,2]],"ccc");
$csol = ptex::printMatrix([[2],[2],[4]],"c");
$xsol = ptex::printMatrix([[1],[-1],[2]], "c");

print "\\subsubsection*{a)}\n" .
    ptex::math("$A$X=$B") .
    ptex::math("$A = $L$U") .
    ptex::math("$L$C=$B") .
    ptex::math("$U$X = $C = $csol") .
    ptex::math("$X=$xsol") .
    "\\subsubsection*{b)}\n";

$A = ptex::printMatrix([[-1,0,1],[2,1,1],[-1,2,0]], "ccc");
$B = ptex::printMatrix([[-2],[17],[3]],"c");
$L = ptex::printMatrix([[1,0,0],[ptex::frac(-1,2),1,0],[ptex::frac(-1,2), ptex::frac(1,5),1]], "ccc");
$U = ptex::printMatrix([[2,1,1],[0,ptex::frac(5,2),ptex::frac(1,2)],[0,0,ptex::frac(7,5)]],"ccc");
my $P = ptex::printMatrix([[0,1,0],[0,0,1],[1,0,0]],"ccc");
$csol = ptex::printMatrix([[17],[ptex::frac(23,2)],[ptex::frac(42,10)]],"c");
$xsol = ptex::printMatrix([[5],[4],[3]], "c");

print ptex::math("$A$X=$B") .
    ptex::math("$P$A = $L$U") .
    ptex::math("$L$C=$P$B") .
    ptex::math("$U$X = $C = $csol") .
    ptex::math("$X=$xsol") .
    "\\subsection*{8}\n";

$A = ptex::printMatrix([[1,-1,3],[-1,0,-2],[2,2,4]], "ccc");
$B = ptex::printMatrix([[-3],[1],[0]],"c");
$L = ptex::printMatrix([[1,0,0],[ptex::frac(1,2), 1,0],[ptex::frac(-1,2),ptex::frac(-1,2), 1]], "ccc");
$U = ptex::printMatrix([[2,2,4],[0,-2,1],[0,0,ptex::frac(1,2)]],"ccc");
$P = ptex::printMatrix([[0,1,0],[0,0,1],[1,0,0]],"ccc");

print ptex::math("$A$X=$B") .
    ptex::math("$P$A = $L$U") .
    ptex::inlineMath(ptex::frac(1,2)) . 
    " is the largest multiplier" .
    "\\section*{2.5}\n" .
    "\\subsection*{2}\n";
$X = ptex::printMatrix([["x_1"],["x_2"]],"c");
$A = ptex::printMatrix([[1, 3],[5,4]], "cc");
$B = ptex::printMatrix([[-1],[6]], "c");

print "\\subsubsection*{a)}\n" .
    ptex::math("$A$X=$B") . "\n";

$A = ptex::printMatrix([[3, 1],[4,5]], "cc");
$B = ptex::printMatrix([[6],[-1]], "c");

$U = [0,ptex::frac(6,5),ptex::frac(22,15)];
my $V = [0,ptex::frac(-1,3),ptex::frac(1,15)];

my $u = sub{my $x = shift; return ptex::frac("6 - 4($x)", 5)};
my $v = sub{my $x = shift; return ptex::frac("$x - 1", 3)};

print ptex::math("$A$X=$B") . "\n" .
    "Jacobi:\\\\\n";
foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($V->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($U->[$i-1]) . "=$V->[$i]") . "\n"
}

$U = [0,ptex::frac(6,5),ptex::frac(86,75)];
$V = [0,ptex::frac(1,15), ptex::frac(11,225)];

print "Gauss-Siedel:\\\\\n";

foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($V->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($U->[$i]) . "=$V->[$i]") . "\n"
}

$X = ptex::printMatrix([["x_1"], ["x_2"], ["x_3"]],"c");
$A = ptex::printMatrix([[1,-8, -2],[1,1,5], [3,-1,1]], "ccc");
$B = ptex::printMatrix([[1],[4],[-2]], "c");

print "\\subsubsection*{b)}\n" .
    ptex::math("$A$X=$B") . "\n";

$A = ptex::printMatrix([[3,-1,1],[1,-8,-2],[1,1,5]], "ccc");
$B = ptex::printMatrix([[-2],[1],[4]], "c");

$u = sub{my ($x,$y) = (@_); return ptex::frac("2 + $x - $y", 3)};
$v = sub{my ($x,$y) = (@_); return ptex::frac("$x - 2($y) - 1", 8)};
my $w = sub{my ($x,$y) = (@_); return ptex::frac("4 - $x - $y", 5)};

$U = [0,ptex::frac(2,3),ptex::frac(43,120)];
$V = [0,ptex::frac(-1,8), ptex::frac(-29,120)];
my $W = [0,ptex::frac(4,5),ptex::frac(83,120)];

print ptex::math("$A$X=$B") . "\n" .
    "Jacobi:\\\\\n";
foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($V->[$i-1], $W->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($U->[$i-1], $W->[$i-1]) . "=$V->[$i]") . "\n" .
	ptex::math("w_$i = " . &$w($U->[$i-1],$V->[$i-1]) . "=$W->[$i]") . "\n";
}

$U = [0,ptex::frac(2,3),ptex::frac(77,180)];
$V = [0,ptex::frac(-1,24), ptex::frac(-173,720)];
$W = [0,ptex::frac(81,120),ptex::frac(61,80)];
print "Gauss-Siedel:\\\\\n";

foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($V->[$i-1], $W->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($U->[$i], $W->[$i-1]) . "=$V->[$i]") . "\n" .
	ptex::math("w_$i = " . &$w($U->[$i],$V->[$i]) . "=$W->[$i]") . "\n";
}

$A = ptex::printMatrix([[1,4,0],[0,1,2], [4,0,3]], "ccc");
$B = ptex::printMatrix([[5],[2],[0]], "c");

print "\\subsubsection*{c)}\n" .
    ptex::math("$A$X=$B") . "\n";

$A = ptex::printMatrix([[4,0,3],[1,4,0],[0,1,2]], "ccc");
$B = ptex::printMatrix([[0],[5],[2]], "c");

$u = sub{my ($x) = (@_); return ptex::frac("-3($x)", 4)};
$v = sub{my ($x) = (@_); return ptex::frac("5-$x", 4)};
$w = sub{my ($x) = (@_); return ptex::frac("2-$x", 2)};

$U = [0,0,ptex::frac(-3,4)];
$V = [0,ptex::frac(5,4), ptex::frac(5,4)];
$W = [0,1,ptex::frac(3,8)];

print ptex::math("$A$X=$B") . "\n" .
    "Jacobi:\\\\\n";
foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($W->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($U->[$i-1]) . "=$V->[$i]") . "\n" .
	ptex::math("w_$i = " . &$w($V->[$i-1]) . "=$W->[$i]") . "\n";
}

$U = [0,0,ptex::frac(-9,32)];
$V = [0,ptex::frac(5,4), ptex::frac(169,128)];
$W = [0,ptex::frac(3,8),ptex::frac(87,256)];
print "Gauss-Siedel:\\\\\n";

foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($W->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($U->[$i]) . "=$V->[$i]") . "\n" .
	ptex::math("w_$i = " . &$w($V->[$i]) . "=$W->[$i]") . "\n";
}

print "\\subsection*{4}\n" .
    "When \\(\\omega = 1\\), SOR is exactly Gauss-Seidel, i.e. the answers are exactly the same.\\\\\n" .
    "\\(\\omega = 1.2 = " . ptex::frac(6,5) . "\\)\\\\\n";
my $omega = ptex::frac(6,5);
my $diff = ptex::frac(-1,5);

$A = ptex::printMatrix([[3, 1],[4,5]], "cc");
$B = ptex::printMatrix([[6],[-1]], "c");

$U = [0,ptex::frac(36,25),ptex::frac(3072,"5^5")];
$V = [0,ptex::frac(22,125),ptex::frac(-656,"5^6")];

$u = sub{my ($x,$y) = (@_); return "$diff($x)  + $omega" . ptex::parens(ptex::frac("6 - 4($y)", 5))};
$v = sub{my ($x,$y) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("$y - 1", 3))};

print ptex::math("$A$X=$B") . "\n";

foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($U->[$i-1],$V->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($V->[$i-1],$U->[$i]) . "=$V->[$i]") . "\n"
}


$A = ptex::printMatrix([[3,-1,1],[1,-8,-2],[1,1,5]], "ccc");
$B = ptex::printMatrix([[-2],[1],[4]], "c");

$u = sub{my ($x,$y,$z) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("2 + $y - $z", 3))};
$v = sub{my ($x,$y,$z) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("$y - 2($z) - 1", 8))};
$w = sub{my ($x,$y,$z) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("4 - $y - $z", 5))};

$U = [0,ptex::frac(4,5),ptex::frac(1987,6250)];
$V = [0,ptex::frac(-3,100), ptex::frac(-41109,"5^6(2^3)")];
$W = [0,ptex::frac(969,1250),ptex::frac(2523714,"5^8(2^3)")];

print ptex::math("$A$X=$B") . "\n";

foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($U->[$i-1],$V->[$i-1], $W->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($V->[$i-1],$U->[$i], $W->[$i-1]) . "=$V->[$i]") . "\n" .
	ptex::math("w_$i = " . &$w($W->[$i-1],$U->[$i],$V->[$i]) . "=$W->[$i]") . "\n";
}

$A = ptex::printMatrix([[4,0,3],[1,4,0],[0,1,2]], "ccc");
$B = ptex::printMatrix([[0],[5],[2]], "c");

$u = sub{my ($x,$y) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("-3($y)", 4))};
$v = sub{my ($x,$y) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("5-$y", 4))};
$w = sub{my ($x,$y) = (@_); return "$diff($x) + $omega" . ptex::parens(ptex::frac("2-$y", 2))};

$U = [0,0,ptex::frac(-27,100)];
$V = [0,ptex::frac(3,2), ptex::frac(1281,1000)];
$W = [0,ptex::frac(3,10),ptex::frac(1857,5000)];

print ptex::math("$A$X=$B") . "\n";

foreach my $i (1..$#$U){
    print ptex::math("u_$i = " . &$u($U->[$i-1],$W->[$i-1]) . "=$U->[$i]") . "\n" . 
	ptex::math("v_$i = " . &$v($V->[$i-1],$U->[$i]) . "=$V->[$i]") . "\n" .
	ptex::math("w_$i = " . &$w($W->[$i-1],$V->[$i]) . "=$W->[$i]") . "\n";
}

print "\\section*{12.1}\n" .
    "\\subsection*{8}\n".
    "\\subsubsection*{a)}\n".
    "Converges to 4, with " . 
    ptex::inlineMath("S = " . ptex::frac(1,2)) . "\n" .
    "\\subsubsection*{b)}\n".
    "Converges to 3, with " . 
    ptex::inlineMath("S = " . ptex::frac(1,3)) . "\n" .
    "\\subsubsection*{c)}\n".
    "Converges to 2, with " . 
    ptex::inlineMath("S = " . ptex::frac(1,2)) . "\n" .
    "\\subsubsection*{d)}\n".
    "Converges to 9, with " . 
    ptex::inlineMath("S = " . ptex::frac(1,2)) . "\n" .
    "\\subsection*{8}\n";
$A = ptex::printMatrix([[-2,1],[3,0]], "cc");
print ptex::math("A=$A") . "\n" .
    "\\subsubsection*{a)}\n".
    "det(A) = -3\\\\\n" .
    ptex::inlineMath("\\lambda^2 -Tr(A)+det(A) = \\lambda^2 + 2\\lambda - 3 = (\\lambda + 3)(\\lambda-1) = 0") . "\\\\\n" .
    ptex::inlineMath("\\lambda = 1,-3");

print "\\subsubsection*{b)}\n";

$X = [ptex::printMatrix([[1],[0]], "c"),
      ptex::printMatrix([[2],[3]], "c"),
      ptex::printMatrix([[7],[-6]], "c"),
      ptex::printMatrix([[-20],[21]], "c")];

my $XT = [ptex::printMatrix([[1,0]], "cc"),
      ptex::printMatrix([[2,3]], "cc"),
      ptex::printMatrix([[7,-6]], "cc"),
      ptex::printMatrix([[-20,21]], "cc")];

my $coeffs = ["", ptex::frac(1,"\\sqrt(13)"),
	      ptex::frac(1,"\\sqrt(85)")];
	
my $lambda = [-2, ptex::frac(-32,13), ptex::frac(-266,85), ptex::frac(-2480,841)];

$U = ["u_0" . " = " .ptex::frac("$coeffs->[0]$X->[0]","\\left|$coeffs->[0]$X->[0]\\right|") . " = $coeffs->[0]$X->[0]",
      "u_1" . " = " .ptex::frac("$coeffs->[0]$X->[1]","\\left|$coeffs->[0]$X->[1]\\right|") . " = $coeffs->[1]$X->[1]",
      "u_2" . " = " .ptex::frac("$coeffs->[1]$X->[2]","\\left|$coeffs->[1]$X->[2]\\right|") . " = $coeffs->[2]$X->[2]"];

print ptex::math("\\lambda_0 =" . ptex::frac("$coeffs->[0] $XT->[0] $A $coeffs->[0] $X->[0]", "$coeffs->[0] $XT->[0] $coeffs->[0] $X->[0]") . " = $lambda->[0]");
foreach my $i (1..$#$X){
    print ptex::math($U->[$i-1]) . "\n";
    print ptex::math("x_$i = $A$coeffs->[$i-1]$X->[$i-1] = $coeffs->[$i-1]$X->[$i]") . "\n";
		     #, "\\left| $A$coeffs->[$i-1]$X->[$i-1] \\right|") . "=$coeffs->[$i]$X->[$i]") . "\n";
    

    print ptex::math("\\lambda_$i =" . ptex::frac("$coeffs->[$i-1] $XT->[$i] $A $coeffs->[$i-1] $X->[$i]", "$coeffs->[$i-1] $XT->[$i] $coeffs->[$i-1] $X->[$i]") . " = $lambda->[$i]")
}

print "\\subsubsection*{c)}\n".
    "Converges to 1\n" .
    "\\subsubsection*{d)}\n".
    "Converges to 1\n" .
    "\\section*{12.3}\n";
$A = [ptex::printMatrix([[3, 0],[4, 0]], "cc"),
      ptex::printMatrix([[6, -2],[8, ptex::frac(3,2)]],"cc"),
      ptex::printMatrix([[0, 1],[0, 0]],"cc"),
      ptex::printMatrix([[-4, -12],[12, 11]], "cc"),
      ptex::printMatrix([[0, -2],[-1, 0]], "cc")];
my $section = ["\\subsubsection*{a)}\n",
	       "\\subsubsection*{b)}\n",
	       "\\subsubsection*{c)}\n",
	       "\\subsubsection*{d)}\n",
	       "\\subsubsection*{e)}\n",];
$U = [ptex::printMatrix([[ptex::frac(3,5), ptex::frac(-4,5)],[ptex::frac(4,5),ptex::frac(3,5)]],"cc"),
      ptex::printMatrix([[ptex::frac(3,5), ptex::frac(-4,5)],[ptex::frac(4,5),ptex::frac(3,5)]],"cc"),
      ptex::printMatrix([[1, 0],[0,1]],"cc"),
      ptex::printMatrix([[ptex::frac(-3,5),ptex::frac(4,5)],[ptex::frac(4,5),ptex::frac(3,5)]],"cc"),
      ptex::printMatrix([[ptex::frac("-\\sqrt(2)",2),ptex::frac("-\\sqrt(2)",2)],[ptex::frac("-\\sqrt(2)",2),ptex::frac("\\sqrt(2)",2)]],"cc")];


my $S = [ptex::printMatrix([[5,0],[0,0]],"cc"),
      ptex::printMatrix([[10,0],[0,ptex::frac(5,2)]],"cc"),
      ptex::printMatrix([[1,0],[0,0]],"cc"),
      ptex::printMatrix([[20,0],[0,5]],"cc"),
      ptex::printMatrix([[2,0],[0,ptex::frac(1,2)]],"cc")];

$V = [ptex::printMatrix([[1,0],[0,1]],"cc"),
      ptex::printMatrix([[1, 0],[0, 1]],"cc"),
      ptex::printMatrix([[0, 1],[1, 0]],"cc"),
      ptex::printMatrix([[ptex::frac(3,5), ptex::frac(4,5)],[ptex::frac(4,5),ptex::frac(-3,5)]],"cc"),
      ptex::printMatrix([[ptex::frac("-\\sqrt(2)", 2), ptex::frac("\\sqrt(2)", 2)],[ptex::frac("-\\sqrt(2)", 2),ptex::frac("-\\sqrt(2)", 2)]],"cc")];

foreach my $i (0..$#$A){
    print $section->[$i] . "\n" .
	ptex::math("$A->[$i]  = $U->[$i] $S->[$i] $V->[$i]^T") . "\n\n";

}
print "\\end{document}\n";
