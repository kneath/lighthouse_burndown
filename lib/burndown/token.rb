module Burndown
  class Token
    include DataMapper::Resource
    
    property :id,         Serial
    property :token,      String, :nullable => false
    property :account,    String, :nullable => false
    
    validates_present :token, :account
  end
end