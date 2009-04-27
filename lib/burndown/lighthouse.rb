module Burndown
  class Lighthouse
    include HTTParty
    format :xml
    
    def self.default_headers
      "#{}"
    end
    
    def self.check_token(account, token)
      result = get "http://#{account}.lighthouseapp.com/tokens/#{token}.xml", :headers => {'X-LighthouseToken' => token}
      result["token"] ? true : false
    end
  end
end