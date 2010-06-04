module CucumberFM
  class TagFilter < Struct.new(:expression)
    def pass?(tags)
      if expression.nil? or expression.empty?
        true
      else
        tags.include?(expression)
      end
    end
  end
end