module CucumberFM
  module FeatureElement
    module Component
      module Tags
        LINE_PATTERN = /^\s*@\S.*$/
        TAG_PATTERN = /@\S+/

        COMPONENT_PATTERN = /@[a-z]\S{3,}\z/
        MILESTONE_PATTERN = /@m\d.?\z/
        STATUS_PATTERN = /@_[a-z]\S+\z/
        DEVELOPER_PATTERN = /@[a-z]{2,3}/
        BUCKET_PATTERN = /@__[^\s\d]+/
        ESTIMATION_PATTERN = /@\d/
        VALUE_PATTERN = /@_\d/
        TECHNICAL = [
                '@javascript',
                '@mongo',
                '@need-confirmation',
                '@question'
        ]

        def tags
          @tags ||= fetch_tags
        end

        def tags= tags
          @tags = tags
        end

        def module
          find(COMPONENT_PATTERN) || ( feature.module if respond_to?(:feature) )
        end

        private

        def fetch_tags
          if tag_line = LINE_PATTERN.match(raw)
            tag_line[0].scan(TAG_PATTERN)
          else
            []
          end
        end

        def find pattern
          tags.detect do |tag|
            !TECHNICAL.include?(tag) and tag =~ pattern
          end
        end
      end
    end
  end
end