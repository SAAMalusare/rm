package tk_mksv;

use strict;
use Win32;
use Tk;
require Tk::Font;
use Tk::Dialog;
#perl2exe_include "Tk/Checkbutton.pm";
#perl2exe_include "Tk/Radiobutton.pm";
#perl2exe_include "Tk/DialogBox.pm";
#perl2exe_include "utf8.pm";
#perl2exe_include "Tk/Scrollbar.pm";

	my	$cnt = 0;
	my 	$st_cnt = 0;
	my 	($rb_val, $vt);
	my 	($p_typ, $t_typ) = (1,0);
	

	


	sub new
		{
			my 	$self = {};
			return bless $self
		}

	sub	generate_gui
		{
			my 	$self=shift;
			my 	$mw = MainWindow->new;
				$mw->geometry("550x450");
				$mw->resizable(0,0);
				$mw->title("Suhas_Malusare Inc. Version 1.0");
	
			my  $Logo_font = $mw->Font(-family=> 'Georgia', -size  => 18);
			my  $lbl_font = $mw->Font(-family=> 'Georgia', -size  => 12);
			my  $link_font = $mw->Font(-family=> 'Georgia', -size  => 9);
			my  $foot_font = $mw->Font(-family=> 'Georgia', -size  => 9);
	
			my 	$top_frame = $mw->Frame(-borderwidth => 5,-background => "Blue", -relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$top_frame->Label(-text => "Create Development Stream.", -background => "blue", -foreground => "White", -font => $Logo_font)
						  ->pack(-side => "top", -pady =>8, -padx=>8);
			
			
			my 	$II_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$II_frame->Label(-text => "Short Product Name", -font => $lbl_font)
						  ->pack(-side => "left", -pady =>8, -padx=>8);
			my 	$proj_box = $II_frame->Entry(-background => "#ffffcc",-font => $lbl_font, -validate => 'key', -validatecommand=> sub { length( $_[0] ) <= 6 ? 1 : 0 })->pack(-side => "left", -pady =>8, -padx=>8);		  
						  
			
			my 	$III_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$III_frame->Label(-text => "Release ID", -font => $lbl_font)
						  ->pack(-side => "left", -pady =>8, -padx=>8);
			my 	$release = $III_frame->Entry(-background => "#ffffcc",-font => $lbl_font)->pack(-side => "left", -pady =>8, -padx=>75);			  
			
			my 	$IV_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$IV_frame->Label(-text => "Project type", -font => $lbl_font)
						  ->pack(-side => "left", -pady =>8, -padx=>8);
				$IV_frame->Checkbutton(-text =>'P-Project', -variable=> \$p_typ, -font => $lbl_font)->pack(-side => "left", -padx => 62);
				$IV_frame->Checkbutton(-text =>'T-Project', -variable=> \$t_typ, -font => $lbl_font)->pack(-side => "left");
			
			
			my 	$V_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$V_frame->Label(-text => 'Create      ', -font => $lbl_font)
						  ->pack(-side => "left", -pady =>8, -padx=>8);
				$V_frame->Radiobutton(-text =>'Stream & View', -value=>'sv', -variable=>\$rb_val, -font => $lbl_font)->pack(-side => "left", -padx =>73);
				$V_frame->Radiobutton(-text =>'Only View', -value=>'v', -variable=>\$rb_val, -font => $lbl_font)->pack(-side => "left");
			
			
			my 	$IX_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$IX_frame->Label(-text => "View Type", -font => $lbl_font)
						  ->pack(-side => "left", -pady =>8, -padx=>8);
				$IX_frame->Radiobutton(-text =>'Dynamic', -value=>'d', -variable=>\$vt, -font => $lbl_font)->pack(-side => "left", -padx =>70);
				
				$IX_frame->Radiobutton(-text =>'Snapshot', -value=>'s', -variable=>\$vt, -font => $lbl_font)->pack(-side => "left");
			
			
			my 	$VI_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$VI_frame->Button(-text => "Run",-font => $lbl_font, -command => $self->get_usr_input($proj_box, $release, $mw))->pack(-side => "left",-expand => 1, -ipady =>3, -ipadx => 5);
				
				$VI_frame->Button(-text => "Exit",-font => $lbl_font, -command =>sub {exit})->pack(-side => "left",-expand => 1, -ipady =>3, -ipadx => 5);
			
			
			my 	$VII_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side => 'top', -fill => 'x');
				
				my 	%url =	(
								'Click here to redirect yourself @ SCM Support Forms' => 'http://techhub.Suhas_Malusare.com/teams/engineering_ops/tools/Rational/SCM%20Support%20Forms/Forms/Preview%20Not%20Closed.aspx'
							);
					
				foreach my $key (keys %url)
					{	
						$VII_frame->Button(
									           -textvariable => \$key,
									           -fg => '#0000FF',
									           -relief => 'flat',
									           -font => $link_font,
									           -command => sub{system('Start', $url{$key})},
									        )->pack(-anchor => 'se');	
					}
			
			my 	$VIII_frame = $mw->Frame(-borderwidth => 3)->pack(-side => 'top', -fill => 'x');
				$VIII_frame->Label(-text => "Developed & maintained by Suhas_Malusare SCM team @ 2013.",-font => $foot_font)
						  ->pack(-side => "right");
		
		}
					
	sub	get_usr_input
		{
			my 	$self=shift;
			my 	($proj_box, $release, $mw)=(@_);
			my	$prod = $proj_box->get(); chomp $prod;
			my	$rel = $release->get();
			
			if 	(!$prod)
				{
					my 	$d=$mw->Dialog(-title => "Product Name Error", -text => "Product Name can not be blank!!");
						$d->Show;
				}
			elsif 	(! $rel)
				{
					my 	$d=$mw->Dialog(-title => "Release Number Error", -text => "Release ID can not be blank!!");
						$d->Show;
				}
			elsif 	($rel!~/(^\d+\.\d+\.\d+\.*\d*)$/)
				{
					my 	$d=$mw->Dialog(-title => "Release Number Error", -text => "Release ID Should contain only numbers & \., \ne.g.: 1.0.0");
						$d->Show;
				}	
			elsif($p_typ == 0 and $t_typ == 0)
				{
					my 	$d=$mw->Dialog(-title => "Project Type Error", -text => "Please make atlease one selection from Project Type!!");
						$d->Show;
				}		
			elsif(! $rb_val)
				{
					my 	$d=$mw->Dialog(-title => "Error", -text => "Create \'Stream with view\' or Create \'Only View\' ?");
						$d->Show;
				}
			elsif(! $vt)
				{
					$vt = 'd';
				}				
			elsif 	($prod!~/\W/i)
				{
					my 	$pvob = "$prod".'_pvob';
					my 	$product_stream = "$prod"."$p_typ"."$rel";
					my 	$typ;
					print	"\n*******************************************************************";
					print	"\nExecuting : $0 : ". scalar localtime();
					print	"\n*******************************************************************";
				 	print	"\nPVOB name	: $pvob";
					print	"\nProduct name	: $prod ";
					print	"\nRelease ID	: $rel ";
					
					if 	($p_typ ==1)
						{
							$typ = 'P';
							$product_stream = "$prod".'.'."$typ"."$rel";			
						}
					elsif($t_typ ==1)
						{
							$typ = 'T';
							$product_stream = "$prod".'.'."$typ"."$rel";
						}	
					
					my 	$username = Win32::LoginName;
					my 	$tag = "$username\_$product_stream"; 
					
					if 	($rb_val eq 'sv')
						{
							my 	($flag) = chk_stream($username, $pvob, $product_stream, $vt, $tag);
							
							if 	($flag eq 'S')
								{
									mkstream($pvob, $product_stream, $username, $tag, $vt, $mw)				
								}
						}
					else
						{
							my 	($flag) = chk_stream($username, $pvob, $product_stream, $vt, $mw);
							if 	($flag eq 'S')
								{
										$tag = chk_view($username, $product_stream, $tag);
									mkview($pvob, $product_stream, $username, $tag, $vt, $mw)				
								}
						}
				}
			else
				{
					my 	$d=$mw->Dialog(-title => "Product name validation error", -text => "Only Alfa-Numeric characters are permitted here.");
						$d->Show;
				}	
		}

	sub chk_stream
		{
			my 	($username, $pvob, $product_stream, $vt, $tag) = (@_);
			my 	$proj_desc_cmd = 'cleartool desc -l project:'."$product_stream".'@\\'."$pvob";
			my 	$proj_desc = `$proj_desc_cmd 2>&1`;
			
				$proj_desc=~s{(^.+?integration\s+stream:)(.+?pvob)(.+?$)}
							 {
							 	$2
							 }exgsi;
				$proj_desc=~s/\s+//g;
			
			print	"\nInt Stream Name : $proj_desc";
			print	"\n-------------------------------------------------------------------";
			
			my 	$strm_desc = `cleartool desc -l stream:$proj_desc 2>&1`;
			
				$strm_desc=~s{(^.+?development\s+streams:)(.+?)(contains\s+activities:.+?$)}
							 {
							 	$2
							 }exgsi;
			
			my 	%dev_streams=();
			
				$strm_desc=~s{($username.+?$pvob\n)}
							 {
							 	$dev_streams{$1}=1;
							 }exgsi;
			
				$dev_streams{'Create New Stream'}=1;
				
				my 	$str_cnt = scalar keys %dev_streams;
				
				if ($str_cnt <= 1)
					{
						return 'S' # Return S as there is only one dev stream present for current user. 
					}
				else
					{
						print	"\nMultiple Dev streams found !!!";
						print	"\n-------------------------------------------------------------------";
						disp_multiple_streams($username, $pvob, $product_stream, \%dev_streams, $vt, $tag)
					}	
				
				
		}

	sub	chk_str_II
		{
			my 	($username, $pvob, $product_stream, $vt, $tag, $st_cnt, $mw) = (@_);
			
			my 	$cmd = "cleartool lsstream stream:$username\_$product_stream\@\\$pvob", if $st_cnt==0;
				$cmd = "cleartool lsstream stream:$username\_$st_cnt\_$product_stream\@\\$pvob", if $st_cnt >0;
			my 	$ls_str = `$cmd 2>&1`;
			
			if 	($ls_str !~/stream\s+not\s+found/)
				{
					$st_cnt++;
					chk_str_II($username, $pvob, $product_stream, $vt, $tag, $st_cnt, $mw)
				}
			else
				{
					mkstream($pvob, $product_stream, "$username\_$st_cnt", $tag, $vt, $mw) 
				}
		}

	sub	mkstream
		{
			my 	($pvob, $proj_name, $username, $tag, $vt, $mw)=(@_);
			
			print	"\nCreating Development Stream on Project $proj_name";
			print	"\n-------------------------------------------------------------------";
			
			my 	$mkstream_cmd = 'cleartool mkstream -in '."$proj_name\@\\$pvob $username\_$proj_name\@\\$pvob";
			my 	$result =  `$mkstream_cmd 2>&1`;
			
			if	($result!~m/Error/gs)
				{
					my 	$d=$mw->Dialog(-title => "Success", -text => "$result", -buttons => [ qw/ Exit / ]);
				}
			else
				{
					my 	$d=$mw->Dialog(-title => "Error!!!", -text => "Error Desc : $result", -buttons => [ qw/ Exit / ]);
					if ($d->Show eq 'Ok') 
						{
							exit
						}
				}				 
			
			($tag) = chk_view($username, $proj_name, $tag);
					 mkview($pvob, $proj_name, $username, $tag, $vt, $mw)
		}

	sub	chk_view
		{
			my 	($username, $proj_name, $tag)=(@_);
			my	$chk_result = `cleartool lsview $tag 2>&1`;
				return if !$chk_result; 
				chomp $chk_result;
			
			if	($chk_result!~m/Error/gs)
				{
					$cnt++;
					chk_view($username, $proj_name, "$username\_$proj_name\_$cnt")	
				}
			else
				{
					return $tag;
				}	
		} 
	
	sub	mkview
		{
			my 	($pvob, $proj_name, $username, $tag, $vt, $mw)=(@_);
			
			if 	($vt eq 'd')
				{
					print	"\nCreating Dynamic view : $tag";
					print	"\n-------------------------------------------------------------------";
					my	$mkview_cmd = 'cleartool mkview -str '."$username\_$proj_name\@\\$pvob -tag $tag -stgloc -auto";
					my 	$result =`$mkview_cmd 2>&1`;
					
					if	($result!~m/Error/gs)
						{
							st_end_vw($tag, 'E', $mw);
							st_end_vw($tag, 'S', $mw);
							
							my 	$d=$mw->Dialog(-title => "Success Message", -text => "$result", -buttons => [ qw/ Ok / ]);
							if ($d->Show eq 'Ok') 
								{
									exit
								}
						}
					else
						{
							if 	($result =~m/unable\s+to\s+find\s+stream/gi)
								{
									my	$popup = 'You don’t have any development stream for this product release.'."\n".'Select “Stream & View” option instead';
									my 	$d=$mw->Dialog(-title => "Error!!!", -text => "$popup", -buttons => [ qw/ Exit / ]);
									if ($d->Show eq 'Ok') 
										{
											exit
										}
								}
							else
								{
									my 	$d=$mw->Dialog(-title => "Error!!!", -text => "$result", -buttons => [ qw/ Exit / ]);
									if ($d->Show eq 'Ok') 
										{
											exit
										}
								}	
							
						}	
				}
			else
				{
					my 	($path) = dir_tree($mw);
					mkdir ($path);
					my 	$view_path = $path.'/'."Snap\_$tag" ;
						
					print	"\nCreating Snapshot view : $tag";
					print	"\n-------------------------------------------------------------------";
					
					my	$mkview_cmd = 'cleartool mkview -snapshot -stream '."$username\_$proj_name\@\\$pvob -tag $tag -stgloc -auto $view_path";
					my 	$result =`$mkview_cmd 2>&1`;
					
					if	($result!~m/Error/gs)
						{
							print	"\nSnapshot view created.";
							print	"\n-------------------------------------------------------------------";
							
							my 	$d = $mw->messageBox(-title =>'Please Load Components..', -message=>"\nPlease add components from\nLoad Rule Tab -> Edit Load Rule", -type=>'ok',-icon=>'info');
							if 	($d eq "Ok") {`cleardescribe $tag`}
							
								$d=$mw->Dialog(-title => "Success Message", -text => "\nSnapshot view created", -buttons => [ qw/ Ok / ]);
							if ($d->Show eq 'Ok') {exit}		
							
							print "\nProcess Completed Sucessfully!!!";
							print "\n*******************************************************************";	
						}
					else
						{
							my 	$d=$mw->Dialog(-title => "Error!!!", -text => "Error occured while processing you request:\nError Desc : $result", -buttons => [ qw/ Exit / ]);
							if ($d->Show eq 'Ok') {exit}
						}
				}
		}
	
	sub	disp_multiple_streams
		{
			my 	($username, $pvob, $product_stream, $hash_ref, $vt, $tag)=(@_);
		   	my 	%dev_streams = %$hash_ref;
			
			my 	$mw = MainWindow->new;
				$mw->geometry("500x200");
				$mw->resizable(0,0);
				$mw->title("Suhas_Malusare Inc. Version 1.0");
			
			my  $Logo_font = $mw->Font(-family=> 'Georgia', -size  => 18);
			my  $lbl_font = $mw->Font(-family=> 'Georgia', -size  => 12);
			my  $link_font = $mw->Font(-family=> 'Georgia', -size  => 10);
			my  $foot_font = $mw->Font(-family=> 'Georgia', -size  => 9);
				
			my 	$top_frame = $mw->Frame(-borderwidth => 5,-background => "Blue", -relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$top_frame->Label(-text => "Select Development Stream.", -background => "blue", -foreground => "White", -font => $Logo_font)
						  ->pack(-side => "top", -pady =>5, -padx=>5);
			
			
			my 	$DI_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side =>'top', -fill =>'x');
				$DI_frame->Label(-text => "Stream Name", -font => $lbl_font)
						  ->pack(-side => "left", -pady =>5, -padx=>5);
			
			my 	$lb = $DI_frame->Scrolled("Listbox", -font => $link_font, -selectmode => "single", -height => '1', -width => '30',-scrollbars => 'osoe')
								->pack(-side => "left",-expand => 1, -ipady =>1, -ipadx => 1);
				
				foreach (keys %dev_streams)
					{
						$lb->insert('end', $_)
					}
			
			my 	$DII_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side =>'top', -fill =>'x');	
				$DII_frame->Button( -text => "Select & Go!!", -font => $lbl_font,
							 -command =>sub { 
											  my $selected_stream = $lb->get( $lb->curselection );
											  $mw->destroy();
											  
											  if 	($selected_stream ne 'Create New Stream')
											  	{
											  		mkview_ii($username,$selected_stream, $vt, $mw);		
											  	}
											  elsif ($selected_stream eq 'Create New Stream')
											  	{
											  		chk_str_II($username, $pvob, $product_stream, $vt, $tag, $st_cnt, $mw)
											  	}
											  
											}
							)->pack(-side => "left",-expand => 1, -ipady =>1, -ipadx => 1);
							
				$DII_frame->Button(-text => "Exit",-font => $lbl_font, -command =>sub {$mw->destroy()})
						 ->pack(-side => "left",-expand => 1, -ipady =>1, -ipadx =>1);
						 
					 
		}
	
	sub	mkview_ii
		{
			my 	($username, $selected_stream, $vt, $mw)=(@_);
			my 	($tag) = $selected_stream=~/(^.+?)\@/g;
			my 	($proj) = $selected_stream=~/^$username\_(.+?)\@/g;
			chomp $selected_stream;
			chomp $tag; $tag = chk_view($username, $proj, $tag);
			
			print	"\nTag Name: $tag";
			print	"\nStream Name : $selected_stream";
			print	"\n-------------------------------------------------------------------";
			
			if ($vt eq 'd')
				{
					print	"\nCreating Dynamic view : $tag";
					print	"\n-------------------------------------------------------------------";
								
					my	$mkview_cmd = 'cleartool mkview -str '."$selected_stream -tag $tag -stgloc -auto";
					my 	$result =`$mkview_cmd 2>&1`;
					
					if	($result!~m/Error/gs)
						{
							st_end_vw($tag, 'E', $mw);
							st_end_vw($tag, 'S', $mw);
							
							print "\nProcess Completed Sucessfully!!!";
							print "\n*******************************************************************";
							my 	$d=$mw->Dialog(-title => "Success Message", -text => "$result", -buttons => [ qw/ Ok / ]);
								$d->Show;
						}
					else
						{
							if 	($result =~m/unable\s+to\s+find\s+stream/gi)
								{
										my	$popup = 'You don’t have any development stream for this product release.'."\n".'Select “Stream & View” option instead';
									my 	$d=$mw->Dialog(-title => "Error!!!", -text => "$popup", -buttons => [ qw/ Exit / ]);
									if ($d->Show eq 'Ok') 
										{
											exit
										}
								}
							else
								{
									my 	$d=$mw->Dialog(-title => "Error!!!", -text => "Error occured while processing you request:\nError Desc : $result", -buttons => [ qw/ Exit / ]);
									if ($d->Show eq 'Ok') {exit}
								}	
							
						}	
				}
			else
				{
					my 	($pvob) = $selected_stream=~m/\@\\(.+?)$/g; 
						chomp $pvob;
					
					my 	($path) = dir_tree($mw);
					mkdir ($path);
					my 	$view_path = $path.'/'."Snap\_$tag" ;
					
					print	"\nCreating Snapshot view : $tag";
					print	"\n-------------------------------------------------------------------";
					
					my	$mkview_cmd = 'cleartool mkview -snapshot -stream '."$selected_stream -tag $tag -stgloc -auto $view_path";
					my 	$result =`$mkview_cmd 2>&1`;
					
					if	($result!~m/Error/gs)
						{
							print	"\nSnapshot view created.";
							print	"\n-------------------------------------------------------------------";
							my 	$d = $mw->messageBox(-title =>'Please Load Components..', -message=>"\nPlease add components from\nLoad Rule Tab -> Edit Load Rule", -type=>'ok',-icon=>'info');
							if 	($d eq "Ok") {`cleardescribe $tag`}
							
							$d=$mw->Dialog(-title => "Success Message", -text => "\nSnapshot view created", -buttons => [ qw/ Ok / ]);
							if ($d->Show eq 'Ok') {exit}		
							print "\nProcess Completed Sucessfully!!!";
							print "\n*******************************************************************";
						}
					else
						{
							my 	$d=$mw->Dialog(-title => "Error!!!", -text => "Error occured while processing you request:\nError Desc : $result", -buttons => [ qw/ Exit / ]);
							if ($d->Show eq 'Ok') {exit}
						}	
				}	
			
			
		}

	sub load_rule
		{
			my 	($view_path, $hash_ref)=(@_);
		   
			my 	$mw = MainWindow->new;
				$mw->geometry("500x220");
				$mw->resizable(0,0);
				$mw->title("Suhas_Malusare Inc. Version 1.0");
			
			my  $Logo_font = $mw->Font(-family=> 'Georgia', -size  => 18);
			my  $lbl_font = $mw->Font(-family=> 'Georgia', -size  => 12);
			my  $link_font = $mw->Font(-family=> 'Georgia', -size  => 10);
			my  $foot_font = $mw->Font(-family=> 'Georgia', -size  => 9);
				
			my 	$top_frame = $mw->Frame(-borderwidth => 5,-background => "Blue", -relief =>'groove')->pack(-side => 'top', -fill => 'x');
				$top_frame->Label(-text => "Select Load Rules.", -background => "blue", -foreground => "White", -font => $Logo_font)
						  ->pack(-side => "top", -pady =>5, -padx=>5);
			
			
			my 	$DI_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side =>'top', -fill =>'x');
				$DI_frame->Label(-text => "Components", -font => $lbl_font)
						  ->pack(-side => "left", -pady =>5, -padx=>5);
			
			my 	$lb = $DI_frame->Scrolled("Listbox", -font => $link_font, -selectmode => "multiple", -height => '0', -width => '0',-scrollbars => 'osoe')
								->pack(-side => "left",-expand => 1, -ipady =>1, -ipadx => 1);
				
				foreach (keys %$hash_ref)
					{
						$lb->insert('end', $_)
					}
			
			my 	$DII_frame = $mw->Frame(-borderwidth => 5,-relief =>'groove')->pack(-side =>'top', -fill =>'x');	
				$DII_frame->Button( -text => "Select & Go!!", -font => $lbl_font,
							 -command =>sub { 
											  my 	@selected_comps= $lb->curselection();
											 
											  foreach my $i (@selected_comps)
											  	{
											  		print	"\nAdding : ".$lb->get( $i ).".. please wait, this may take some time....";
											  		my 	$add_rule = 'cleartool update -graphical'."$view_path/".$lb->get( $i );
											  		my 	$AR_result =`$add_rule 2>&1`;
											  	}
											  	
											  my 	$d=$mw->Dialog(-title => "Success Message", -text => "Selected components are added successfully to view", -buttons => [ qw/ Ok / ]);
												if ($d->Show eq 'Ok') {exit}
											  	
											}
							)->pack(-side => "left",-expand => 1, -ipady =>1, -ipadx => 1);
							
				$DII_frame->Button(-text => "Exit",-font => $lbl_font, -command =>sub {$mw->destroy()})
						 ->pack(-side => "left",-expand => 1, -ipady =>1, -ipadx =>1);
			
		}

	sub	dir_tree
		{
			my 	$self=shift;
			my 	($mw)=(@_);
			my $dir = $mw->chooseDirectory(-initialdir => '~', -title => 'Please select a folder to create snapshot view');
    		if (!defined $dir) 
    			{
        			return 'c:/CCViews'
    			} 
    		else 
    			{
        			return $dir
				}
		}		
	
	sub	st_end_vw
		{
			my $self=shift;
			my 	($tag, $ar, $mw)=(@_);
			my 	$result;
			
			if 	($ar eq 'E')
				{
					my	$endview_cmd = "cleartool endview $tag";
						$result =`$endview_cmd 2>&1`;
				}
			else
				{
					print	"\nStarting view : $tag";
					print	"\n-------------------------------------------------------------------";
					my	$stview_cmd = "cleartool startview $tag";
						$result =`$stview_cmd 2>&1`;
					my 	$d=$mw->Dialog(-title => "Start View", -text => "View $tag started Successfully!!!", -buttons => [ qw/ Ok / ]);
							if ($d->Show eq 'Ok') {exit}	
				}
			sleep 1		
			
		}
	
	
		

	MainLoop;	
1;	