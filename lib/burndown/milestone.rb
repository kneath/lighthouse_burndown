module Burndown
  class Milestone
    include DataMapper::Resource
    
    property :id,             Serial
    property :remote_id,      Integer,  :nullable => false
    property :name,           String
    
    belongs_to :project
    
  end
end