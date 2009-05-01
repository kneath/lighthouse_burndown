module Burndown
  class Lighthouse
    include HTTParty
    format :xml
    
    def self.lighthouse_host
      Burndown.config[:lighthouse_host]
    end
    
    def self.default_headers(token)
      {'X-LighthouseToken' => token}
    end
    
    def self.get_token(account, token)
      get "http://#{account}.#{lighthouse_host}/tokens/#{token}.xml", :headers => default_headers(token)
    end
    
    def self.get_projects(account, token)
      get "http://#{account}.#{lighthouse_host}/projects.xml", :headers => default_headers(token)
    end
    
    def self.get_project(remote_id, account, token)
      get "http://#{account}.#{lighthouse_host}/projects/#{remote_id}.xml", :headers => default_headers(token)
    end
    
    def self.get_milestones(remote_project_id, account, token)
      get "http://#{account}.#{lighthouse_host}/projects/#{remote_project_id}/milestones.xml", :headers => default_headers(token)
    end
  end
end