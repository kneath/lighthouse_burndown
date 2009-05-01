module Burndown
  class Milestone
    include DataMapper::Resource
    
    property :id,             Serial
    property :remote_id,      Integer,  :nullable => false
    property :name,           String
    property :activated_at,   DateTime
    
    belongs_to :project
    
  end
end