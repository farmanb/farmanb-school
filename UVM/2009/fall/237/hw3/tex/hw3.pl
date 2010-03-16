#!/usr/bin/env perl
use strict;
use warnings;

sub printArray{
    my $array = shift;
    
    foreach my $row (@{$array}){
	print join(' & ', @{$row}) . "\\\\\n";
    }
}

sub printEqnArray{
    my ($array, $sep) = (@_);

    $sep = " & $sep & ";
    
    foreach my $row(@{$array}){
	print join($sep, @{$row}) . "\\\\\n";
    }
}

sub inlineMath{
    my $line = shift;

    return "\\($line\\)";
}

sub math{
    my $line = shift;
    return "\\[$line\\]";
}

sub frac{
    my ($d, $n) = (@_);
    
    return "\\frac{$d}{$n}";
}

sub parens{
    my $string = shift;
    return "(". $string . ")";
}

#Preamble
my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("amssymb","amsmath","latexsym","graphicx","enumerate");

my ($course, $hw) = (237, 3);
my ($author,
    $title) = ("Blake Farman", "$course: Homework $hw");

my ($beq, $eeq) = ("\\begin{eqnarray*}", "\\end{eqnarray*}");

print "\\documentclass[" . join(',', @docClassArgs) . "]{$documentClass}\n".
    "\\usepackage{" . join(',',  @texPackages) . "}\n" .
    "\\author{$author}\n" .
    "\\title{$title}\n" . 
    "\\begin{document}\n" .
    "\\maketitle\n" .
    "\\newpage\n" .
    "\\section*{5.1.2}\n" .
    "$beq\n";
printEqnArray([["f^{'}(x)", frac("f(x+h) - f(x-h)", "2h")],
	       ["f(x)", "e^x"],
	       ["f^{'}(x)", frac("e^{x+h} - e^{x-h}", "2h")],
	       ["f^{'}(0)", frac("e^{h} - e^{-h}","2h")],
	       ["", frac("\\sinh(h)", "h")]], "\\approx") ;
print "$eeq\n" .
    "\\subsection*{a)}\n" .
    "h =" . inlineMath(frac("1", "10")) . "\\\\\n" .
    "$beq\n";
printEqnArray([["f^{'}(0)", "10\\sinh(" . frac("1", "10") . ")"],
	       ["", "10\\sinh(". frac(1,10) . ")"]], "\\approx") ;
printEqnArray([["", 1.0017]], "\\approx");
print "$eeq\n" .
    "\\subsection*{b)}\n" .
    "h =" . inlineMath(frac("1", "100")) . "\\\\\n" .
    "$beq\n";
printEqnArray([["f^{'}(0)", frac("\\sinh(h)", "h")],
	       ["", "100\\sinh(". frac(1,100) . ")"]], "\\approx") ;
printEqnArray([["", 1]], "\\approx");
print "$eeq\n" .
    "\\subsection*{c)}\n" .
    "h =" . inlineMath(frac("1", "1000")) . "\\\\\n" .
    "$beq\n";
printEqnArray([["f^{'}(0)", frac("\\sinh(h)", "h")],
	       ["", "1000\\sinh(". frac(1,1000) . ")"]], "\\approx") ;
printEqnArray([["", 1]], "\\approx");
print "$eeq\n" .
    "\\section*{5.1.6}\n".
    "$beq\n";
printEqnArray([["f^{''}(x)", frac("f(x-h) - 2f(x) + f(x+h)", "h^2")],
	       ["\\cos^{''}(x)", frac("\\cos(x-h) - 2\\cos(x) + cos(x+h)", "h^2")],
	       ["\\cos^{''}(0)", frac("\\cos(h) - 2\\cos(0) + cos(h)", "h^2")],
	       ["", frac("2\\cos(h) - 2", "h^2")],
	       ["", frac("2(\\cos(h)-1)", "h^2")]], "\\approx");
print "$eeq\n" .
    "\\subsection*{a)}\n" .
    "h =" . inlineMath(frac("1", "10")) . "\\\\\n" .
    "$beq\n";
printEqnArray([["\\cos^{''}(0)", frac("2(\\cos(" . frac(1,10)  . ")-1)", frac(1,10) . "^2")],
	       ["", "2(10^2)(\\cos(" . frac(1,10) . ") - 1)"],
	       ["", -0.9992]],"\\approx");
