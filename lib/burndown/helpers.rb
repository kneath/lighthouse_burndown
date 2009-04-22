module Burndown
  module Helpers
    include Rack::Utils
    alias :h :escape_html
    
    def show(template, options = {})
      @title = options[:title]
      erb template
    end
  end
end