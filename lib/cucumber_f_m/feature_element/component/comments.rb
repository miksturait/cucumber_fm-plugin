module CucumberFM
  module FeatureElement
    module Component
      module Comments
        LINE_PATTERN = /^\s*#+.*$/

        def comments
          @comments ||= fetch_comments
        end

        private

        def fetch_comments
          raw.scan(LINE_PATTERN).collect do |comment_raw|
            CucumberFM::FeatureElement::Comment.new(self, comment_raw)
          end
        end
      end
    end
  end
end