print "$eeq\n" .
    "\\subsection*{b)}\n" .
    "h =" . inlineMath(frac("1", "100")) . "\\\\\n" .
    "$beq\n";
printEqnArray([["\\cos^{''}(0)", frac("2(\\cos(" . frac(1,100) . ")-1)", frac(1,100). "^2")],
	      ["", "2(100^2)(\\cos(" . frac(1,100) . ") - 1)"],
	      ["", -1.0000]],"\\approx");
print "$eeq\n" .
    "\\subsection*{c)}\n" .
    "h =" . inlineMath(frac("1", "1000")) . "\\\\\n" .
    "$beq\n";
printEqnArray([["\\cos^{''}(0)", frac("2(\\cos(" . frac(1,1000) . ")-1)", frac(1,1000) . "^2")],
	      ["", "2(1000^2)(\\cos(" . frac(1,1000) . ") - 1)"],
	      ["", -1.0000]],"\\approx");
print "$eeq\n" .
    "\\section*{5.1.10}\n" .
    "$beq\n";
printEqnArray([["f^{'}(x)", frac("f(x+h) - f(x)", "h")],
	       ["", frac(1,"h") . "(" .frac(1,"x+h") . "-" . frac(1,"x") . ")"],
	       ["", frac(1,"h") . "(" . frac("x-(x+h)","x(x+h)"). ")"],
	       ["", frac(1,"h") . "(" . frac("h","x(x+h)"). ")"],
	       ["", frac("-1","x(x+h)")]],"\\approx");
printEqnArray([["f^{'}(x)", frac(-1,"x^2")],
	       ["", frac("-1", "x(x+h)") . "+ \\varepsilon"],
	       ["\\Rightarrow\\varepsilon",frac(-1,"x^2") . "+" . frac("1", "x(x+h)")],
	       ["", frac("x-(x+h)","x^2(x+h)")],
	       ["", frac("-h", "x^2(x+h)")]], "=");
print "$eeq\n" .
    "Thus, \n" . 
    inlineMath("\\varepsilon \\rightarrow 0") . "\n" . 
    " as \n" .
    inlineMath("x \\rightarrow \\infty") . "\n" .
    " and " .
    inlineMath("\\varepsilon \\rightarrow 0") . "\n" .
    " faster as \n" .
    inlineMath("h \\rightarrow 0") . "\n" .
    "$beq\n";
printEqnArray([["f^{'}(x)", frac(1,"2h") . parens(frac(1,"x+h") . "-" . frac(1,"x-h"))],
	       ["", frac(1,"2h") . parens(frac("(x-h) - (x+h)", "x^2 - h^2"))],
	       ["", frac(1,"2h") . parens(frac("-2h", "x^2 - h^2"))],
	       ["", frac("-1", "x^2 - h^2")]], "\\approx");
printEqnArray([["f^{'}(x)", frac(-1, "x^2")],
	       ["", frac("-1", "x^2 - h^2") . "+ \\varepsilon"],
	       ["\\Rightarrow\\varepsilon",frac(-1,"x^2") . "+" . frac(1, "x^2 - h^2")],
	       ["",frac("x^2 - h^2 + x^2","x^2(x^2 - h^2)")],
	       ["",frac("-h^2" ,"x^2(x^2 - h^2)")]], "=");
print "$eeq\n" .
    "Thus, \n" . 
    inlineMath("\\varepsilon \\rightarrow 0") . "\n" . 
    " as \n" .
    inlineMath("x \\rightarrow \\infty") . "\n" .
    " and " .
    inlineMath("\\varepsilon \\rightarrow 0") . "\n" .
    " faster as \n" .
    inlineMath("h^2 \\rightarrow 0") . "\n" .
    "\\section*{5.1.18}\n";
{
    my $x = "x-a";
    my $a = "x";
    print "f(x) about a\n" .
	"$beq\n";
    printEqnArray([["f($a)", "\\sum_{n=0}^{\\infty}($x)^{n}" . frac("f^{n}(a)", "n!")]], "=");
    $a = "a-3h";
    $x = "-3h";
    printEqnArray([["f($a)", "\\sum_{n=0}^{\\infty}($x)^{n}" . frac("f^{n}(a)", "n!")]], "=");
    $a = "a-2h";
    $x = "-2h";
    printEqnArray([["f($a)", "\\sum_{n=0}^{\\infty}($x)^{n}" . frac("f^{n}(a)", "n!")]], "=");
    $a = "a-h";
    $x = "-h";
    printEqnArray([["f($a)", "\\sum_{n=0}^{\\infty}($x)^{n}" . frac("f^{n}(a)", "n!")]], "=");
    $a = "a+h";
    $x = "h";
    printEqnArray([["f($a)", "\\sum_{n=0}^{\\infty}($x)^{n}" . frac("f^{n}(a)", "n!")]], "=");
    print "$eeq\n";
}

