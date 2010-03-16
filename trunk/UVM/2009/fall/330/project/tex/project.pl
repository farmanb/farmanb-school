#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

my $documentClass = "article";
my @docClassArgs = ("12pt");
my @texPackages = ("amssymb","amsmath","latexsym","graphicx","enumerate", "color");

my ($course) = ("Math 330");
my ($author,
    $title) = ("Blake Farman\\\\University of Vermont", "Determining the Type of Hopf Bifurcation for the Brusselator");

print ptex::preamble($documentClass, \@docClassArgs, \@texPackages, $title, $author, 0);

my %xdot = ("lhs" => ptex::overdot("x"), "rhs" => "1 - (b+1) x + ax^{2}y");
my %ydot = ("lhs" => ptex::overdot("y"), "rhs" =>  "bx - ax^{2}y");
my $xdot = $xdot{"lhs"} . "=" . $xdot{"rhs"};
my $ydot = $ydot{"lhs"} . "=" . $ydot{"rhs"};

print ptex::section("Introduction");

print "The Brusselator is a theoretical, autocatalytic, chemical oscillator which, as its name suggests, was formulated by scientists in Brussels.  The reduced system of equations governing the Brusselator are as follows: " .
    ptex::eq($xdot) . "\n" . 
    ptex::eq($ydot) . "\n" .
    "where " . ptex::inlineMath("a,b > 0") . " are parameters and " . ptex::inlineMath("x,y > 0") . " are dimensionless concentrations.  Given the oscillatory nature of the reaction, it would seem reasonable to assume that the dynamics would result in a limit cycle; in fact, the aim of this article is to show, without the use of numerics, that the system undergoes a Supercritical Hopf Bifurcation.";

print ptex::section("Stability");
print ptex::subsection("Fixed Points") . "\n";
my $fp = "(1," . ptex::frac("b","a") . ")";

print "We start off our analysis of the dynamics by first looking at the fixed points of the system.  Noting that \n" . 
    ptex::inlineMath($xdot{"lhs"} . 
		     "= 1 - x - (" . $ydot{"rhs"} . ")") . "\n";

print ", it follows that\n" . 
    ptex::eq($xdot{"lhs"} .  "= 1 - x - " . $ydot{"lhs"});

print "Then, setting both equal to zero and adding (1) to (2) yields\n" .
    ptex::eq($xdot{"rhs"} . " = 0").
    ptex::eq("x = 1") . "\n" .
    "Substituting (5) in to (4) yields the only fixed point for the system, \n" .
    ptex::eq("(x^{*}, y^{*}) = $fp");

print ptex::subsection("Eigenvalues");

my $taylorX = "u[-(b+1) + 2ax^{*}y^{*}] + v[a(x^{*})^{2}] + " . ptex::frac(1,2) . "u^2[2ay^{*}] + uv[2ax^{*}] + u^{2}v[2a]";
my $taylorY = "u[b - 2ax^{*}y^{*}] - v[a(x^{*})^{2}] - " . ptex::frac(1,2) . "u^2[2ay^{*}] - uv[2ax^{*}] - u^{2}v[2a]";

my $redTaylorX = "(b-1)u + av + " . "bu^2 + 2auv + 2au^{2}v";
my $redTaylorY = "-bu - av - " . "bu^2 - 2auv - 2au^{2}v";

my $jA = "b-1";
my $jB = "a";
my $jC = "-b";
my $jD = "-a";

my $a = ptex::inlineMath("a");
my $b = ptex::inlineMath("b");

my $jacobian = ptex::printMatrix([[$jA, $jB], [$jC, $jD]], "cc");

print "Letting " . 
    ptex::inlineMath("(x^{*}, y^{*})") . 
    " be a fixed point, then let \n" . 
    ptex::inlineMath("u = x - x^{*}") . " and " . 
    ptex::inlineMath("v = y - y^{*}") . "\n" . 
    "denote the components of a small disturbance from the fixed point.  Then, expanding the equations for " . 
    ptex::inlineMath($xdot{"lhs"}) . 
    " and " . 
    ptex::inlineMath($ydot{"lhs"}) . 
    " around the fixed points, we get";

print ptex::math(ptex::overdot("u") . "=" . $taylorX) . "\n";
print ptex::math(ptex::overdot("v") . "=" . $taylorY) . "\n";

print "Which, at the fixed point, reduce to" . 
    ptex::eq($redTaylorX) . "\n" .
    ptex::eq($redTaylorY) . "\n";

print "Then, (7) and (8) can be rewritten as \n" .
    ptex::math(ptex::printMatrix([[ptex::overdot("u")], [ptex::overdot("v")]], "c") . "=$jacobian" . ptex::printMatrix([["u"], ["v"]], "c") . " + O(u^2,v^2,uv) + O(u^{2}v)");

print "which reduces to the linearized system\n" .
    ptex::eq(ptex::printMatrix([[ptex::overdot("u")], [ptex::overdot("v")]], "c") . "=$jacobian" . ptex::printMatrix([["u"], ["v"]], "c"));

