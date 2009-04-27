module Burndown
  class Token
    include DataMapper::Resource
    
    property :id,         Serial
    property :token,      String, :nullable => false
    property :account,    String, :nullable => false
    
    validates_present :token, :account
    
    # Checks the Lighthouse API to make sure the token is good
    def valid_lighthouse_token?
      Lighthouse.check_token(self.account, self.token)
    end
  end
end