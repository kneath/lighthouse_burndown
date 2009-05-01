module Burndown
  class Project
    include DataMapper::Resource
    
    property :id,             Serial
    property :remote_id,      Integer,  :nullable => false
    property :name,           String,   :nullable => false
    property :active_since,   DateTime
    
    belongs_to :token
    
    # Calls the api to get projects for the token
    def self.for_token(token)
      result = Lighthouse.get_projects(token.account, token.token)
      arr = []
      (result["projects"] ||[]).each do |project|
        arr.push(Project.new(:name => project["name"], :remote_id => project["id"]))
      end
      arr
    end
    
    # Activates (starts tracking) a remote project
    def self.activate_remote(remote_id, token)
      result = Lighthouse.get_project(remote_id, token.account, token.token)
      result = result["project"]
      p = Project.new(:name => result["name"], :remote_id => result["id"], :active_since => Time.now.utc)
      p.token = token
      p.save
      p
    end
    
    def active?
      active_since && active_since < Time.now.utc
    end
  end
end