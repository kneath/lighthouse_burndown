module Burndown
  class App < Sinatra::Default
    set :root,     File.dirname(__FILE__) + "/../.."
    set :app_file, __FILE__
    enable :sessions

    include Burndown
    include Burndown::Helpers
    
    get "/" do
      @projects = Project.all
      show :index
    end
    
    get "/project/:id" do
      @project = Project.get(params[:id])
      show :project
    end
    
    get "/timeline/:id" do
      @milestone = Milestone.get(params[:id])
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
    
    post "/projects" do
      token = Token.get(params[:token_id])
      Project.activate_remote(params[:project_remote_id], token)
      redirect "/setup"
    end
    
  end
end