module Burndown
  class MilestoneEvent
    include DataMapper::Resource
    
    property :id,             Serial
    property :who,            String
    property :ticket_change,  Integer
    property :created_at,     DateTime
    
    belongs_to :milestone
    
  end
end