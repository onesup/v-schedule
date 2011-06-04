#coding : utf-8
require 'twitter_oauth'
require 'twitter'
require 'oauth'
require 'hpricot'

class TwitterBot
	attr_accessor :client, :count, :userid, :password
	def new_account
		@count = 0
		client = TwitterOAuth::Client.new(
			:consumer_key 		=> "G63VRycj2qz75vZEJWve2g",
			:consumer_secret 	=> "nsBOrpZIj9UGd2HGc1qJIhkuqM8XbUbQCBDSNpC0RE"
		)
		
		request_token = client.request_token(:oauth_callback => "http://127.0.0.1:3000/ranks/")	
		response = Net::HTTP.post_form(URI.parse(' 
			http://twitter.com/oauth/authorize'), 
			{
				"session[username_or_email]" => @userid, 
				"session[password]" => @password, 
				"oauth_token" => request_token.token}
			)	
		body = Hpricot(response.body)
		href = body.search("p a")[0].attributes["href"]
		verifier = href.match(/fier\=\w+/).to_s.gsub(/fier\=/,'')
		acc = client.authorize( request_token.token, request_token.secret, :oauth_verifier => verifier )
		if client.authorized?
			@client = client
			p "new client"
		else
			p "make new account failed"
			Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=new_account_error")
			@client = false
		end
	end
	
	def get_lists
	  @client.get_lists(@client)
  end
	
	def check_following_rule
		if 2000 > @client.info["friends_count"]
			true
		else
			portion = @client.info["followers_count"].to_f / @client.info["friends_count"].to_f
			if portion > 0.92
				true
			else
				false
				Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=#{self.userid}_portion_error_friend_#{@client.info["friends_count"]}_follower_#{@client.info["followers_count"]}")
			end
		end
	end
	
	def change_userinfo
		Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/users/change_info?userid=#{self.userid}&friend=#{@client.info["friends_count"]}&follower=#{@client.info["followers_count"]}")
	end
	
	
	def auto_follow
		if @client.authorized?
			p "following start"
			friends = @client.friends
	  		friends.each do |friend|
	  			begin
		  		f_follower = Twitter.followers(friend["screen_name"])
		  		f_follower["users"].each do |f_follower|
		  			if !@client.friends?(@userid,f_follower["screen_name"]) and f_follower["screen_name"] != @userid
						break if @count > 50
						@client.friend(f_follower["screen_name"])
						@count += 1
						p f_follower["screen_name"]
					end
					
					break if @count > 50
				end
				rescue
					p "followers error"
					Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=#{self.userid}_followers_error")
				end
				break if @count > 50
	
		  	end
		else
			p "authorize error"
			Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=#{self.userid}_authorize_error")
			false
		end	
		p "count is #{@count}"
				
	end
	
	def follow(username)
		if !@client.friends?(@userid,username) and @userid != username
			@client.friend(username)
			p username
		end
	end
	
	def tweet(message)
		if @client.authorized?
			p "tweet"
			@client.update(message)
		end
	end
end


class User
	attr_accessor :list
	def get_list
		@list = Array.new
		xml = open("http://twitteruser.kimseongjun.co.kr/users.xml")
		doc = Hpricot(xml)
		doc.search("user").each do |user|
			user_tmp = Hash.new
			user_tmp["userid"] 		= user.search("userid").innerHTML
			user_tmp["password"] 	= user.search("password").innerHTML
			@list << user_tmp
		end
		@list
	end
end


class BotDeck
	attr_accessor :user_list
	def initialize
		u = User.new
		@user_list = u.get_list
	end
	 
	def start_following
		Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=twitter__follow__start")
		@user_list.each do |user|
			
			bot = TwitterBot.new
			bot.userid 		= user["userid"]
			bot.password 	= user["password"]
			if bot.new_account
				if bot.check_following_rule
					bot.auto_follow
					Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=#{bot.userid}_finished")
				end
				bot.change_userinfo
			end
			
		end		
		Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=good_nonstop_end")
	end
	
	def start_tweet(message)
	
		@user_list.each_with_index do |user,index|
			
			bot = TwitterBot.new
			bot.userid 		= user["userid"]
			bot.password 	= user["password"]
			if bot.new_account
				rand_message = 
				#tweet_message = "#{message}" + %w{! * @ $ & @ !}.sort{rand(7)}.join + " index"
				tweet_message = message + %w{! * @ $ & @ !}[rand(7)] + " index"
				bot.tweet(tweet_message)
				p tweet_message
			end
			sleep(100)
			p "awake"
		end
		
	end
	
	def add_userlist_in_admin
		bot = TwitterBot.new
		bot.userid 		= "kimseongjun"
		bot.password 	= "dkssud12"
		if bot.new_account
			@user_list.each do |user|
				bot.follow(user["userid"])	
			end 
		end
		Net::HTTP.get_print URI.parse("http://twitteruser.kimseongjun.co.kr/crontab_logs/logging?user=update_user_list")
	end
end

# client = BotDeck.new
# #client.add_userlist_in_admin
# #client.start_tweet("트위터 초보입니다.ㅠ")
# client.start_following
