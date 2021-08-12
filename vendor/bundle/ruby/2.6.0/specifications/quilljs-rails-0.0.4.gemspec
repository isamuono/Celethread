# -*- encoding: utf-8 -*-
# stub: quilljs-rails 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "quilljs-rails".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Abhinav Mathur".freeze]
  s.date = "2017-04-02"
  s.description = "".freeze
  s.email = ["amathur5000@gmail.com".freeze]
  s.homepage = "https://www.github.com/abhinavmathur/quilljs-rails".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.3".freeze)
  s.rubygems_version = "3.0.4".freeze
  s.summary = "This gem adds quill rich text editor to input fields".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.13"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<jquery-rails>.freeze, ["~> 4.1"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.13"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.1"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.13"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<jquery-rails>.freeze, ["~> 4.1"])
  end
end
