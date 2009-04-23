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
      show :setup
    end
    
  end
end