print "$beq\n";
printEqnArray([[frac("f(a-3h)-6f(a-2h)+12f(a-h)+3f(a+h)-10f(a)", "2h^3"), frac(1,"2h^3") . "((1-6+12+3-10)f(a)" ]], "=");
printEqnArray([["","(-3+12-12+3)hf^{'}(a) "],
	       ["", "(9-24+12+3)" . frac("h^2f^{''}(a)", "2!")],
	       ["", "(-27+48-12+3)" . frac("h^3f^{'''}(a)", "3!"). ")"]],"+");
printEqnArray([["", frac(1,"2h^3") . "12" . frac("f^{'''}(a)", "3!")],
	       ["", frac(1,"2h^3") . "2h^3f^{'''}(a)"],
	       ["", "f^{'''}(a)"]],"=");

print "$eeq\n" .
    "\\section*{5.2.2}\n" .
    "\\subsection*{a)}" .
    "m = 2\\\\\n" . 
    "\\(\\frac{5}{16}\\)\\\\\n" .
    "\\(|\\frac{1}{3} - \\frac{5}{16}| = \\frac{1}{48}\\)\\\\\n" .
    "m = 4\\\\\n" .
    "\\(\\frac{21}{64}\\)\\\\\n" .
    "\\(|\\frac{1}{3} - \\frac{21}{64}| = \\frac{1}{192}\\)\n" .
    "\\subsection*{b)}\n" .
    "m = 2\\\\\n" .
    inlineMath("\\frac{1}{4} \\pi  \\left(\\cos(\\frac{\\pi }{8})+\\sin(\\frac{\\pi }{8})\\right)") . "\\\\\n" .
    "\\(|1 - \\frac{1}{4} \\pi \\left(\\cos( \\frac{\\pi}{8})+\\cos( \\frac{3 \\pi}{8})\\right)| \\approx 0.0262\\)\\\\\n" .
    "m = 4\\\\\n" . 
    inlineMath("\\frac{1}{8} \\pi  \\left(\\cos(\\frac{\\pi }{16})+\\cos(\\frac{3 \\pi }{16})+\\sin(\\frac{\\pi }{16})+\\sin(\\frac{3 \\pi }{16})\\right)") . "\\\\\n" .
    "\\(|1-\\frac{1}{8} \\pi \\left(\\cos( \\frac{\\pi}{16})+\\cos( \\frac{3 \\pi}{16})+\\cos(
    \\frac{5 \\pi}{16})+\\cos( \\frac{7 \\pi}{16})\\right)| \\approx 0.0065\\)\n" .
    "\\subsection*{c)}\n" .
    "m = 2\\\\\n" .
    inlineMath("\\frac{1}{2} \\left(e^{1/4}+e^{3/4}\\right)") . "\\\\\n" .
    "\\(|e - \\frac{1}{2} \\left(e^{1/4}+e^{3/4}\\right)| \\approx 1.0178\\)\\\\\n" .
    "m = 4\\\\\n" .
    inlineMath("\\frac{1}{4} \\left(e^{1/8}+e^{3/8}+e^{5/8}+e^{7/8}\\right)") . "\\\\\n" .
    "\\(|e-\\frac{1}{4} \\left(e^{1/8}+e^{3/8}+e^{5/8}+e^{7/8}\\right)| \\approx 1.0045\\)\n" .
    "\\section*{5.2.4}\n" .
    "\\subsection*{a)}\n" .
    "m = 2\\\\\n" . 
    "\\(\\frac{1}{12} \\left(4 \\left(\\frac{e^{1/4}}{4}+\\frac{3 e^{3/4}}{4}\\right)+\\sqrt{e}+e\\right)\\)\\\\\n" .
    "\\(|1-\\frac{1}{12} \\left(4 \\left(\\frac{e^{1/4}}{4}+\\frac{3 e^{3/4}}{4}\\right)+\\sqrt{e}+e\\right)| \\approx 1.6905(10^{-4})\\)\\\\\n" .
    "m = 4\\\\\n" .
    "\\(\\frac{1}{24} \\left(2 \\left(\\frac{e^{1/4}}{4}+\\frac{\\sqrt{e}}{2}+\\frac{3 e^{3/4}}{4}\\right)+4 \\left(\\frac{e^{1/8}}{8}+\\frac{3
    e^{3/8}}{8}+\\frac{5 e^{5/8}}{8}+\\frac{7 e^{7/8}}{8}\\right)+e\\right)\\)\\\\\n" .
    "\\(|1-\\frac{1}{24} \\left(2 \\left(\\frac{e^{1/4}}{4}+\\frac{\\sqrt{e}}{2}+\\frac{3 e^{3/4}}{4}\\right)+4 \\left(\\frac{e^{1/8}}{8}+\\frac{3
    e^{3/8}}{8}+\\frac{5 e^{5/8}}{8}+\\frac{7 e^{7/8}}{8}\\right)+e\\right)| \\approx 1.0650(10^{-5})\\)\\\\\n" .
    "\\subsection*{b)}\n" .
    "m = 2\\\\\n" . 
    "\\(|\\frac{\\pi}{4}-\\frac{8011}{10200}| \\approx 6.0065(10^{-6})\\)\\\\\n" .
