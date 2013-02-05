require "mustache"
require "cldr/timezones"
require "js_cldr/timezones/version"

module JsCldr
  module Timezones
    class << self
      def generate_timezones(options = {})
        template = cldr_timezones_template
        raise ArgumentError, "Template is empty" unless template
        Cldr::Timezones.supported_locales.each do |locale| 
          create_javascript_file(template, locale)
          putc "."
        end
        puts
  		end

      private

      def cldr_timezones_template
        path = File.expand_path "../timezones/cldr_timezones.js.example", __FILE__
        File.read(path)
      end

      def create_javascript_file(template, locale)
        mustache_attributes = build_attributes_for_mustache(locale)
        javascript = generate_javascript(template, mustache_attributes)
        File.open(target_path + "/#{js_friendly_locale(locale)}_cldr_timezones.js", "w") {|target| target << javascript}
      end

      def build_attributes_for_mustache(locale)
        {:locale => js_friendly_locale(locale), 
         :timezones => build_timezones_for_mustache(locale)}
      end

      def js_friendly_locale(locale)
        locale = locale.to_s
        locale.gsub("-", "_")
      end

      def build_timezones_for_mustache(locale)
        timezones = Cldr::Timezones.list(locale)
        raise ArgumentError, "Cldr::Timezones returned zero timezones" unless timezones
        timezones.map {|identifier, translation| {:identifier => identifier, :translation => translation}}
      end

      def generate_javascript(template, mustache_attributes)
        compiled_javascript = Mustache.render(template, mustache_attributes)
        compiled_javascript.slice!(compiled_javascript.rindex(","))
        compiled_javascript
      end

      def target_path
        File.expand_path "lib/assets/javascripts/js_cldr"
      end
  	end
  end
end
