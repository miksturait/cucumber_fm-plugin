module CucumberFM
  module FeatureElement
    module Component
      module Tags
        LINE_PATTERN = /^\s*@\S.*$/
        TAG_PATTERN = /@[^,\s]+/

        PATTERN = {
                :component => /@[a-z]\S{3,}\z/,
                :milestone => /@m\d.?\z/,
                :iteration => /@i\d+\z/,
                :priority => /@p\d+\z/,
                :status => /@_[a-z]\S+\z/,
                :developer => /@[a-z]{2,3}\z/,
                :bucket => /@__[^\s\d]+/,
                :effort => /@\d/,
                :benefit => /@_\d/,
                :something_todo => /@:::[a-z]{2,3}\z/,
                :role => /@\$_[a-z_]+/
        }

        TECHNICAL = [
                '@javascript',
                '@selenium',
                '@celerity',
                '@culerity',
                '@mongo',
                '@allow-rescue',
                '@needs_wireframe',
                '@tested_elsewhere',
                '@added',
                '@nontestable',
                '@additional-test'
        ]

        def tags
          @tags ||= fetch_tags
        end

        def tags= tags
          @tags = tags
        end

        def done?
          %w(@_done @_qa @_tested @_accepted).include?(status)
        end


        def estimation
          effort ? effort.gsub('@', '').to_f : 0.0
        end

        def value
          benefit ? benefit.gsub('@_', '').to_i : 0
        end

        private

        def fetch_tags
          this_tags + parent_tags_without_duplicates
        end

        def this_tags
          if tag_line = LINE_PATTERN.match(raw)
            tag_line[0].scan(TAG_PATTERN)
          else
            []
          end
        end

        def parent_tags
          respond_to?(:second_tags_source) ? second_tags_source.tags : []
        end

        def parent_tags_without_duplicates
           parent_tags.collect { |p_tag| (type = detect_type(p_tag) and find(type, this_tags)) ? nil : p_tag }.compact
        end

        def find type, collection = tags
          collection.detect do |tag|
            !TECHNICAL.include?(tag) and tag =~ PATTERN[type]
          end
        end

        def detect_type tag
          PATTERN.invert.each_pair do |pattern, type|
            return(type) if tag =~ pattern   
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