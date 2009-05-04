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
    
    def in_future?(day)
      Date.parse(day.to_s) > Date.today
    end
    
    # Ganked from Rails
    def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false, options = {})
      from_time = from_time.to_time if from_time.respond_to?(:to_time)
      to_time = to_time.to_time if to_time.respond_to?(:to_time)
      distance_in_minutes = (((to_time - from_time).abs)/60).round
      distance_in_seconds = ((to_time - from_time).abs).round

      case distance_in_minutes
        when 0..1
          return distance_in_minutes == 0 ? "less than one minute" : "#{distance_in_minutes} minutes" unless include_seconds

          case distance_in_seconds
            when 0..4   then  "less than 5 seconds"
            when 5..9   then  "less than 10 seconds"
            when 10..19 then  "less than 20 seconds"
            when 20..39 then  "half a minute"
            when 40..59 then  "less than a minute"
            else              "1 minute"
          end

        when 2..44           then  "#{distance_in_minutes} minutes"
        when 45..89          then  "about 1 hour"
        when 90..1439        then  "about #{(distance_in_minutes.to_f / 60.0).round} hours"
        when 1440..2879      then  "1 day"
        when 2880..43199     then  "#{(distance_in_minutes / 1440).round} days"
        when 43200..86399    then  "about 1 month"
        when 86400..525599   then  "#{(distance_in_minutes / 43200).round} months"
        when 525600..1051199 then  "about 1 year"
        else                       "over #{(distance_in_minutes / 525600).round} years"
      end
    end
  end
end