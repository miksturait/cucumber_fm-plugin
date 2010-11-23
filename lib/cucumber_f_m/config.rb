module CucumberFM
  class Config
    attr_accessor :dir, :tags, :aggregate, :sort, :display_as, :cvs_commit, :cvs_push

    def initialize(params={})
      set_default_values
      update(params)
    end

    def aggregate_options
      [''] + CucumberFM::FeatureElement::Component::Tags::PATTERN.keys.map(& :to_s).sort
    end

    private

    def set_default_values
      update(
              {
                      :dir => '',
                      :tags => '',
                      :aggregate => [],
                      :sort => '',
                      :display_as => 'list',
                      :cvs_commit => '1',
                      :cvs_push => '1'
              })

    end

    def update(params)
      params.each_pair do |attribute, value|
        setter_method_name = "#{attribute}="
        send(setter_method_name, value) if respond_to? setter_method_name
      end
    end
  end
end