#!/usr/bin/env perl
use strict;
use warnings;

use lib '/Users/blake/hacking/perl/modules/';
use ptex;

#Preamble
my $documentClass = "article";
my @docClassArgs = ("10pt");
my @texPackages = ("graphicx","enumerate", "amsmath", "amsthm", "fancyhdr");

#Cover Page info.
my ($num,
    $course) = 
    (8, "Math-273");

#Title page
my $school = "University of Vermont";
my ($author,
    $title) = ("", 
	       "$course: Homework $num\\\\\n$school\\\\\nSolutions");
my $p = {
    "docClass" => $documentClass,
    "docArgs" => \@docClassArgs,
    "pkgs" => \@texPackages,
    "title" => $title,
    "author" => $author,
    "date" => "Tuesday, February 16, 2010",
    "isCP" => 0,
    "other" => "\\pagestyle{fancy}" . 
	"\\rfoot{Blake Farman}"
};

print ptex::preamble($p);

my $name = "1.3.12\n";
my $thm = "Prove that an even graph has no cut-edge.  For each \\(k \\geq 1\\), construct a \\(2k+1\\)-regular simple graph having a cut-edge.\n";
my $pf = "Let \\(G\\) be a graph where each vertex, \\(v \\in V(G)\\), has an even degree.\n" . 
    "  \\(G\\) is either connected or \\(G\\) is disconnected.\n\n". 
    "  If \\(G\\) were connected, then \\(G\\) would have an Euler circuit and thus every edge would be in a cycle.\n" . 
    "  An edge is a cut edge if and only if that edge does not belong to a cycle, hence \\(G\\) would have no cut-edge.\n\n" . 
    "  If \\(G\\) were disconnected, then \\(G\\) would have \\(k \\geq 2\\) connected components and each of the vertices of \\(G\\) would still have even degree.\n" . 
    "  Consider each component of \\(G\\) as its own graph.\n" . 
    "  In each of these subgraphs, every vertex would have an even degree and thus each subgraph would contain an Euler circuit.\n" . 
    "  Hence, \\(G\\) would have no cut-edge.\n\n". 
    "  Therefore, all edges are contained in a cycle and \\(G\\) has no cut-edge.\\\\\n\n". 
    "  To construct a \\(2k+1\\)-regular graph, start with \\(K_{2k+2}\\).\n" . 
    "  Let \\(M\\) be a perfect matching in \\(K_{2k+2}\\) and let \\(G = K_{2k+2} - M\\).\n" . 
    "  \\(G\\) is \\(2k\\)-regular on \\(2k+2\\) vertices.\n" . 
    "  Add one vertex, \\(v\\), to the vertex set of \\(G\\) and connect \\(v\\) to any \\(2k+1\\) vertices to \\(v\\).\n" . 
    "  Now, \\(G\\) has \\(2k+2\\) vertices of degree \\(2k+1\\) and one vertex of degree \\(2k\\).". 
    "  Let \\(G'\\) be an exact copy of \\(G\\).\n" . 
    "  Both \\(G\\) and \\(G'\\) have exactly one vertex of degree \\(2k\\).\n" . 
    "  Add an edge between these two vertices.  Now, \\(G \\cup G'\\) is \\(2k+1\\)-regular with the cut edge being the edge between \\(G\\) and \\(G'\\).\n";    

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "1.3.13\n";
$thm = "A mountain range is a polygonal curve from \\((a,0)\\) to \\((b,0)\\) in the upper half-plane.  Hikers \\(A\\) and \\(B\\) begin at \\((a,0)\\) and \\((b,0)\\), respectively.\n" . 
    "  Prove that \\(A\\) and \\(B\\) can meet by traveling on the mountain range in such a way that at all times their heights above the horizontal axis are the same.\n";
