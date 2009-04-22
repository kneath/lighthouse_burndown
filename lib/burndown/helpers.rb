module Burndown
  module Helpers
    include Rack::Utils
    alias :h :escape_html
    
    def show(template, options = {})
      @title = options[:title]
      erb template
    end
    
    def link_to(title, url)
      %(<a href="#{url}">#{h(title)}</a>)
    end
    
    def page_info(options)
      @title = options[:title] if options[:title]
      @breadcrumb = options[:breadcrumb] if options[:breadcrumb]
    end
  end
end