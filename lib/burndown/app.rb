module Burndown
  class App < Sinatra::Default
    set :root,     File.dirname(__FILE__) + "/../.."
    set :app_file, __FILE__
    enable :sessions

    include Burndown
    include Burndown::Helpers
    
    # project listing
    get "/" do
      show :index
    end
    
  end
end