module CucumberFM
  class TagFilter < Struct.new(:expression)

    def pass?(tags)
      if expression.nil? or expression.empty?
        true
      else
        !evaluate_expression(tags).include?(false)
      end
    end

    private

    def evaluate_expression(tags)
      expression.split(/\s+/).collect do |element|
        tags.include?(element)
      end
    end
  end
end