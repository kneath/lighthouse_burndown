require File.dirname(__FILE__) + "/../helpers"

class ProjectTest < Test::Unit::TestCase
  before(:all) do
    @token = Token.generate
  end
  
  it "activates a project via a token" do
    stub(Lighthouse).get_project{
      {
        "project" => {
          "name" => "RemoteFoo",
          "id" => "42"
        }
      }
    }
    lambda do
      p = Project.activate_remote(42, @token)
      p.name.should == "RemoteFoo"
      p.remote_id.should == 42
    end.should change(Project, :count).by(1)
  end
  
end