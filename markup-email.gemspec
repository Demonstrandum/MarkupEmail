Gem::Specification.new do |s|
  s.name        = 'markup-email'
  s.version     = '1.1.3'
  s.required_ruby_version = '>= 1.9.2'
  s.executables << 'markup-email'
  s.add_runtime_dependency 'github-markup', '~> 1.6', '>= 1.6.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.8', '>= 1.8.0'
  s.add_runtime_dependency 'html-pipeline', '~> 2.6', '>= 2.6.0'
  s.add_runtime_dependency 'task_list', '~> 1.0', '>= 1.0.2'
  s.add_runtime_dependency 'github-linguist', '~> 2.10', '>= 2.12.1'
  s.add_runtime_dependency 'html-pipeline-rouge_filter', '~> 1.0', '>= 1.0.5'
  s.add_runtime_dependency 'sanitize', '~> 4.5', '>= 4.5.0'
  s.add_runtime_dependency 'gemoji', '~> 3.0', '>= 3.0.0'
  s.add_runtime_dependency 'rinku', '~> 2.0', '>= 2.0.2'
  s.date        = '2017-07-15'
  s.summary     = "E-mails from Markup"
  s.description = "Converting Markup to E-mails with github-markup"
  s.authors     = ["Demonstrandum"]
  s.email       = 'knutsen@jetspace.co'
  s.files       = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md)
  s.require_path= 'lib'
  s.homepage    = 'https://github.com/Demonstrandum/RubyFiglet'
  s.license     = 'GPL-3.0'
end
