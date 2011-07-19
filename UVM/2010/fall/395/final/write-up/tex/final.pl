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
		"Math-395");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Tuesday, December 14, 2010",
	       "$course: \\\\Final Cipher Challenge\n");

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

print ptex::center("{\\large Cipher 1: Substitution Cipher}") . "\n" .
    "here is some stuff about some stuff\n" .
    "\\begin{quotation}\n" . 
    "it is impossible to say how first the idea entered my brain but once conceived it haunted me day and night\n" . 
    "object there was none\n" .
    "passion there was none\n" .
    "i loved the old man\n" . 
    "he had never wronged me\n" . 
    "he had never given me insult\n" .
    "for his gold i had no desire\n" . 
    "i think it was his eye\n" . 
    "yes it was this\n" . 
    "he had the eye of a vulture\n" . 
    "a pale blue eye with a film over it\n" . 
    "whenever it fell upon me my blood ran cold and so by degrees very gradually i made up my mind to take the life of the old man and thus rid myself of the eye forever\n" .
    "\\end{quotation}\n" .
    ptex::inlineMath("\\left\\{\\texttt{a}:\\: 0.0661764705882, \\texttt{c}:\\: 0.0661764705882,\\\\" .
    "\\texttt{b}:\\: 0.0245098039216, \\texttt{e}:\\: 0.0196078431373,".
    "\\texttt{d}:\\: 0.0, \\texttt{g}:\\: 0.0612745098039, \\texttt{f}:\\:".
    "0.0490196078431, \\texttt{i}:\\: 0.0514705882353, \\texttt{h}:\\:".
    "0.0245098039216, \\texttt{k}:\\: 0.00490196078431, \\texttt{j}:\\: 0.0,".
    "\\texttt{m}:\\: 0.0343137254902, \\texttt{l}:\\: 0.0612745098039,".
    "\\texttt{o}:\\: 0.0710784313725, \\texttt{n}:\\: 0.15931372549,".
    "\\texttt{q}:\\: 0.0245098039216, \\texttt{p}:\\: 0.0759803921569,".
    "\\texttt{s}:\\: 0.0686274509804, \\texttt{r}:\\: 0.0343137254902,".
    "\\texttt{u}:\\: 0.0441176470588, \\texttt{t}:\\: 0.0122549019608,".
    "\\texttt{w}:\\: 0.0, \\texttt{v}:\\: 0.0147058823529, \\texttt{y}:\\:".
    "0.0122549019608, \\texttt{x}:\\: 0.00245098039216, \\texttt{z}:\\:".
    "0.0171568627451\\right\\}");
#print "\\\\bibliographystyle{plain}" .
#    "\\\\bibliography{refs}";
print ptex::endDoc();
