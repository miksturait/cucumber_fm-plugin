module CucumberFM
  class Config
    attr_accessor :dir, :tags, :aggregate, :sort, :display_as, :cvs_commit, :cvs_push

    def initialize(params={})
      set_default_values
      update(params)
    end

    def aggregate_options
      [''] + CucumberFM::FeatureElement::Component::Tags::PATTERN.keys.map(& :to_s)
    end

    private

    def set_default_values
      update(
              {
                      :dir => '',
                      :tags => '',
                      :aggregate => '',
                      :sort => '',
                      :display_as => 'list',
                      :cvs_commit => true,
                      :cvs_push => true
              })

    end

    def update(params)
      params.each_pair do |attribute, value|
        send("#{attribute}=", value) if respond_to? attribute
      end
    end
  end
end