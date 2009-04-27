require File.dirname(__FILE__) + "/../helpers"

class TokenTest < Test::Unit::TestCase
  before(:all) do
    @token = Token.generate
  end
  
  it "creates a token without errors" do
    lambda do
      Token.create(:account => "Foo", :token => "bar")
    end.should change(Token, :count).by(1)
  end
end