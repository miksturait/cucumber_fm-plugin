module CucumberFM
  class TagFilter < Struct.new(:expression)

    TAG_PATTERN = CucumberFM::FeatureElement::Component::Tags::TAG_PATTERN
    AND_PATTERN = /\s+/
    OR_PATTERN = /,/
    NOT_PATTERN = /~/

    TOKEN = Regexp.union(TAG_PATTERN,
                         AND_PATTERN,
                         OR_PATTERN,
                         NOT_PATTERN)

    def pass?(tags)
      if expression.nil? or expression.empty?
        true
      else
        evaluate_expression(tags)
      end
    end

    private


    # TODO - refactoring

    def evaluate_expression(tags)
      buffer = nil
      buffer_array = []
      buffer_negation = nil

      text = expression
      while token = text.match(TOKEN)

        case token[0]
          when TAG_PATTERN
            throw "Error at #{expression} | token: #{token[0]} | last token: #{buffer}" unless buffer.nil?
            buffer = token[0]
          when NOT_PATTERN
            buffer_negation = true
          when AND_PATTERN
            if buffer_array.empty? and buffer
              return(false) unless (!buffer_negation == tags.include?(buffer))
              buffer = nil
              buffer_negation = nil
              true
            elsif !buffer_array.empty?
              if buffer
                buffer_array.push(buffer)
                buffer = nil
              end
              return(false) unless (!buffer_negation == buffer_array.any? { |tag| tags.include? tag })
              buffer_array = []
              buffer_negation = nil
              true
            else
              true
            end
          when OR_PATTERN
            buffer_array.push buffer
            buffer = nil
        end

        text = token.post_match
      end

      if buffer_array.empty? and buffer
        return(false) unless (!buffer_negation == tags.include?(buffer))
        buffer = nil
        buffer_negation = nil
        true
      elsif !buffer_array.empty?
        if buffer
          buffer_array.push(buffer)
          buffer = nil
        end
        return(false) unless (!buffer_negation == buffer_array.any? { |tag| tags.include? tag })
        buffer_array = []
        buffer_negation = nil
        true
      else
        true
      end
    end
  end
end