$pf = "Let \\(U\\) be the set of points \\((x,y)\\) corresponding to the bottoms of valleys and \\(P\\) be the set of points \\((x,y)\\) correspoinding to tops of peaks.\n" .
    "  Construct the vertex set for the graph in the following way.\n\n" . 
    "  Start by constructing a vertex, \\(S = (a,0)(b,0)\\), from the points \\((a,0)\\) and \\((b,0)\\).\n" . 
    "  Now, for each \\(p = (x_p,y_p) \\in P\\), draw a line \\(y = y_p\\) in the upper half-plane.\n" . 
    "  Select any two distinct points, \\((x_1, y_p) \\text{ and } (x_2, y_p)\\) with \\(x_1 < x_2\\), where the line intersects the polygonal curve, then create a vertex, \\(pq\\).\n" . 
    "  Do the same for each \\(u = (x_u, y_u) \\in U\\).\n" . 
    "  Finally, for each \\(p \\in P\\), create a vertex \\(pp\\) and for each \\(u \\in U\\), create a vertex \\(uu\\).\n" . 
    "  Each vertex, \\(pq\\), represent the possible positions, \\(p\\) and \\(q\\), for the two climbers, \\(A\\) and \\(B\\).\n\n" . 
    "  Using the constructed vertex set, construct the edge set as follows.\n" . 
    "  Given any two vertices, \\(pq\\) and \\(st\\), if there is a path along the mountain which \\(A\\) can follow from \\(p\\) to \\(s\\) " . 
    "and \\(B\\) can follow from \\(q\\) to \\(t\\), without passing through another point along the mountain, make \\(pq\\) and \\(st\\) adjacent.\n\n" . 
    "  Now, consider any vertex \\(pq\\).\n " . 
    "  Exactly one of the following hold.\\\\\n\n" . 
    "i) \\(p\\) and \\(q\\) are both peaks or are both valleys.\n\n" .
    "ii) Exactly one of \\(p\\) and \\(q\\) is a peak or valley.\n\n" .
    "iii) Neither of \\(p\\) and \\(q\\) are peaks or valleys\n\n" .
    "iv) \\(p\\) and \\(q\\) are the same point\n\n" .
    "v) \\(p = (a,0)\\) and \\(q = (b,0)\\)\\\\\n\n" . 
    "If (i), then \\(A\\) and \\(B\\) both have two degrees of horizontal freedom.\n" . 
    "  \\(A\\) and \\(B\\) must both move down (if \\(p\\) and \\(q\\) are both peaks) or up (if \\(p\\) and \\(q\\) are both valleys), but they may each move either left or right independent of the other.\n" .
    "  Hence, \\(pq\\) has degree 4.\n\n" .
    "If (ii), then either \\(A\\) or \\(B\\) have two degrees of horizontal freedom, but the other has only one.\n" . 
    "  In either case, they must both move in the same vertical direction, but one has the freedom to move left or right.\n" . 
    "  Hence, \\(pq\\) has degree 2.\n\n" .
    "If (iii), then \\(A\\) and \\(B\\) have no horizontal freedom, but they have two degrees of vertical freedom.\n" . 
    "  They may both move up, or they may both move down\n" . 
    "  Hence, \\(pq\\) has degree 2.\n\n" . 
    "If (iv), then there must only be one way into that vertex and one way out.  Hence, \\(pq\\) has degree 1.\n\n" . 
    "If (v), then the only choice is to move up to the next vertex.  Hence, \\(pq\\) has degree 1.\n\n".
    "  Observe that no matter how the mountain range is drawn, there will always be 1 more peak than valley.\n" . 
    "  Thus, the sum of vertices of type (iv) must be an odd number.\n" . 
    "  Adding in the starting vertex, there will always be an even number of odd vertices.\n\n" . 
    "  Now, consider any connected component of the graph which contains the starting vertex.\n" . 
    "  Since this vertex has an odd degree, there must be at least one other odd vertex in the same component, and any further odd vertices must be added in pairs.\n" . 
    "  These vertice are necessarily of type (iv) above.\n" . 
    "  Since these two vertices are in the same connected component, there necessarily exists a path from the starting vertex to some peak or valley at which \\(A\\) and \\(B\\) will meet.\n";
#\\(q = (x,y_p)\\) and construct a vertex \\(pq\\).\n" . 
#"For any mountain range, let \\(m\\) be the number of valleys and let \\(n\\) be the number of peaks.\n" . 
#and \\(u = (x_u, y_u) \\in U\\)
#and \\((x,y_u)\\)

print ptex::thm($name, $name, $thm . ptex::pf($pf));


