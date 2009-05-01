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
        arr.push(Project.new(:name => project["name"]))
      end
      arr
    end
    
    def active?
      active_since && active_since < Time.now.utc
    end
  end
end