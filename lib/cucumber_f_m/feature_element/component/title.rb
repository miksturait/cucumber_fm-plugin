module CucumberFM
  module FeatureElement
    module Component
      module Title
        
        def title
          @title ||= fetch_title
        end

        private

        def title_line_pattern
          /^\s*[A-Z][a-z]+:\s.*$/
        end

        def fetch_title
          if tag_line = title_line_pattern.match(raw)
            tag_line[0].gsub(/^[^:]*:/,'').strip
          else
            '--- no title found'
          end
        end
      end
    end
  end
end