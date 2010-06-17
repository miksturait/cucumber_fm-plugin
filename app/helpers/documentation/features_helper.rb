module Documentation
  module FeaturesHelper

    def draw_report_rows(cfm)
      if cfm.aggregate
        draw_aggregate(cfm.aggregate)
      else
        draw_features(cfm.features)
      end
    end

    def draw_features(features)
      features.collect{|feature| draw_feature(feature, feature.scenarios)}.join
    end

    def draw_feature(feature, scenarios)
      feature_header(feature) <<
              scenario_rows(scenarios)
    end

    def draw_aggregate(aggregate, level=1)
      aggregate.keys.collect { |key|
        key.is_a?(CucumberFM::Feature) ?
                draw_aggregate_feature(key, aggregate[key]) + scenario_rows(aggregate[key]) :
                report_header(aggregate[key], key, level) << draw_aggregate(aggregate[key], level+1)
      }.join(''.html_safe).html_safe
    end

    # TODO missing information about estimation per feature
    def draw_aggregate_feature(feature, scenarios)
      content_tag 'tr', :class => 'feature_header' do
        content_tag('td') <<
                content_tag('td', link_to(feature.info.title, edit_documentation_feature_path(feature.id))) <<
                content_tag('td') <<
                content_tag('td', scenarios.size, :style => "text-align:center;") <<
                content_tag('td', scenarios.estimation, :style => "text-align:center;")
      end
    end

    def report_header(collection, name, level)
      warning_class = (name == '_undefined_' ? ' warning' : '')
      content_tag 'tr', :class => "raport_header level_#{level}#{warning_class}" do
        content_tag('td', name, :colspan => 2) <<
                content_tag('td', collection.features.size, :style => "text-align:center;") <<
                content_tag('td', collection.scenarios.size, :style => "text-align:center;") <<
                content_tag('td', collection.estimation, :style => "text-align:center;")
      end
    end

    def feature_header(feature)
      content_tag 'tr', :class => 'feature_header' do
        content_tag('td') <<
                content_tag('td', link_to(feature.info.title, edit_documentation_feature_path(feature.id))) <<
                content_tag('td') <<
                content_tag('td', feature.scenarios.size, :style => "text-align:center;") <<
                content_tag('td', feature.estimation, :style => "text-align:center;")
      end
    end

    def scenario_rows(scenarios)
      scenarios.inject("".html_safe) {|total, scenario| total << scenario_row(scenario) }
    end

    def scenario_row(scenario)
      content_tag('tr', :class => 'scenario_row') do
        content_tag('td') <<
                content_tag('td', scenario.title, :colspan => 3, :style => 'text-align: right;') <<
                content_tag('td', scenario.estimation, :style => 'text-align: center;')
      end
    end

    # assets

    def asset_link(path)
      "/documentation/assets/#{path}"
    end

    # menu highlighting
    def highlight(name)
      (@highlight == name) ? ' highlighted' : nil
    end
  end
end