"\\(\\frac{8011}{10200}\\)\\\\\n" .
    "m = 4\\\\\n" .
    "\\(\\frac{152916620159}{194699497200}\\)\\\\\n" .
    "\\(|\\frac{\\pi}{4} - \\frac{152916620159}{194699497200}| \\approx 3.7783(10^{-8})\\)\\\\\n" .
    "\\subsection*{c)}\n" .
    "m = 2\\\\\n" . 
    "\\(\\frac{1}{12} \\pi  \\left(-\\pi -\\sqrt{2} \\pi \\right)\\)\\\\\n" .
    "\\(|-2 -\\frac{1}{12} \\pi  \\left(-\\pi -\\sqrt{2} \\pi \\right)| \\approx 0.0144\\)\\\\\n" .
    "m = 4\\\\\n" .
    "\\(1/24 \\pi (-\\pi - \\pi/\\sqrt(2) + 4 (-(3/4) \\pi \\cos(\\pi/8) - 1/4 \\pi \\sin(\\pi/8)))\\)\\\\\n" .
    "\\(|-2 - 1/24 \\pi (-\\pi - \\pi/\\sqrt(2) + 4 (-(3/4) \\pi \\cos(\\pi/8) - 1/4 \\pi \\sin(\\pi/8)))| \\approx 0.1753(10^{-4})\\)\n" .
    "\\section*{5.2.6}\n" .
    "\\subsection*{a)}\n" .
    "\\((-h,0),(0,1),(h,0)\\)\\\\\n" .
    "$beq\n";
printEqnArray([["P(x)", frac(1,"h") . "(x+h) - " . frac(1,"h^2") . "(x+h)(x)" . "\\\\\n"],
	       ["\\int_{-h}^{-h}" . frac(1,"h") . "(x+h) - " . frac(1,"h^2") . "(x+h)(x)", "x|_{-h}^{h} - " . frac(1,"3h^2") . "x^3|_{-h}^{h}"],
	       ["", "2h - " . frac("2h", 3)],
	       ["", frac("4h", 3)]], "=");
print "$eeq\n" .
    "\\subsection*{b)}\n" .
    "\\((-h,1),(0,0),(h,0)\\)\\\\\n" .
    "$beq\n";
printEqnArray([["P(x)", "1 - " . frac(1,"h") . "(x+h) - " . frac(1,"2h^2") . "(x+h)(x)" . "\\\\\n"],
	       ["\\int_{-h}^{-h}" . "1 - " . frac(1,"h") . "(x+h) - " . frac(1,"2h^2") . "(x+h)(x)", frac(1,"3*2h^2") . "x^3|_{-h}^{h}"],
	       ["", frac("h", 3)]], "=");
