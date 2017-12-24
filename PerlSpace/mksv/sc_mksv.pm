package sc_mksv;

use strict;
use Win32;


	sub	new
		{
			my 	$self = {};
			return bless $self
		}

	sub	process_req
		{
			my	$self= shift;
			my 	($pvob, $prod, $rid, $pt, $sv, $vt, $debug)=(@_);
			
			my 	$product_stream = "$prod".'.'."$pt"."$rid";
			my 	$username = Win32::LoginName;
			my 	$tag = "$username\_$product_stream"; 
			
			print	"\nUser Name	: $username";
			print	"\nProject Stream  : $product_stream";
			print	"\nView Tag	: $tag ";
			print	"\n*******************************************************************";
			
			if 	($sv eq 'sv')
				{
					my 	($flag) = $self->chk_stream($username, $pvob, $product_stream, $vt, $tag, $debug);
				}
			else
				{
					my 	($flag) = $self->chk_stream($username, $pvob, $product_stream, $vt, $tag, $debug);
				}
			
		}		
		
	sub	chk_stream
		{
			my	$self= shift;
			my 	($username, $pvob, $product_stream, $vt, $tag, $debug)=(@_);
			my	$dev_str_name = "$username\_$product_stream\@\\$pvob";
			
			print "\nChecking for Existing streams for $username on $product_stream";
			print "\n-------------------------------------------------------------------";
			
			my 	$cmd = "cleartool lsstream stream:$username\_$product_stream\@\\$pvob";
			my 	$ls_str = `$cmd 2>&1`;
			
			if ($debug eq 'y')
				{
					
					print "\nClass & Function : sc_mksv::chk_stream()";	
					print "\nDEBUG EXEC: $cmd";
					print "\nDEBUG OUTPUT:$ls_str";
					print	"\n---------------------------------------------------------------\n";		
				}
						
			if 	($ls_str !~/stream\s+not\s+found/)
				{
					print "\nFollowing stream Present for $username on $product_stream";
					print "\n\tDevelopement Stream name : $dev_str_name\n";
					print "\n-------------------------------------------------------------------";
					
					my 	$int_str_name = $self->get_int_str_name($pvob, $product_stream, $debug);
					my 	$int_vw_flag = $self->chk_view($username, "$tag\_int", $int_str_name, $debug, 'Int');	
					my 	$vw_flag = $self->chk_view($username, $tag, $dev_str_name, $debug, 'Dev');	
					
					if 	($int_vw_flag eq 'N')
						{
							$self->mk_int_view($username, $tag, $int_str_name, $debug);
						}
					
					if 	($vw_flag eq 'N')
						{
							$self->mk_view($username, $tag, $dev_str_name, $vt, $debug);
						}
					else
						{
							exit
						}	
				}
			else
				{
					my 	$int_str_name = $self->get_int_str_name($pvob, $product_stream, $debug);
					my 	$int_vw_flag = $self->chk_view($username, "$tag\_int", $int_str_name, $debug, 'Int');
					
					if 	($int_vw_flag eq 'N')
						{
							$self->mk_int_view($username, $tag, $int_str_name, $debug);
						}	
					
						$self->mk_stream($username, $pvob, $product_stream, $vt, $tag, $debug, $dev_str_name);
				}	
		}

	sub	chk_view
		{
			my	$self= shift;
			my 	($username, $tag, $dev_str_name, $debug, $type)=(@_);
			print "\nChecking for Existing $type Views for $username";
			print "\n===================================================================";
			
			my 	$cmd = "cleartool lsview $tag";
			my	$chk_result = `$cmd 2>&1`;
			
			if ($debug eq 'y')
				{
					print "\nClass & Function : sc_mksv::chk_view()";	
					print "\nDEBUG EXEC: $cmd";
					print "\nDEBUG OUTPUT:$chk_result";
					print	"\n---------------------------------------------------------------\n";		
				}
			
			if	($chk_result!~m/Error/gs)
				{
					print "\nFollowing views Present for:";
					print "\n\tUser: \'$username\' on $dev_str_name";
					print "\n\t$type View : $tag ";
					print "\n-------------------------------------------------------------------";
					return $tag
				}
			else
				{
					return 'N'	
				}	
		}

	sub	mk_view
		{
			my	$self= shift;
			my 	($username, $tag, $dev_str_name, $vt, $debug)=(@_);
			
			if 	($vt eq 'd')
				{
					print	"\nCreating Dynamic view : $tag";
					print	"\n-------------------------------------------------------------------";
					my	$mkview_cmd = 'cleartool mkview -str '."$dev_str_name -tag $tag -stgloc -auto";
					my 	$result =`$mkview_cmd 2>&1`;
					
					if ($debug eq 'y')
						{
							
							print "\nClass & Function : sc_mksv::mk_view()";	
							print "\nDEBUG EXEC: $mkview_cmd";
							print "\nDEBUG OUTPUT:$result";
							print	"\n---------------------------------------------------------------\n";		
						}
										
					if	($result!~m/Error/gs)
						{
							$self->st_end_vw($tag, 'E', $debug);
							$self->st_end_vw($tag, 'S', $debug);
						}
					else
						{
							if 	($result =~m/unable\s+to\s+find\s+stream/gi)
								{
								}
							else
								{
								}	
							
						}	
				}
		}
	
	sub	mk_stream
		{
			my	$self= shift;
			my 	($username, $pvob, $product_stream, $vt, $tag, $debug, $dev_str_name)=(@_);
			print "\nCreating developement stream for $username on $product_stream";
			print "\n-------------------------------------------------------------------";
			
			print "\nGetting Integration stream for $product_stream";
			print "\n-------------------------------------------------------------------";
			my 	($int_str) = $self->get_int_str_name($pvob, $product_stream, $debug);
			
			# cleartool mkstream -in XV91x.P2.5.0@\XV91x_pvob malusas_XV91x.P2.5.0@\XV91x_pvob
			
			my 	$mkstream_cmd = 'cleartool mkstream -in '."$product_stream".'@\\'."$pvob $tag".'@\\'."$pvob";
			my 	$result =  `$mkstream_cmd 2>&1`;
			
			if ($debug eq 'y')
				{
					print "\nClass & Function : sc_mksv::mk_stream()";	
					print "\nDEBUG EXEC: $mkstream_cmd";
					print "\nDEBUG OUTPUT:$result";
					print	"\n---------------------------------------------------------------\n";		
				}
			
			if	($result!~m/Error/gs)
				{
					print "\nStream : $tag Created on Project $pvob";
					print "\n-------------------------------------------------------------------";
					$self->mk_view($username, $tag, $dev_str_name, $vt, $debug);
				}
			else
				{
					print "\nError : $result";
					print	"\n---------------------------------------------------------------\n";
				}				 
		}

	sub	get_int_str_name
		{
			my $self=shift;
			my 	($pvob, $product_stream, $debug) = (@_);
			my 	$proj_desc_cmd = 'cleartool desc -l project:'."$product_stream".'@\\'."$pvob";
			my 	$proj_desc = `$proj_desc_cmd 2>&1`;
			
			if ($debug eq 'y')
				{
					print "\nClass & Function : sc_mksv::get_int_str_name()";	
					print "\nDEBUG EXEC: $proj_desc_cmd";
					print "\nDEBUG OUTPUT:$proj_desc";
					print	"\n---------------------------------------------------------------";			
				}
			
				$proj_desc=~s{(^.+?integration\s+stream:)(.+?pvob)(.+?$)}
							 {
							 	$2
							 }exgsi;
				$proj_desc=~s/\s+//g;
				
			print	"\nInt Stream Name : $proj_desc";
			print "\n-------------------------------------------------------------------";	
			return $proj_desc;
		}
	
	sub	st_end_vw
		{
			my	$self= shift;
			my 	($tag, $ar, $debug)=(@_);
			my 	$result;
			
			if 	($ar eq 'E')
				{
					my	$endview_cmd = "cleartool endview $tag";
						$result =`$endview_cmd 2>&1`;
					
					if ($debug eq 'y')
						{
							print "\nClass & Function : sc_mksv::st_end_vw()";	
							print "\nDEBUG EXEC: $endview_cmd";
							print	"\n---------------------------------------------------------------\n";		
						}	
					
				}
			else
				{
					print	"\nStarting view : $tag";
					print	"\n-------------------------------------------------------------------";
					my	$stview_cmd = "cleartool startview $tag";
						$result =`$stview_cmd 2>&1`;
					
					if ($debug eq 'y')
						{
							print "\nClass & Function : sc_mksv::st_end_vw()";	
							print "\nDEBUG EXEC: $stview_cmd";
							print	"\n---------------------------------------------------------------\n";		
						}		
				}
			sleep 1		
			
		}

	sub	mk_int_view
		{
			my	$self= shift;
			my 	($username, $tag, $int_str_name, $debug)=(@_);
				$tag .='_int'; 
			
			
			print	"\nCreating Integration view : $tag";
			print	"\nIntegration Stream name   : $int_str_name";
			print	"\n-------------------------------------------------------------------";

			my	$mkview_cmd = 'cleartool mkview -str '."$int_str_name -tag $tag -stgloc -auto";
			my 	$result =`$mkview_cmd 2>&1`;
					
			if ($debug eq 'y')
				{
					print "\nClass & Function : sc_mksv::mk_int_view()";	
					print "\nDEBUG EXEC: $mkview_cmd";
					print "\nDEBUG OUTPUT:$result";
					print	"\n---------------------------------------------------------------\n";		
				}
			
			if	($result!~m/Error/gs)
				{
					$self->st_end_vw($tag, 'E', $debug);
					$self->st_end_vw($tag, 'S', $debug);
				}
		}


1;		