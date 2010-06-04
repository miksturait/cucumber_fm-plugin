module CucumberFM
  class TagFilter < Struct.new(:expression)
    def pass?(tags)
      tags.include?(expression)
    end
  end
end