module Burndown
  class Milestone
    include DataMapper::Resource
    
    property :id,                   Serial
    property :remote_id,            Integer,  :nullable => false
    property :name,                 String
    property :activated_at,         DateTime
    property :closed_at,            DateTime
    property :due_on,               DateTime
    property :tickets_count,        Integer, :default => 0
    property :open_tickets_count,   Integer, :default => 0
    
    belongs_to :project
    has n, :milestone_events
    
    def start_date
      activated_at
    end
    
    def end_date
      due = due_on || Time.now.to_datetime
      closed = closed_at || Time.now.to_datetime
      [due, closed].max
    end
    
    def past_due?
      due_on && due_on < Time.now.to_datetime
    end
    
    def active?
      return true if open_tickets_count > 0
      return true if due_on && !past_due?
      return false
    end
    
     # Queries the API for each milestone (yikes!). Hope you don't have too many.
    def self.sync_with_lighthouse
      Milestone.all.each do |milestone|
        milestone.sync_with_lighthouse
      end
    end
    
    # Syncs up the milestone with lighthouse updates
    def sync_with_lighthouse
      results = Lighthouse.get_milestone(self.remote_id, self.project.remote_id, self.project.token.account, self.project.token.token)
      return false unless milestone = results["milestone"]
      self.update_attributes(:name => milestone["title"], :due_on => milestone["due_on"], :tickets_count => milestone["tickets_count"], :open_tickets_count => milestone["open_tickets_count"])
      if !self.active?
        self.update_attributes(:closed_at => Time.now)
      else
        self.update_attributes(:closed_at => nil) if !self.closed_at.nil?
      end
      
      results = Lighthouse.get_milestone_tickets(self.name, self.project.remote_id, self.project.token.account, self.project.token.token)
      ticket_ids = results["tickets"] ? results["tickets"].collect{ |t| t["number"] }.join(",") : ""

      existing_event = self.milestone_events.first(:created_on.gte => Date.today, :milestone_id => self.id)
      if (existing_event)
        existing_event.update_attributes(:open_tickets => ticket_ids)
      else
        self.milestone_events.create(:open_tickets => ticket_ids)
      end
    end
    
  end
end