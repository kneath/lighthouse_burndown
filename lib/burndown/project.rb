module Burndown
  class Project
    include DataMapper::Resource
    
    property :id,       Serial
    property :name,     String,   :nullable => false
    property :active,   Boolean,  :default => false
    
    # Calls the api to get projects for the token
    def self.for_token(token)
      result = Lighthouse.get_projects(token.account, token.token)
      arr = []
      result["projects"].each do |project|
        arr.push(Project.new(:name => project["name"], :active => false))
      end
      arr
    end
  end
end