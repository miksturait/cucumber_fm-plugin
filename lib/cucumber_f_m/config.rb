module CucumberFM
  class Config
    attr_accessor :dir, :tags, :aggregate, :sort, :display_as

    def initialize(params)
      self.dir = (params['dir'] || '')
      self.tags = (params['tags'] || '')
      self.aggregate = (params['aggregate'] || '')
      self.sort = (params['sort'] || '')
      self.display_as = (params['display_as'] || 'list')
    end

    def aggregate_options
      [''] + CucumberFM::FeatureElement::Component::Tags::PATTERN.keys.map(&:to_s)
    end
  end
end