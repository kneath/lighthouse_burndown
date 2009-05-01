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
    
    def page_info(options={})
      @title = options[:title]
      @breadcrumb = options[:breadcrumb]
      @page_id = options[:id]
    end
    
    def segmented_range(start_date, end_date, options = {}, &block)
      options[:segments] ||= 30
      options[:segements] = options[:segments] - 1
      
      # Find the correct step size
      range = start_date..end_date
      step_size = [range.to_a.size/options[:segments], 1].max
      
      # We need to always include the last one, which may mean removing items from the beginning to satisfy...
      start_date = start_date + range.to_a.size % step_size + (step_size - 1)
      range = start_date..end_date
      
      range.step(step_size, &block)
    end
  end
end