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
  
end