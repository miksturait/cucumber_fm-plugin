if Rails::VERSION::STRING =~ /^2\.3/
  ActionController::Routing::Routes.draw do |map|
    map.namespace :documentation do |doc|
      doc.feature_show 'features/:id', :requirements => {:id => /.*[^(\/(edit|statistic))]/}, :conditions => {:method => :get},
                       :controller => 'features',
                       :action => 'show'
      doc.feature_update 'features/:id', :requirements => {:id => /.*[^(\/edit)]/}, :conditions => {:method => :post},
                         :controller => 'features',
                         :action => 'update'
      doc.resources :features, :member => [:rename, :move, :delete], :collection => [:statistic]
      doc.connect "assets/:path", :controller => 'assets', :action => 'get',
                  :requirements => {:path => /.*/}
    end
  end
else
  Rails.application.routes.draw do
    namespace :documentation do
      get 'features/:id', :action => 'features#show', :constraints => {:id => /.*[^(\/(edit|statistic))]/},
          :as => :feature_show
      post 'features/:id', :action => 'features#update', :constraints => {:id => /.*[^(\/edit)]/},
           :as => :feature_update
      resources :features do
        get 'statistic', :on => :collection
        member do
          match 'rename'
          match 'move'
          match 'delete'
        end
      end
    end
    match "documentation/assets/:path", :controller => "documentation/assets", :action => "get", :constraints => {:path => /.*/}
  end
end
