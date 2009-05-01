module Burndown
  class Lighthouse
    include HTTParty
    format :xml
    
    def self.lighthouse_host
      Burndown.config[:lighthouse_host]
    end
    
    def self.default_headers
      "#{}"
    end
    
    def self.get_token(account, token)
      get "http://#{account}.#{lighthouse_host}/tokens/#{token}.xml", :headers => {'X-LighthouseToken' => token}
    end
    
    def self.get_projects(account, token)
      get "http://#{account}.#{lighthouse_host}/projects.xml", :headers => {'X-LighthouseToken' => token}
    end
  end
end