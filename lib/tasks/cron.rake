task :cron => :environment do
  if Time.now.hour == 0
    puts "Updating milestones..."
    Burndown::Milestone.sync_with_lighthouse
    puts "done."
  end
end