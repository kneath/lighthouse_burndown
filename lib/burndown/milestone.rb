module Burndown
  class Milestone
    include DataMapper::Resource
    
    property :id,             Serial
    property :remote_id,      Integer,  :nullable => false
    property :name,           String
    property :activated_at,   DateTime
    property :closed_at,      DateTime
    property :due_date,       DateTime
    
    belongs_to :project
    has n, :milestone_events
    
    def start_date
      activated_at
    end
    
    def end_date
      return closed_at if closed_at
      return due_date if due_date
      Time.now.utc.to_datetime
    end
    
  end
end