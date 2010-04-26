module CucumberFM
  module FeatureElement
    module Component
      module Title
        LINE_PATTERN = /^\s*[A-Z][a-z]+:\s.*$/
        TITLE_PATTERN = /@\S+/

        def title
          @title ||= fetch_title
        end

        private

        def fetch_title
          if tag_line = LINE_PATTERN.match(raw)
            tag_line[0].split(':').last.strip
          else
            []
          end
        end
      end
    end
  end
end