$name = "2.1.4\n";
$thm = "Prove or disprove:  Every graph with fewer edges than vertices has a component that is a tree.\n";
$pf = "Let \\(G\\) be a graph such that \\(|E(G)| < V(G) = n\\).\n" . 
    "  If \\(G\\) were connected, \\(G\\) would be a tree by theorem 2.1.4B.\n\n" . 
    "  If \\(G\\) were disconnected, consider the components of \\(G\\).\n" .
    "  Since there are at most \\(n-1\\) edges, no matter how they would be divided amongst the connected components, there would always be one with fewer edges than vertices." . 
    "  Hence, \\(G\\) would have a component which would be a tree.\n\n" .
    "  Therefore, there exists at least one connected component which is a tree.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.1.18\n";
$thm = "Prove that every tree with maximum degree \\(\\Delta > 1\\) has at least \\(\\Delta\\) vertices of degree 1.\n" . 
    "  Show that this is best possible by constructing an \\(n\\)-vertex tree with exactly \\(\\Delta\\) leaves, for each choice of \\(n\\) ,\\(\\Delta\\) with \\(n > \\Delta \\geq 2\\).\n";
$pf = "Let \\(T\\) be a tree with \\(\\Delta(T) > 1\\).\n" . 
    "  Let \\(v \\in V\\) be such that deg(\\(v\\)) = \\(\\Delta\\).\n" . 
    "  Given that \\(T\\) is a tree, \\(v\\) is connected to \\(\\Delta\\) distinct vertices, \\(u_1, u_2, \\ldots, u_{\\Delta} \\in V(T)\\).\n" . 
    "  For each \\(i = 1,2,\\ldots, \\Delta\\), let \\(P_i\\) be a maximal path originating at \\(u_i\\) and ending at some vertex \\(v_i \\in V(T)\\).\n\n" . 
    "  Suppose the vertex \\(v_i\\) at the end of any \\(P_i\\) were not a leaf.\n" . 
    "  \\(T\\) is a tree so, in order to preserve its acyclic property, \\(v_i\\) would be adjacent to some vertex which is not part of \\(P_i\\).\n" . 
    "  This would contradict the assumption that \\(P_i\\) is a maximal path.\n" . 
    "  Hence, each \\(v_i\\) must be a leaf.\n\n" . 
    "  All that remains is to show that these \\(v_i\\) are distinct.\n" . 
    "  Suppose that for each \\(i = 1,\\ldots,\\Delta\\), \\(v_i\\) were not unique.\n" .
    "  Then there would exist some \\(j \\not = i\\) such that \\(v_j = v_i\\).\n". 
    "  This implies there would be two paths, \\(P_i \\not = P_j\\), with endpoints \\(u_i \\not = u_j\\) and \\(v_i = v_j\\).\n" . 
    "  Observe that \\(u_i\\) and \\(u_j\\) are both adjacent to \\(v\\), so there would be two paths, \\(P_i\\) and \\(P_j\\) from \\(v\\) to \\(v_i = v_j\\).\n". 
    "  This would contradict the assumption that \\(T\\) is a tree.\n" . 
    "  Hence, each \\(v_i\\) must be distinct.\n\n".
    "  Therefore, there exist at least \\(\\Delta\\) distinct leaves in \\(T\\).\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

$name = "2.1.29\n";
$thm = "Every tree is bipartite.  Prove that every tree has a leaf in its larger partite set (in both if they have equal size).\n";
$pf = "Let \\(T\\) be a tree and let \\(A,B\\) be the bipartition of \\(T\\).\n" . 
    "  Since \\(T\\) is bipartite, \\({\\sum_{a \\in A} \\text{deg}(a)} = {\\sum_{b \\in B} \\text{deg}(b)}\\).\n". 
    "  Hence, \\[|E(T)| = {\\sum_{a \\in A} \\text{deg}(a)} = {\\sum_{b \\in B} \\text{deg}(b).}\\]\n" . 
    "  Assume \\(|A| \\geq |B|\\) and \\(A\\) does not contain any leaves.\n" . 
    "  Then \\[|E(T)| = {\\sum_{a \\in A} \\text{deg}(a)} \\geq 2|A| = |A| + |A| \\geq |A| + |B| = |V(T)|.\\]\n" . 
    "  This contradicts the property that \\(T\\)  has \\(|V(T)| - 1\\) edges.\n". 
    "  Therefore, the larger partite set must contain at least one leaf.\n";

print ptex::thm($name, $name, $thm . ptex::pf($pf));

print ptex::endDoc();