my $lambda = ptex::inlineMath("\\lambda");

print "Then, the Eigenvalues can be found by solving" . ptex::math("\\lambda^{2} - (a+1-b)\\lambda + a = 0");

print "for " . ptex::inlineMath("\\lambda") .  ".  Hence,  " .
    ptex::eq("\\lambda = " . ptex::frac(1,2) . ptex::parens("(1 + a - b) \\pm"   . ptex::sqrt("(1+a-b)^2 - 4a")));

print "\\\\\n\nIt is then easy to see that what would appear to be a center appears when we fix the parameter " . ptex::inlineMath("a") . " and take the parameter " . ptex::inlineMath("b") . " such that " . ptex::inlineMath("b = a + 1") . ".\n" .
    "When we do this, the first term in the equation for " . ptex::inlineMath("\\lambda") . " vanishes and so does the first term in the square root.  What we are left with is\n" .
    ptex::eq("\\lambda = \\pm" . ptex::frac(1,2) . ptex::sqrt("-4a")) . "\n" . 
    "which, since " . ptex::inlineMath("a > 0") . ", is guaranteed to yield a pair of pure imaginary, complex conjugates.\n" .
    "This alone implies that the fixed point behaves as a center with this parameter configuration.\n" .
    "However, also taking into account that we are dealing with a linearized system, this analysis is likely incorrect.\\\\\n\n";

print "With that in mind, we take a look, with fixed " . $a . ", at the eigenvalues as a function of $b when " . ptex::inlineMath("b \\ne a + 1") . ".\n" .
    "As " . ptex::approaches("b", "(a+1)^{\\pm}") . ", " . ptex::approaches("(1 + a - b)", "0") .
    ".  From either direction, as " . ptex::approaches("b", "(a+1)^{+}") . ", " . ptex::approaches("(1 + a - b)^{2}", "0^{+}") . 
    ".  Then, independent of $b\'s approach, " . ptex::approaches("\\lambda", ptex::frac(1,2) . ptex::sqrt("-4a")) . "\n" .
    ".  Since " . ptex::inlineMath("a > 0") . " we have " . ptex::inlineMath("-4a < 0") . ", which forces $lambda into the complex plane.  However, there is one difference:  as " . "\n" .
    ptex::approaches("b", "(a + 1)^{-}"). ", " . ptex::approaches("(1 + a - b)", "0^{-}") . "\n" .
    ", but as " . ptex::approaches("b", "(a+1)^{+}") . ", " . ptex::approaches("(1 + a -b)", "0^{+}") . ".  It becomes apparent that on the left side of " . "\n" . 
    ptex::inlineMath("a + 1") . ", " . ptex::inlineMath("Re(\\lambda) < 0") . " and on the right side, " . ptex::inlineMath("Re(\\lambda) > 0") . "\n" .
    ".  It would appear that " . ptex::inlineMath("b = a + 1") . " is a bifurcation point.\n" . 
    "In fact, noting that the eigenvalues are complex numbers which are not purely imaginary, the fixed point starts as a stable spiral and, as $b increases, switches to an unstable spiral." . "\n" .
    "  This, coupled with the fact that the eigenvalues are pure imaginary numbers, suggest that " . ptex::inlineMath("b = a + 1") . " is actually a Hopf Bifurcation.\n" .
    "What remains to be shown is that, at the bifurcation point, a limit cycle is also born.\n";

print ptex::section("Limit Cycles");
print ptex::subsection("Trapping Region");
print "In order to prove that the system does have a limit cycle, we will use the Poincar\\'{e}-Bendixson Theorem and the methods outlined in \\cite{strogatz} to show its existence.\n" . 
    "Accoring to the theorem, it is necessary to create a closed, bounded subset of the plane in which there exists a trajectory which is confined in said subset.\n" .
    "This is the trapping region which we will construct.";
print ptex::subsubsection("Nullclines");
print "We begin constructing a trapping region for the limit cycle by drawing the nullclines for the system.  Starting by setting (1) and (2) equal to zero, we come up with the following equations for the nullcline" . 
    ptex::eq($xdot . " = 0 \\iff y = " . ptex::frac("(b+1)x - 1","ax^{2}")) . "\n" . 
    ptex::eq($ydot . " = 0 \\iff y = " . ptex::frac("b","ax") . "\\mbox{ or } x = 0") . "\n" . 
    "Then, with a little algebra it is easy to see that the \\(x\\)-nullcline intercepts the \\(x\\)-axis at " . ptex::inlineMath(ptex::frac(1,"b+1")) . "\n" .
    "and, using a little calculus, has a \'maximum\' which occurs in the \\(x\\mbox{-}y\\) plane at " . ptex::inlineMath(ptex::frac(2,"b+1")) . ".\n" .
    "Since \\(b>0\\), " . ptex::math(ptex::frac(1,"b+1") . "<" . ptex::frac(2,"b+1") . "< 2") . "\n" . 
    "Included below are examples of the nullclines for different values of $a and $b.\\\\\n\\\\\n";
