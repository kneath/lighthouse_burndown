module Burndown
  class Lighthouse
    include HTTParty
    format :xml
    
    def self.default_headers
      "#{}"
    end
    
    def self.get_token(account, token)
      get "http://#{account}.lighthouseapp.com/tokens/#{token}.xml", :headers => {'X-LighthouseToken' => token}
    end
  end
end