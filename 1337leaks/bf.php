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
<link type="text/css" rel="stylesheet" href="../style.css">
<body dir="ltr" alink="#00ff00" background="http://0day.today/img/bg.gif" bgcolor="#000000" link="#00c000" text="#008000" vlink="#00c000">
</head>
<body>
<center>
<table width="668" border="0" cellpadding="3" cellspacing="3" class="main">
  <tr><td></td></tr><tr><td>
<table width="597" align="center" border="0">
<tbody>
<a href="">[Source Code(Login)]</a> - <a href="">[Perl] - Brute Force Snapchat</a><br><br>
<form action="" method="post">
<br>
<img src="http://www.covetedplaces.com/wp-content/uploads/2015/11/snapchat-logo-yellow.png" width="120" height="120"><br>
<font color="yellow">Login SnapChat API</font><br><br>
<font color="red"> Username :<input type="text" name="username"></font><br><br>
<font color="red"> Password :<input type="password" name="password"></font><br><br><br>
<input type="submit" name="login" value="Login">
</form>
<?
function base64($data) {
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}
if($_POST['login']){
	if($_POST['username']){
		if($_POST['password']){
			$username = $_POST['username'];
			$password = $_POST['password'];
			$header = ['alg'=>'HS256','typ'=>'JWT'];
			$enheaders = base64(json_encode($header));
			$time = time();
			$payload = ['sub'=>'Joe','username'=>$username, 'password'=>$password,'iat'=>$time];
			$enpayload = base64(json_encode($payload));
			$secret = 'f3cdf4bbf206f5d572c6db13757c06fe';
			$hash = hash_hmac('SHA256',"$enheaders.$enpayload",$secret,true);
			$signature = base64($hash);
			$jwt = "$enheaders.$enpayload.$signature";
			###################################################
			$casper = curl_init();
			curl_setopt($casper, CURLOPT_URL, "https://casper-api.herokuapp.com/snapchat/ios/login");
			curl_setopt($casper, CURLOPT_SSL_VERIFYPEER, true);
			curl_setopt($casper, CURLOPT_RETURNTRANSFER, 1);
			curl_setopt($casper, CURLOPT_FOLLOWLOCATION, 1);
			curl_setopt($casper, CURLOPT_HEADER, 1);
			curl_setopt($casper, CURLOPT_POST, true);
			curl_setopt($casper, CURLOPT_HTTPHEADER, array(
			    'X-Casper-API-Key: dd3779d571409a67743c7e0e18a2cc04',
				'Content-Type: application/x-www-form-urlencoded; charset=UTF-8',
				'User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.0; SM-G900F Build/LRX21T)',
			    'Host: casper-api.herokuapp.com',
				'Connection: Keep-Alive'
			));
			curl_setopt($casper, CURLOPT_POSTFIELDS, "jwt=$jwt");
			curl_setopt($casper, CURLOPT_USERAGENT, "Dalvik/2.1.0 (Linux; U; Android 5.0; SM-G900F Build/LRX21T)");
			$rescasper = curl_exec($casper);
			if(eregi('"code":200', $rescasper))
				{
					$startauth = explode('"X-Snapchat-Client-Auth-Token":"' , $rescasper );
					$endauth = explode('"' , $startauth[1] );
					$auth = $endauth[0];
					###################### "X-Snapchat-Client-Token":"
					$starttoken = explode('"X-Snapchat-Client-Token":"' , $rescasper );
					$endtoken = explode('"' , $starttoken[1] );
					$token = $endtoken[0];
					#######################
					$startreq = explode('"req_token":"' , $rescasper );
					$endreq = explode('"' , $startreq[1] );
					$req = $endreq[0];
					####################### "timestamp":
					$starttime = explode('"timestamp":"' , $rescasper );
					$endtime = explode('"' , $starttime[1] );
					$time = $endtime[0];
					$snapchat = curl_init();
					curl_setopt($snapchat, CURLOPT_URL, "https://auth.snapchat.com/scauth/login");
					curl_setopt($snapchat, CURLOPT_SSL_VERIFYPEER, true);
					curl_setopt($snapchat, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($snapchat, CURLOPT_FOLLOWLOCATION, 1);
					curl_setopt($snapchat, CURLOPT_HTTPHEADER, array(
					    "X-Snapchat-Client-Token: $token",
						'User-Agent: Snapchat/10.15.0.4 (iPhone6,2; iOS 9.3.3; gzip)',
						"X-Snapchat-Client-Auth-Token: $auth",
					    'Accept-Language: en-NZ;q=1',
						'Connection: Keep-Alive'
					));
					curl_setopt($snapchat, CURLOPT_POSTFIELDS, "password=$password&timestamp=$time&username=$username&req_token=$req");
					curl_setopt($snapchat, CURLOPT_USERAGENT, "Snapchat/10.15.0.4 (iPhone6,2; iOS 9.3.3; gzip)");
					$response = curl_exec($snapchat);
					if(eregi('"logged":true,', $response))
						{
							echo '<br><br><font color="blue">Logged ('.htmlspecialchars($username).':'.htmlspecialchars($password).')</font>';
						}
						else
						{
							if(eregi('not the right password', $response))
								{
									echo '<br><br><font color="red">Failed ('.htmlspecialchars($username).':'.htmlspecialchars($password).')</font>';
								}
								else
								{
									if(eregi('find an account with that username.', $response))
										{
											echo '<br><br><font color="white">'.htmlspecialchars($username).' Not Found</font>';
										}
										else
										{
											echo "<br><br><br><br><font color='black'>Error: <input type'text' value='$response'>";
										}
								}
						}
					curl_close($snapchat);
				}
				else
				{
					echo '<br><br>{"Status":"Error"}<br>';
				}
			curl_close($casper);
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
<p><FONT style="FONT-SIZE: 10px; FONT-FAMILY: 'courier new'">Email <a href="mailto:leetroot@hotmail.com">leetroot@hotmail.com</a> 
<br><br>Copyright &copy; 2017 <a href="http://1337Leaks.info">1337Leaks.info</a> - <a href="http://1337r00t.com">1337r00t</a> -  <a href="http://twitter.com/_1337r00t">My Twitter</a> </FONT></p>
</td></tr></table>
  <br>
  <br>
</center>
</body>
</html>
