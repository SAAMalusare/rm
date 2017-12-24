###############################################################################
##  Copyright (c) Suhas_Malusare 2013
##  All Rights Reserved
##
##  This software contains proprietary, trade secret information
##  and is the property of Suhas_Malusare.  This software and the
##  information contained therein may not be disclosed, used or
##  copied in whole or in part without the express, prior, written
##  consent of Suhas_Malusare.
###############################################################################
##
## This script will create the Stream & view (Snapshot & Dynamic) on requested
## project.
###############################################################################
##				Release History . Dev Branch
##=============================================================================
##	04/16/2013 Suhas S Malusare : Initial Release of Version 1.0
##=============================================================================
##	04/18/2013 Suhas S Malusare : Initial Release of Version 1.0 	 	
###############################################################################

	use strict;
	use File::Basename;
	use File::Path;
	use Getopt::Long;
	use sc_mksv;
	use Tk;
	require Tk::Font;
	use Tk::Dialog;
	
#perl2exe_include "Tk/Checkbutton.pm";
#perl2exe_include "Tk/Radiobutton.pm";
#perl2exe_include "Tk/DialogBox.pm";
#perl2exe_include "utf8.pm";
#perl2exe_include "Tk/Scrollbar.pm";

	system "cls";
	my 	($proj_name, $rid, $pt, $sv, $vt);
	my 	$debug = 'n';

	print	"\n*******************************************************************";
	print	"\nExecuting : ". basename($0).' : '. scalar localtime();
	print	"\n*******************************************************************";
	
	###############################################################################
	# Get command line options and check them
	###############################################################################
		GetOptions	(	
						'psn=s' 	=> \$proj_name,		# Project Name.
						'rid=s' 	=> \$rid,			# Release ID.
						'pt=s' 		=> \$pt,			# Project Type.
						'sv=s' 		=> \$sv,			# Stream or View.
						'vt=s' 		=> \$vt,			# View Type : Dynamic or Snapshot.
						'd=s' 		=> \$debug,			# Debugging Script.
					);
	
		$debug = lc $debug if $debug;
	
	if 	($proj_name and $rid)
		{
			my 	$pvob .= $proj_name.'_pvob';
				$pt='P', if !$pt;
				$pt = uc $pt;
				$vt = 'd', if !$vt;
				$sv = 'sv' if !$sv;
			
			my 	$DS = 'Dynamic' if $vt eq 'd';
				$DS = 'Snapshot' if $vt eq 's';
			
			my 	$SV = 'Stream & View' if $sv eq 'sv';
				$SV = 'View' if $sv eq 'v';
			
			if 	(length ($proj_name)>6)
				{
					print	 "\nError : Short Project name should not exceed 6 Characters"; usage()
				}
			if 	($proj_name=~/\W+/)
				{
					print	 "\nError : Short Project name should not contain special characters"; usage()
				}
					
			if ($debug eq 'y')
				{
					print	"\n\n----------------- Debugging Mode Enabled --------------------------";
					print	"\n\n*******************************************************************";		
				}		
			print	"\nPVOB name	: $pvob";
			print	"\nProject name	: $proj_name ";
			print	"\nRelease ID	: $rid ";
			print	"\nProject type	: $pt";
			print	"\nCreating	: $SV";
			print	"\nView Type	: $DS";
			print	"\n*******************************************************************";		
			my 	$scm_obj = sc_mksv->new();
				$scm_obj->process_req($pvob, $proj_name, $rid, $pt, $sv, $vt, $debug);
		}
	elsif ($proj_name and !$rid)
		{
			print	 "\nError : Please provide release ID", usage()
		}
	elsif (!$proj_name and $rid)
		{
			print	 "\nError : Please provide Short project name", usage()
		}
	elsif (!$proj_name and !$rid)
		{
		}			
	
	print "\nExecution Successful....";
	print "\n*******************************************************************\n";	
	
	sub usage
		{
			print	"\n*******************************************************************";
			print "\nUsage: ";
   			print "\n\tMkSV.exe -psn XV91x -rid 2.5.0 -pt p -sv v -vt d";
    		print "\nwhere:\n";
    
    		print "-psn	Product Short name	Mandatory	[length should not exceed 6 characters, No special characters are allowed.]\n";
    		print "-rid	Release ID		Mandatory	[Release ID must contain \. e.g. 1.1.0]\n";
    		print "-pt	Project Type		Optional 	[Joining P or T project, by default it selects P-Project]\n";
    		print "-sv	Stream and/or View	Optional 	[Creat Stream (s) and or view (v), by default it creates Stream & view]\n";
    		print "-vt	type of View		Optional 	[Creat dynamic (d) or Snapshot (s) view, by default it creates dynamic view]";
    		print	"\n*******************************************************************";
    		exit;
		}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	