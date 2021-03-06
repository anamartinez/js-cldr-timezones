$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "js-cldr-timezones"
require "js_cldr/timezones/version"

Gem::Specification.new name, JsCldr::Timezones::VERSION do |s|
  s.summary = "Translated timezones according to CLDR for ruby rails assets"
  s.description = "Add translated timezones according to CLDR for your ruby rails assets"
  s.authors = ["Ana Martinez"]
  s.email = "acemacu@gmail.com"
  s.homepage = "http://github.com/anamartinez/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
end