module CucumberFM
  module FeatureElement
    module Component
      module Tags
        # TODO think about priority in tags - those in scenario should have value than this in feature
        LINE_PATTERN = /^\s*@\S.*$/
        TAG_PATTERN = /@\S+/

        PATTERN = {
                :component => /@[a-z]\S{3,}\z/,
                :milestone => /@m\d.?\z/,
                :status => /@_[a-z]\S+\z/,
                :developer => /@[a-z]{2,3}\z/,
                :bucket => /@__[^\s\d]+/,
                :effort => /@\d/,
                :benefit => /@_\d/
                }

        TECHNICAL = [
                '@javascript',
                '@selenium',
                '@celerity',
                '@culerity',
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


        def estimation
          effort ? effort.gsub('@', '').to_f : 0.0
        end

        def value
          benefit ? benefit.gsub('@_', '').to_i : 0
        end

        private

        def fetch_tags
          this_tags + parent_tags
        end

        def this_tags
          if tag_line = LINE_PATTERN.match(raw)
            tag_line[0].scan(TAG_PATTERN)
          else
            []
          end
        end

        def parent_tags
          respond_to?(:second_tags_source) ? second_tags_source.this_tags : []
        end

        def find type
          tags.detect do |tag|
            !TECHNICAL.include?(tag) and tag =~ PATTERN[type]
          end
        end

        def method_missing(m, *args, &block)
          if PATTERN.has_key?(m.to_sym)
            find(m.to_sym)
          else
            super
          end
        end
      end
    end
  end
end