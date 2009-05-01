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
    
     # Queries the API for each milestone (yikes!). Hope you don't have too many.
    def self.sync_with_lighthouse
      Milestone.all.each do |milestone|
        milestone.sync_with_lighthouse
      end
    end
    
    # Syncs up the milestone with lighthouse updates
    def sync_with_lighthouse
      results = Lighthouse.get_milestone_tickets(self.name, self.project.remote_id, self.project.token.account, self.project.token.token)
      ticket_ids = results["tickets"].collect{ |t| t["number"] }.join(",")

      existing_event = self.milestone_events.first(:created_on.gte => Date.today)
      if (existing_event)
        existing_event.update_attributes(:open_tickets => ticket_ids)
      else
        self.milestone_events.create(:open_tickets => ticket_ids)
      end
    end
    
  end
end