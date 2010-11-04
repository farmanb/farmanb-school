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
    $course) = (7, 
		"Math-395");

#Title page
my $school = "University of Vermont";
my ($author,
    $date,
    $title) = ("Blake Farman", 
	       "Friday, October 15, 2010",
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

print "The rewards reaped by the Allies in World War II through the use of Ultra seem incontrovertible.\n" . 
    "From the ability to track U-boat movement in the north Atlantic, to the prediction of preparations made by the Germans against landings in Normandy, there is no doubt the Allies were able to put Ultra to great use.\n" . 
    "However, pertaining to its efficacy, it seems entirely absurd to make the claim that Ultra either was solely responsible for their victory or had no bearing on their victory." . 
    "\n\n" . 
    "On the one hand, both Hinsley\\cite{Hinsley} and K\\\"orner\\cite{Koerner} make the case for sufficiency of Ultra given the circumstances of the Allies' armed forces.\n" . 
    "K\\\"orner makes a lucid argument for the effective use of Ultra to mitigate the tonnage lost during shipping through the north Atlantic.\n" . 
    "The Allies, by deciphering the communications of the German Navy, were able not only to reroute shipping to avoid U-boats, but also to hunt down the \'Milch Cows\' used by D\\\"onitz to command those U-boats.\n" .
    "The figures presented by K\\\"orner elucidate this effect on the reduction in ships lost, thereby increasing the tonnage of material capable of being moved across the Atlantic, which would prove instrumental to the Allied victory.\n" . 
    "\n\n" . 
    "Hinsley makes similar arguments for the usage of Ultra concerning ground forces.\n" . 
    "The first argument is that which outlines the mitigation of Allied losses to Rommel in Africa.\n" . 
#"as well as its benefits during the landings in Normandy.\n". 
    "The Allies are able to stymie Rommel's offensive in the desert not by brute force, but by the interception of details regarding his supply routes.\n" . 
    "With the knowledge of the supply routes, the Allies are able to effectively cut out almost 41\\%\\cite{Hinsley} of Rommel's fuel reserves.\n" . 
    "Without the necessary aid, Rommel is incapable of pushing further forward and is thus effectively stalled.\n" . 
    "Furthermore, the argument is made for Ultra playing an important role in determining where to land on the beaches of Normandy.\n" . 
    "The knowledge of the German defensive plan provides for the Allies being able to predict not only the size, but also the direction of the German response,\n" . 
    "which allows them a substantial advantage." . 
    "\n\n" . 
    "However, neither Hinsley nor K\\\"orner make arguments for necessity.\n" .
    "In fact, Hinsley even makes the argument against the necessity of Ultra.\n" . 
    "Namely, Hinsley wrote: \n" .  
    "\\begin{quotation}" . 
    "In attempting that assessment we may at once dismiss the claim that Ultra by itself won the war.\n" . 
    " The British survived with little benefit from it before Germany invaded the Soviet Union in June 1941, as the Soviets survived the first German offensives without any benefit from it, so far as we know;\n" . 
    " and since those offensives were followed by the entry of the United States into the war in December 1941 we may safely conclude the Allies would have won even if Ultra had not given them by that time\n" . 
    "the superiority in intelligence which they retained till the end of the war.\n". 
    "\\end{quotation}" . 
    "Effectively, given the circumstance of the Allied armed forces, it would appear as though the war could have been won even without Ultra.\n" . 
    "Furthermore, K\\\"orner notes the German Naval Intelligence had broken the cipher used by the US and Royal Navies to communicate, yet still were unable to turn the tide of the battle in the Atlantic.\n" .
    "This would suggest that Ultra alone is not sufficient to guarantee victory.\n" .
    "\n\n" .
    "Hence, although the contributions of Ultra were non-trivial, and most likely both shortened the war and minimized casualties, it does not appear as though it was a necessary condition for victory.\n" . 
    "Moreover, it would seem entirely illogical to conclude that if the Allied armed forces were wholly outmatched by the Germans, that Ultra would have been a singularly sufficient condition for victory."; 

print "\\newpage\n" . 
    "\\bibliographystyle{plain}" .
    "\\bibliography{refs}";
print ptex::endDoc();
