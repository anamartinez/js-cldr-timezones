$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "js-cldr-timezones"
require "js_cldr/timezones/version"

Gem::Specification.new name, JsCldr::Timezones::VERSION do |s|
  s.summary = "Cached translations of timezones for js"
  s.authors = ["Ana Martinez"]
  s.email = "acemacu@gmail.com"
  s.homepage = "http://github.com/anamartinez/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
end