print "$eeq\n" .
    "\\section*{5.4.2}\n" .
    "\\subsection*{a)}\n" .
    inlineMath("\\frac{1}{6} \\left( 2 \\sqrt{e} + e \\right) + \\frac{1}{12} \\left( \\frac{\\sqrt{e}}{2} + 3 e^{3/4} + e \\right)") . "\\\\\n" .
    "\\subsection*{c)}\n" .
    inlineMath("\\frac{\\pi ^2}{12 \\sqrt{2}}+\\frac{1}{12} \\pi  \\left(-\\pi -\\frac{3 \\pi }{\\sqrt{2}}\\right)+\\frac{1}{24} \\pi  \\left(-\\pi -\\frac{3 \\pi }{4 \\sqrt{2}}-\\frac{7}{2} \\pi  \\cos(\\frac{\\pi }{8})\\right)+\\frac{1}{24} \\pi  \\left(\\frac{\\pi }{4 \\sqrt{2}}+\\frac{3}{2} \\pi  \\sin(\\frac{\\pi }{8})\\right)") . "\\\\\n" .
    "\\section*{5.5.2}\n" .
    "\\subsection*{a)}\n";
my ($c1, $c2, $c3) = (frac(1,2) . "(x^2 - 1)" ,
		      frac(1,2) . "(x^2-1)(x)", 
		      frac(1,8) . "[(x^2-1)^2 + 4x^2(x^2-1)]");
my ($f1, $f2, $f3) = ("(-3)", "(0)", "(3)");
print "$beq\n";
printEqnArray([["$f1$c1 + $f2$c2 + $f3$c3", "\\\\$f1$c1 + $f3$c3"], 
	       ["", "\\left[\\frac{15}{8}-\\frac{15 x^2}{4}+\\frac{15 x^4}{8}\\right]_{-1}^{1}"]], "=");
printEqnArray([["", "0"]], "=");
print "$eeq\n" .
    "\\subsection*{b)}\n";
($f1, $f2, $f3) = (parens(1),parens(0),parens(1));
print "$beq\n";
printEqnArray([["$f1$c1 + $f2$c2 + $f3$c3", "\\\\$f1$c1 + $f3$c3"],
	       ["", "\\left[ -\\frac{3}{8}-\\frac{x^2}{4}+\\frac{5 x^4}{8}\\right]_{-1}^{1}"]], "=");
printEqnArray([["", "0"]], "=");
print "$eeq\n" .
    "\\subsection*{c)}\n";
($f1, $f2, $f3) = (parens(frac(1,"e")), parens(1), parens("e"));
print "$beq\n";
printEqnArray([["$f1$c1 + $f2$c2 + $f3$c3", "$f1$c1"]], "=");
printEqnArray([["", "$f3$c3"]], "+");
printEqnArray([["", "\\left[-(1/(2 e)) + e/8 - x/2 \\right."]], "=");
printEqnArray([["", "x^2/(2 e) - (3 e x^2)/4 + x^3/2"]], "+");
printEqnArray([["", "\\left.(5 e x^4)/8\\right]_{-1}^{1}"]], "+");
printEqnArray([["", "0"]], "=");
print "$eeq\n" .
    "\\subsection*{d)}\n";
($f1, $f2, $f3) = (parens(-1), parens(1), parens(-1));
print "$beq\n";
printEqnArray([["$f1$c1 + $f2$c2 + $f3$c3", "\\\\$f1$c1 + $f3$c3"],
	       ["" ,"\\left[\\frac{3}{8}-\\frac{x}{2}+\\frac{x^2}{4}\\right."]], "=");
printEqnArray([["", "\\left.\\frac{x^3}{2}-\\frac{5 x^4}{8}\\right]_{-1}^{1}"]], "+");
printEqnArray([["", "0"]], "=");
print "$eeq\n" .
    "\\section*{5.5.8}\n" .
    "$beq\n";
printEqnArray([["\\left.$c1\\right|_{-1}^{1}", "0"]], "=");
printEqnArray([["\\left.$c2\\right|_{-1}^{1}", "0"]], "=");
printEqnArray([["\\left.$c3\\right|_{-1}^{1}", "0"]], "=");
print "$eeq\n" .
    "\\end{document}\n";


