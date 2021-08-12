# -*- encoding: utf-8 -*-
# stub: pdfjs_viewer-rails 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "pdfjs_viewer-rails".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Yves Senn".freeze]
  s.date = "2019-02-14"
  s.description = "Packages the viewer distributed with PDF.js and makes it available in two styles (full, minimal).".freeze
  s.email = ["yves.senn@gmail.com".freeze]
  s.homepage = "https://github.com/senny/pdfjs_viewer-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.4".freeze
  s.summary = "PDF.js viewer packaged as a Rails engine.".freeze

  s.installed_by_version = "3.0.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, ["> 4.2.0"])
      s.add_runtime_dependency(%q<sass-rails>.freeze, ["~> 5.0"])
      s.add_runtime_dependency(%q<json>.freeze, ["> 1.8.4"])
      s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rails>.freeze, ["> 4.2.0"])
      s.add_dependency(%q<sass-rails>.freeze, ["~> 5.0"])
      s.add_dependency(%q<json>.freeze, ["> 1.8.4"])
      s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, ["> 4.2.0"])
    s.add_dependency(%q<sass-rails>.freeze, ["~> 5.0"])
    s.add_dependency(%q<json>.freeze, ["> 1.8.4"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
