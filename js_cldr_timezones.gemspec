$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "js_cldr_timezones"
require "#{name}/version"

Gem::Specification.new name, JsCldrTimezones::VERSION do |s|
  s.summary = "Cached translations of timezones for js"
  s.authors = ["Ana Martinez"]
  s.email = "acemacu@gmail.com"
  s.homepage = "http://github.com/anamartinez/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
end
