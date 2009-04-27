module Burndown
  class App < Sinatra::Default
    set :root,     File.dirname(__FILE__) + "/../.."
    set :app_file, __FILE__
    enable :sessions

    include Burndown
    include Burndown::Helpers
    
    get "/" do
      show :index
    end
    
    get "/project" do
      show :project
    end
    
    get "/timeline" do
      @start_date = Date.new(2009, 3, 8)
      @due_date = Date.new(2009, 4, 30)
      show :timeline
    end
    
    get "/setup" do
      @tokens = Token.all
      show :setup
    end
    
    # Validates a token (AJAX method)
    post "/token_validity" do
      @token = Token.new(params[:token])
      status (@token.valid_lighthouse_token? ? 200 : 500)
    end
    
    # Creates a new token (AJAX method)
    post "/tokens" do
      @token = Token.new(params[:token])
      @token.set_data
      if @token.save
        status 200
      else
        status 500
      end
    end
    
  end
end