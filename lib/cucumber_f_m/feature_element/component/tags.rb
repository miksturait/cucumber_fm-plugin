module CucumberFM
  module FeatureElement
    module Component
      module Tags
        LINE_PATTERN = /^\s*@\S.*$/
        TAG_PATTERN = /@\S+/

        PATTERN = {
                :component => /@[a-z]\S{3,}\z/,
                :milestone => /@m\d.?\z/,
                :status => /@_[a-z]\S+\z/,
                :developer => /@[a-z]{2,3}/,
                :bucket => /@__[^\s\d]+/,
                :estimation => /@\d/,
                :value => /@_\d/
                }

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
          find(PATTERN[:module]) || fetch_from_optional_tag_source(:module)
        end

        private

        def fetch_tags
          if tag_line = LINE_PATTERN.match(raw)
            tag_line[0].scan(TAG_PATTERN)
          else
            []
          end
        end

        def fetch_from_optional_tag_source(name)
          optional_tags_source.send(name) if respond_to(:optional_tags_source)
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