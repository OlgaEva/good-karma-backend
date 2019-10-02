require 'rest-client'
require 'pry'

#######

#!/usr/bin/env ruby

require 'rubygems'
require 'base64'
require 'digest/sha2'
require 'net/http'
require 'uri'
require 'json'
require 'ostruct'

# if ARGV.length == 2
#   account_name, api_key = ARGV
# else
#   puts "Usage: #{$0} account_name api_key"
#   exit 1
# end

class VolunteerMatchApi

  def initialize (account_name, api_key)
    @account_name = account_name
    @api_key      = api_key
  end

#   def hello_world(name)
#     call :helloWorld, {:name => name}.to_json
#   end

  def search_opportunities(location)
    call :searchOpportunities, {:location => location}.to_json
  end

  protected

  def call(action, json_query)
    nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
    creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
    password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + @api_key)).chomp
    url             = URI.parse("http://www.volunteermatch.org/api/call?action=#{action.to_s}&query=" + URI.encode(json_query))

    req             = Net::HTTP::Get.new(url.request_uri)
    req.add_field('Content-Type', 'application/json')
    req.add_field('Authorization', 'WSSE profile="UsernameToken"')
    req.add_field('X-WSSE', 'UsernameToken Username="' + @account_name + '", PasswordDigest="' + password_digest + '", ' +
        'Nonce="' + nonce + '", Created="' + creation_time + '"')

    res = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
    raise "HTTP error code #{res.code}" unless res.code == "200"
    OpenStruct.new(JSON.parse res.body)
  end
  
end

api_key = Rails.application.credentials.api_key
account_name = Rails.application.credentials.account_name

api = VolunteerMatchApi.new(account_name, api_key)
response = api.search_opportunities("Staten Island, NY")
# binding.pry

all_jobs = []
# ONLY RUN DURING ONE rails db:SEED to create one user

# u1 = User.create(username: "Olga", password: "1234", points: 100, monthly_goal: 12, admin: true)
# u2 = User.create(username: "Fernando", password: "1234", points: 100, monthly_goal: 8, admin: true)
# u3 = User.create(username: "Ines", password: "1234", points: 100, monthly_goal: 5, admin: true)
# u4 = User.create(username: "Nikos", password: "1234", points: 100, monthly_goal: 3, admin: true)
u5 = User.create(username: "Olivia", password: "1234", points: 100, monthly_goal: 4, admin: true)
# u6 = User.create(username: "Joaquin", password: "1234", points: 100, monthly_goal: 4, admin: true)
# u7 = User.create(username: "Luis", password: "1234", points: 100, monthly_goal: 6, admin: true)
# u8 = User.create(username: "Mabel", password: "1234", points: 100, monthly_goal: 11, admin: true)
# u9 = User.create(username: "Raquel", password: "1234", points: 100, monthly_goal: 7, admin: true)
# u10 = User.create(username: "Marc", password: "1234", points: 100, monthly_goal: 8, admin: true)
# u11 = User.create(username: "Bianca", password: "1234", points: 100, monthly_goal: 7, admin: true)
# u12 = User.create(username: "Paula", password: "1234", points: 100, monthly_goal: 4, admin: true)
# u13 = User.create(username: "Daniel", password: "1234", points: 100, monthly_goal: 6, admin: true)
# u14 = User.create(username: "Sam", password: "1234", points: 100, monthly_goal: 5, admin: true)
# u15 = User.create(username: "Diego", password: "1234", points: 100, monthly_goal: 7, admin: true)
# u16 = User.create(username: "Cesar", password: "1234", points: 100, monthly_goal: 8, admin: true)
# u17 = User.create(username: "Jose", password: "1234", points: 100, monthly_goal: 9, admin: true)
# u18 = User.create(username: "Nayda", password: "1234", points: 100, monthly_goal: 7, admin: true)
# u19 = User.create(username: "Marieli", password: "1234", points: 100, monthly_goal: 5, admin: true)
# u20 = User.create(username: "Giovanna", password: "1234", points: 100, monthly_goal: 2, admin: true)

response_hash = response.to_h.each{|k,v| puts "#{k} => #{v}"}

    response_hash[:opportunities].each do |opportunity|
    all_jobs << Job.create( organization: opportunity["parentOrg"]["name"], address: opportunity["location"]["city"], title: opportunity["title"], description: opportunity["plaintextDescription"], user: u5 )
    end