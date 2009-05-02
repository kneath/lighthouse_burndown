require File.dirname(__FILE__) + "/../helpers"

class MiilestoneTest < Test::Unit::TestCase
  before(:all) do
    @token = Token.generate
    @activated_project = Project.generate(:token_id => @token.id)
    @milestone = @activated_project.milestones.create(:name => "TestMilestone", :remote_id => 42, :activated_at => DateTime.new(2001, 01, 01))
  end
  
  before(:each) do
    stub(Lighthouse).get_project{
      {
        "project" => {
          "name" => "RemoteFoo",
          "id" => "42"
        }
      }
    }
    
    stub(Lighthouse).get_milestones{
      {
        "milestones" => [
          {"name" => "FooMilestone",        "id" => "11"},
          {"name" => "FooBarMilestone",     "id" => "22"},
          {"name" => "FooBarBazMilestone",  "id" => "33"}
        ]
      }
    }
  end
  
  it "sets up existing milestones when activating a project" do
    lambda do
      p = Project.activate_remote(42, @token)
    end.should change(Milestone, :count).by(3)
  end
  
  it "returns the start date as activated_at" do
    @milestone.start_date.to_s.should == "2001-01-01T00:00:00+00:00"
  end
  
  it "knows the end date when a milestone has been closed" do
    m = Milestone.make(:closed_at => DateTime.new(2008, 05, 06), :due_on => DateTime.new(2008, 04, 06))
    m.end_date.should == DateTime.new(2008, 05, 06)
  end
  
  it "knows the end date when a milestone is due" do
    m = Milestone.make(:closed_at => DateTime.new(2008, 04, 06), :due_on => DateTime.new(2008, 05, 06))
    m.end_date.strftime("%m/%d/%y").should == DateTime.new(2008, 05, 06).strftime("%m/%d/%y")
  end
  
  it "knows the end date when not much is known" do
    m = Milestone.make(:closed_at => nil, :due_on => nil)
    m.end_date.strftime("%m/%d/%y").should == Time.now.to_datetime.strftime("%m/%d/%y")
  end
end