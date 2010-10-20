module CucumberFM
  module FeatureElement
    class Comment < Struct.new(:ancestors, :raw)


      private

      def is_it_link
        raw =~ /^#:::[^:]+:::/
      end
    end
  end
end