my $null = ptex::graphic("figs/nullclines/nulls.png");

print ptex::center($null);

print "\n\nNow, noting that the direction of the flow is horizontal on the \n" . 
    ptex::inlineMath($ydot{"lhs"}) . 
    "-nullcline, and vertical on the \n" . 
    ptex::inlineMath($xdot{"lhs"}) . 
    "-nullcline, we can easily draw the following vector field, where the motion is in the clockwise direction\n";

print ptex::center(ptex::graphic("figs/dirfields/direction.png"));

print "Then, noting that the flow to the left of the \n" . 
    ptex::inlineMath($xdot{"lhs"}) . "\n" . 
    "-nullcline's \\(x\\)-intercept and below the \n".
    ptex::inlineMath($ydot{"lhs"}) . "\n" . 
    "-nullcline is always pointing in toward the fixed point, the line \n" . 
    ptex::inlineMath("x = " . ptex::frac(1,"b+1")) . "\n" . 
    "is a suitable left boundary for our trapping region, and obviously the line \n" .
    ptex::inlineMath("y = 0") . "\n" .
    "is a suitable lower boundary since \n" .
    ptex::inlineMath("y > 0") . ".\n".
    "Then, from the point where the left boundary intercepts the \n" . 
    ptex::inlineMath($ydot{"lhs"}) . "-nullcline " .
    "leftward, the flow is moving down through the line"  . " \n" .
    ptex::inlineMath("y =" . ptex::frac("b(b+1)", "a")) . "\n" .
    "(which is the horizontal line through which the left boundary intersects the " .
    ptex::inlineMath($ydot{"lhs"}) . "-nullcline) " .
    "which serves nicely as an upper boundary for our trapping region.\n" .
    "We can also select a point along the \\(x\\)-axis as a right hand boundary, and it is also easy to see " . 
    "that the flow in that region points inside the right most boundary.  We are then left with the following trapping region.";
print ptex::center(ptex::graphic("figs/dirfields/trap.png"));

print "What remains to be shown is that the dotted line from the upper boundary to the right boundary, of slope -1, actually bounds the trajectories." . 
    "  Looking at the behavior of the system as \\(x\\rightarrow\\infty\\), " .
    ptex::inlineMath($xdot{"rhs"} . "\\rightarrow ax^2y") .
    " and " .
    ptex::inlineMath($ydot{"rhs"} . "\\rightarrow -ax^2y") .
    ".  Hence, " . 
    ptex::inlineMath(ptex::frac("dy","dx") . "\\rightarrow -1") .
    " and looking at the relative size of " . ptex::inlineMath($xdot{"lhs"}) .
    " and " .
    " -" . ptex::inlineMath($ydot{"lhs"}) ;

print ptex::eq($xdot{"lhs"} ." -" . $ydot{"lhs"} . "= 1 - x");

print "Which implies that " . ptex::inlineMath($xdot{"lhs"} . "< -" . $ydot{"lhs"}) . 
    " when \\(x > 1\\), which is true for all \\(x \\ge " . ptex::frac(1,"b+1") ." > 1\\)." .
    "  Thus, the slope of the line is actually less steep than that of the trajectories, and the flow is into the region, which implies that the region in the figure is indeed a trapping region.\\\\";

print "\n\nNow, since the region constructed above is a trapping region, and the previous ". 
    "analysis suggests that the fixed point contained inside the trapping region is a source, " . 
    "we can construct an \\(\\varepsilon\\)-ball around the fixed point such that all trajectories move away from the ball.\n" .
    "  Deleting this \\(\\varepsilon\\)-ball from the trapping region leaves us with an annulus which contrains a closed trajectory " .
    "and the Poincar\\'{e}-Bendixson Theorem can now be applied to show that there does in fact exist a limit cycle for \\(b > a +1\\)";

print ptex::subsection("Hopf Bifurcation");

print "Having now shown that a limit cycle does in fact appear when the fixed point changes stability " . 
    "from a stable spiral to an unstable spiral suggests that a Supercritical Hopf Bifurcation occurs at \\(b = a + 1\\).  " .
    "In fact, plotting the function and its associated trajectories confirms this suspicion.";

print "  Letting \\(a = 1\\), we vary \\(b\\) from \\(1\\) to \\(3\\) and the results are these three direction fields and flows:\\\\\n" . 
    "\\newpage\n";
print ptex::center(ptex::graphic("figs/dirfields/dir1.png",0.5));
print ptex::center(ptex::graphic("figs/flows/flow1.png",0.25));
print ptex::center(ptex::graphic("figs/dirfields/dir2.png",0.5));
print ptex::center(ptex::graphic("figs/flows/flow2.png",0.25));
print ptex::center(ptex::graphic("figs/dirfields/dir3.png",0.5));
print ptex::center(ptex::graphic("figs/flows/flow3.png",0.25));

print "\\bibliographystyle{plain}" .
    "\\bibliography{refs}";
print ptex::endDoc();
