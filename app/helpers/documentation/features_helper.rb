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
      features.collect { |feature| draw_feature(feature, feature.scenarios) }.join
    end

    def draw_feature(feature, scenarios)
      feature_header(feature) <<
              scenario_rows(scenarios)
    end

    def draw_aggregate(aggregate, level=1)
      aggregate.keys.sort.collect { |key|
        key.is_a?(CucumberFM::Feature) ?
                draw_aggregate_feature(key, aggregate[key]) + scenario_rows(aggregate[key]) :
                (key =~ CucumberFM::FeatureElement::Component::Tags::PATTERN[:status] ?
                        report_header(aggregate[key], key, level) :
                        report_header_with_percentage(aggregate[key], key, level)) << draw_aggregate(aggregate[key], level+1)
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

    # TODO make it a little bit cleaner
    def report_header_with_percentage(collection, name, level)
      warning_class = (name == '_undefined_' ? ' warning' : '')
      content_tag 'tr', :class => "raport_header level_#{level}#{warning_class}" do
        content_tag('td', name, :colspan => 2) <<
#  TODO calculate features complementary               
#                content_tag('td') do
#                  content_tag('div', :class => 'progress_bar w170') do
#                    content_tag('div', "NaN% from #{collection.features.size}", :class => 'percent') <<
#                            content_tag('div', :class => "bar_percent", :style => "width: 0%") do
#                              content_tag('div', '', :class => 'bar')
#                            end
#                  end
#                end <<
        content_tag('td', collection.features.size, :style => "text-align:center;") <<
                content_tag('td') do
                  content_tag('div', :class => 'progress_bar w170') do
                    content_tag('div', "#{collection.scenarios_done_percentage}% from #{collection.scenarios.size}",
                                :class => 'percent') <<
                            content_tag('div', :class => "bar_percent",
                                        :style => "width: #{collection.scenarios_done_percentage}%") do
                              content_tag('div', '', :class => 'bar')
                            end
                  end
                end <<
                content_tag('td') do
                  content_tag('div', :class => 'progress_bar w170') do
                    content_tag('div', "#{collection.estimation_done_percentage}% from #{collection.estimation}",
                                :class => 'percent') <<
                            content_tag('div', :class => "bar_percent",
                                        :style => "width: #{collection.estimation_done_percentage}%") do
                              content_tag('div', '', :class => 'bar')
                            end
                  end
                end
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
      scenarios.inject("".html_safe) { |total, scenario| total << scenario_row(scenario) }
    end

    def scenario_row(scenario)
      content_tag('tr', :class => 'scenario_row') do
        content_tag('td') <<
                content_tag('td', :colspan => 3, :style => 'text-align: left; padding-left: 25px;') do
                  link_to(scenario.title,
                          edit_documentation_feature_path(scenario.feature.id, :query => scenario.title),
                          :class => 'scenario_link')
                end <<
            # TODO refactor
                content_tag('td', scenario.done? ? scenario.estimation : content_tag('span', scenario.estimation, :class => "marker #{scenario.status == '@_todo' ? 'm_orange' : 'm_red'}"), :style => 'text-align: center;',
                            :class => (scenario.done? ? 'done' : 'not_done'))
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

    # STATISTICS

    def statistic_table(name, collection)
      content_tag('table', :class => 'generic statistic', :cellpadding => 0, :cellspacing => 0,
                  :style => 'padding-top: 20px;') do
        content_tag('thead') do
          content_tag('tr') do
            content_tag('th', name.to_s.humanize) <<
                    content_tag('th', 'Estimation', :style => 'width: 200px') <<
                    content_tag('th', "Number", :style => 'width: 200px')
          end
        end <<
                content_tag('tbody') do
                  collection.send(name).respond_to?(:keys) ?
                          statistic_collection(collection.send(name)) :
                          statistic_row(collection.send(name), name)
                end
      end
    end

    def statistic_collection(collection)
      collection.keys.sort.collect do |key|
        statistic_row(collection[key], key)
      end
    end

    def statistic_row(element, key)
      content_tag('tr') do
        content_tag('td', key) <<
                content_tag('td') do
                  content_tag('div', :class => 'progress_bar') do
                    content_tag('div', "#{element.estimation_done_percentage}% from #{element.estimation}", :class => 'percent') <<
                            content_tag('div', :class => 'bar_percent', :style => "width: #{element.estimation_done_percentage}%") do
                              content_tag('div', '', :class => 'bar')
                            end
                  end
                end <<
                content_tag('td') do
                  content_tag('div', :class => 'progress_bar') do
                    content_tag('div', "#{element.scenarios_done_percentage}% from #{element.scenarios.size}", :class => 'percent') <<
                            content_tag('div', :class => 'bar_percent', :style => "width: #{element.scenarios_done_percentage}%") do
                              content_tag('div', '', :class => 'bar')
                            end
                  end
                end
      end
    end
  end
end