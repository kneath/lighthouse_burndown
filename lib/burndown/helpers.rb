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
    
    def segmented_range(start_date, end_date, options = {}, &block)
      options[:segments] ||= 30
      options[:segements] = options[:segments] - 1
      range = start_date..end_date
      
      step_size = [range.to_a.size/options[:segments], 1].max
      (start_date..end_date).step(step_size, &block)
    end
  end
end