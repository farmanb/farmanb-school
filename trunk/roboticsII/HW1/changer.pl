#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;

opendir my $dir, './' or die "Error: Can not open directory ./\n";

my $examplesDir;

GetOptions(
    "e=s" => \$examplesDir)
    or die "Invalid parameters: $!\n";

my $rcs;
my %files;

#Get the list of subdirs in the cmake file to prevent
    #adding too many
my @subdirs;
open my $cmakefh, '<', $examplesDir . "CMakeLists.txt" or die "Can not open CMakeLists.txt for output.\n";

while (my $input = <$cmakefh>){
    chomp $input;
    push(@subdirs, $input);
}

close $cmakefh;

while ($rcs = readdir $dir){
    #Don't worry about ., .., .svn, etc.
    if ($rcs =~ /^\..*$/){
	next;
    }
    
    if (-d $rcs){
	my $found = 0;
	foreach my $i (@subdirs){
	    if ($i =~ $rcs){
		$found = 1;
		last;
	    }
	}

	if (!$found){
	    open $cmakefh, '>>', $examplesDir . "CMakeLists.txt" or die "Can not open CMakeLists.txt for output.\n";

	    print $cmakefh "add_subdirectory($rcs)\n";
	
	    close $cmakefh;
	}
	
	my $subDirName = "./" . $rcs;
	opendir my $subDir, $subDirName, or die "Error:  Can not open directory $subDirName\n";
	
	while (my $part  =  readdir $subDir){
	    
	    if ($part =~ /^\..*$/){
		next;
	    }
	    
	    if (!(-d ($subDirName . "/" . $part))){
		next;
	    }
	    
	    my @parts;
	    if (-f $subDirName . "/CMakeLists.txt"){
		open $cmakefh, '<', $subDirName . "/CMakeLists.txt" or die "Can not open CMakeLists.txt for output.\n";
		while (my $input = <$cmakefh>){
		    chomp $input;
		    push(@parts, $input);
		}
	    }

	    $found = 0;
	    foreach my $i (@parts){
		if ($i =~ $part){
		    $found = 1;
		    last;
		}
	    }
	    
	    
	    if (!$found){
		open $cmakefh, '>>', $subDirName . "/CMakeLists.txt" or die "Can not open CMakeLists.txt for output.\n";
		
		print $cmakefh "add_subdirectory($part)\n";
	    
		close $cmakefh;
	    }

	    my $cmakeList = $subDirName . "/" . $part . "/" . "CMakeLists.txt";
	    my $sceneName = $subDirName . "/" . $part . "/" . "HW1Scene.xml";
	    if (-f $sceneName){
		open my $infh, '<', $sceneName or die "Error:  Can not open $sceneName for input\n";
		open my $outfh, '>', $sceneName . '-NEW' or die "Error: Can not open $sceneName-NEW for output\n";
		while (my $line = <$infh>){
		    chomp $line;
		    $line =~ s/(<pref name='active_scene' type='string' value=').*?('\/>)/$1$rcs-$part$2/;
		    if ($line =~ /scenes/){
			print $outfh $line . "\n";
			$line = <$infh>;
			$line =~ s/(<pref name=\').*?(\'>)/$1$rcs-$part$2/
		    }
		    $line =~ s/(<pref name='app_plugin' type='string' value=').*?('\/>)/$1$rcs-$part-app$2/;
		    print $outfh $line . "\n";
		}
		
		close $infh;
		close $outfh;
		rename "$sceneName-NEW", $sceneName;
	    }
	    else{
		print "Error:  $sceneName is not a scene!\n";
	    }
	    if (-f $cmakeList){
		open my $infh, '<', $cmakeList or die "Error:  Can not open $cmakeList for input\n";
		open my $outfh, '>', $cmakeList . '-NEW' or die "Error: Can not open $cmakeList-NEW for output\n";
		while (my $line = <$infh>){
		    chomp $line;
		    $line =~ s/(set\(APP_NAME\s+).*?(\))/$1$rcs-$part-app$2/;
		    $line =~ s/(scenes\/).*?(\.xml)/$1$rcs-$part-scene\.$2/;
		    print $outfh $line . "\n";
		}
		
		close $infh;
		close $outfh;
		
		if (!rename "$cmakeList-NEW", $cmakeList){
		    print "Error:  Rename from $cmakeList-NEW to $cmakeList failed.\n";
		}
	    }
	    else{
		print "Error:  $cmakeList is not a CMake List!\n";
	    }
	}
	close $subDir;
	
	
    }
}

close $dir;
    
