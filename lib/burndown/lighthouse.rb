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
    
    def self.get_milestone(remote_milestone_id, remote_project_id, account, token)
      get "http://#{account}.#{lighthouse_host}/projects/#{remote_project_id}/milestone/#{remote_milestone_id}.xml", :headers => default_headers(token)
    end
    
    def self.get_milestone_tickets(milestone_name, remote_project_id, account, token)
      get "http://#{account}.#{lighthouse_host}/projects/#{remote_project_id}/tickets.xml", :query => {
        :q => "milestone:\"#{milestone_name}\" state:open"
      }, :headers => default_headers(token)
    end
    
    def self.create_callback(project_id, url, account, token)
      post "http://#{account}.#{lighthouse_host}/callback_handlers.xml", :query => {:callback_handler =>{
        :project_id => project_id,
        :url => url
      }}, :headers => default_headers(token)
    end
  end
end