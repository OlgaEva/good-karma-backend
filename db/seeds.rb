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
response = api.search_opportunities("Fairfield, CT")
# binding.pry

all_jobs = []

response_hash = response.to_h.each{|k,v| puts "#{k} => #{v}"}

    response_hash[:opportunities].each do |opportunity|
    all_jobs << Job.create( organization: opportunity["parentOrg"]["name"], address: opportunity["location"]["city"], title: opportunity["title"], description: opportunity["plaintextDescription"], duration: "ongoing")
    end