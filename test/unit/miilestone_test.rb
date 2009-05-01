require File.dirname(__FILE__) + "/../helpers"

class MiilestoneTest < Test::Unit::TestCase
  before(:all) do
    @token = Token.generate
    @activated_project = Project.generate(:token_id => @token.id)
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
  end
  
  it "sets up existing milestones when activating a project" do
    lambda do
      p = Project.activate_remote(42, @token)
    end.should change(Milestone, :count).by(3)
  end
  
end