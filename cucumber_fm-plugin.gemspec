Gem::Specification.new do |s|
  s.name = 'cucumber_fm-plugin'
  s.version = '0.1.3'
  s.files = Dir['app/**/*'] + Dir['public/**/*'] + Dir['config/*.rb'] + ['LICENCE', 'README.rdoc']
  s.add_runtime_dependency 'cucumber_fm-core', '0.1'
  s.requirements << 'Rails, ~> v2.3.8'
  s.requirements << 'Rails, ~> v3.0.0'

  s.summary = "Help to manage with big amount of features in project"
  s.description = "Use it with cucumber_fm-core (for Rails version ~> 2.3., ~> 3.0)"

  s.authors = ["Michał Czyż [@cs3b]"]
  s.email = 'michalczyz@gmail.com'
  s.homepage = 'http://cucumber.fm'

  s.license = 'MIT'
end
