Gem::Specification.new do |s|
  s.name        = 'markup-email'
  s.version     = '0.3.5'
  s.required_ruby_version = '>= 1.9.2'
  s.executables << 'markup-email'
  s.add_runtime_dependency 'github-markup', '~> 1.6', '>= 1.6.0'
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
