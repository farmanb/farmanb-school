#!/usr/bin/perl
use warnings;
use strict;
use Cwd;
use Cwd 'abs_path';
use File::Spec::Functions;

my $root = getcwd;
my $rcs;

opendir my $dir, $root or
    die "Error: Can not open directory: $root\n";

while ($rcs = readdir $dir){
    #Discard ., .., .*, etc.
    if ($rcs =~ /^\..*$/){
	next;
    }
    
    #Create the absolute path to each of the folders
    my $path = catfile($root, $rcs);
    
    #Iterate through the directories for each RCS id.
    if (-d $path){
	opendir my $fh, $path or
	    die "Error:  Can not open directory: $path\n";

	while (my $part = readdir $fh){
	    #Discard ., .., .svn, etc.
	    if ($part =~ /^\..*$/){
		next;
	    }
	    
	    #Expand the path to include the part
	    $path = catfile($path, $part);
	    if (-d $path && $path =~ /part(A|B|C)/){
		
		#Create names for files, scenes, etc.
		my $oldApp = "HW2App-$1";
		my $oldScene = "hw2$1";
		my $app = "$oldApp-$rcs";
		my $scene = "$oldScene-$rcs";
		
		my $cmakelist = catfile($path, "CMakeLists.txt");
		
		my $oldXml = "HW2Scene-$1.xml";
		my $oldXmlPath = catfile ($path, $oldXml);
		my $xmlPath = $oldXml;
		
		#Create the new xml name
		my $xml = $oldXml;
		$xml =~ s/^(.*?)(.xml)$/$1-$rcs$2/; 

		#Create the new xml path
		$xmlPath = catfile($path, $xml);
		
		my $geomPath = catfile($path, "Geometry");
		
		#Deal with the files in the Geometry directory
		opendir my $geomfh, $geomPath or 
		    die "Error:  Can not open directory $path\n";
		
		#Iterate through and change their names.
		while (my $geomFile = readdir $geomfh){
		    my $oldGeom = $geomFile;
		    if ($geomFile !~ /$rcs/ && $geomFile =~ s/^(.*?)(.pdat)$/$1-$rcs$2/){
			$geomFile = catfile($geomPath, $geomFile);
			$oldGeom  = catfile($geomPath, $oldGeom);
			#print "rename from: \n\t$oldGeom to \n\t$geomFile\n";
			#if (!rename $oldGeom, $geomFile){
			#print "Error:  Rename from $oldGeom to $geomFile failed\n";
			#}
		    }
		}

		close $geomfh;
		
		my $geomCMake = catfile($geomPath,"CMakeLists.txt");
		if (-f $geomCMake){
		    open my $infh, '<', $geomCMake or
			die "Can not open $geomCMake for input.\n";
		    open my $outfh, '>', $geomCMake.".tmp" or
			die "Can not open $geomCMake.tmp for input\n";
		    while (my $input = <$infh>){
			chomp $input;
			if ($input =~ s/^(.*?)(.pdat)$/$1-$rcs$2/){
			    #TODO: write the changes and rename the new
			    #CMake file so it has the same name as the old one
			}
		    }
		    #print "rename from:\n\t$geomCMake.tmp to\n\t$geomCMake\n";
		}
		else{
		    #TODO: Might want to throw an error here..
		    print "$geomCMake does not exist...\n";
		}
		
		#Check if the XML file exists
		if (-f $oldXmlPath){
		    #Open the xml file and a temp output file.
		    open my $infh, '<', $oldXmlPath or
			die "Can not open $oldXmlPath for input.\n";
		    open my $outfh, '>', $xmlPath or
			die "Can not open $xmlPath for output.\n" .
			"Possibly out of space?\n";
		    
		    #Process the file
		    while (my $input = <$infh>){
			chomp $input;
			#Change the app name
			if ($input =~ s/'($oldApp)'/$app/){
			    #print "1: $1\n$input\n";
			}
			
			#Change the scene name
			if ($input =~ s/'($oldScene)'/$scene/i){
			    #print "1: $1\n$input\n";
			}

			if ($input =~ s/'(.*?)(.pdat)'/$1-$rcs$2/){
			    #print "$input\n";
			}
		    }
		    close $infh;
		    close $outfh;
		}
		else{
		    #TODO: Might want to throw some sort of error here..
		    print "$oldXmlPath DNE\n";
		}
		
		#Check if the CMakeLists.txt exists
		if (-f $cmakelist){
		    open my $infh, '<', $cmakelist or
			die "Can not open $cmakelist for input.\n";
		    open my $outfh, '>', $cmakelist . ".tmp" or
			die "Can not open $cmakelist.tmp for output.\n" .
			"Possibly out of space?\n";
		    
		    while (my $input = <$infh>){
			chomp $input;
			#Change the app name
			if ($input =~ s/($oldApp)/$app/){
			    #print "1: $1\n$input\n";
			}
			
			#Change the scene name
			if ($input =~ s/($oldXml)/$xml/i){
			    #print "1: $1\n$input\n";
			}
		    }
		    
		    #print "rename from:\n\t $cmakelist.tmp to\n\t$cmakelist\n";

		    close $infh;
		    close $outfh;
		}
		else{
		    #TODO: Might want to throw some sort of error here..
		    print "$cmakelist DNE\n";
		}
	    }
	}
	close $fh;
    }
}

close $dir;
