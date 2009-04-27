module Burndown
  class Token
    include DataMapper::Resource
    
    property :id,         Serial
    property :token,      String, :nullable => false
    property :account,    String, :nullable => false
    property :note,       String
    
    validates_present :token, :account
    validates_is_unique :token
    
    # Checks the Lighthouse API to make sure the token is good
    def valid_lighthouse_token?
      get_lighthouse_token
      @lighthouse_token["token"] ? true : false
    end
    
    # Retrieves the note of the token from Lighthouse
    def set_note
      get_lighthouse_token
      self.note = @lighthouse_token["token"]["note"] || "N/A"
    end
    
  private
    def get_lighthouse_token
      @lighthouse_token ||= Lighthouse.get_token(self.account, self.token)
    end
  end
end