# class VolunteerMatchApi 

#   def initialize (account_name, api_key)
#     @account_name = account_name
#     @api_key = api_key
#   end

#   def hello_world(name)
#     call :helloWorld, {:name => name}.to_json
#   end

#   def search_opportunities(location)
#     # response = RestClient.get('https://www.stage.volunteermatch.org/api/call?action=searchOpportunities', api.call(searchOpportunities, location))
#     call :searchOpportunities, {:location => location}.to_json
#     binding.pry
#   end 

#   protected

#   def call(action, json_query)
#     nonce           = Digest::SHA2.hexdigest(rand.to_s)[0, 20]
#     creation_time   = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%z")
#     password_digest = Base64.encode64(Digest::SHA2.digest(nonce + creation_time + @api_key)).chomp
#     url             = URI.parse("http://www.volunteermatch.org/api/call?action=#{action.to_s}&query=" + URI.encode(json_query))

#     req             = Net::HTTP::Get.new(url.request_uri)
#     req.add_field('Content-Type', 'application/json')
#     req.add_field('Authorization', 'WSSE profile="UsernameToken"')
#     req.add_field('X-WSSE', 'UsernameToken Username="' + @account_name + '", PasswordDigest="' + password_digest + '", ' +
#         'Nonce="' + nonce + '", Created="' + creation_time + '"')

#     res = Net::HTTP.new(url.host, url.port).start { |http| http.request(req) }
#     raise "HTTP error code #{res.code}" unless res.code == "200"
#     OpenStruct.new(JSON.parse res.body)
#   end
  
# end
