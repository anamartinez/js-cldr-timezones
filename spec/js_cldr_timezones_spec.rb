require "spec_helper"

describe JsCldr::Timezones do
  it "has a VERSION" do
    JsCldr::Timezones::VERSION.should =~ /^[\.\da-z]+$/
  end

  describe ".generate_timezones" do
    it "raises error if template is empty" do
      JsCldr::Timezones.should_receive(:cldr_timezones_template).and_return(nil)
      expect{JsCldr::Timezones.generate_timezones}.to raise_error(ArgumentError, "Template is empty")
    end

    it "calls create javascript for each locale" do
      JsCldr::Timezones.should_receive(:cldr_timezones_template).and_return("template")
      JsCldr::Timezones.should_receive(:create_javascript_file).exactly(573).times
      $stdout.should_receive(:putc).exactly(573).times
      $stdout.should_receive(:puts).once

      JsCldr::Timezones.generate_timezones
    end
  end

  #This verifies that the template wasn't modify by mistake
  describe ".cldr_timezones_template" do
    it "returns the template for timezones" do
      JsCldr::Timezones.send(:cldr_timezones_template).should eq("{{locale}}_cldr_timezones_hash = {\n  {{# timezones}}\n    \"{{identifier}}\":\"{{translation}}\",\n  {{/ timezones}}\n};")
    end
  end

  describe ".create_javascript_file" do
    it "builds the javascript file with timezones" do
      template = JsCldr::Timezones.send(:cldr_timezones_template)
      File.should_receive(:open).with(/lib\/assets\/javascripts\/js_cldr\/es_MX_cldr_timezones.js/, 'w')
      JsCldr::Timezones.should_receive(:build_attributes_for_mustache)
      JsCldr::Timezones.should_receive(:generate_javascript)

      JsCldr::Timezones.send(:create_javascript_file, template, :"es-MX")
    end
  end

  describe ".build_attributes_for_mustache" do
    it "builds the attributes use for mustache" do
      mustache_attributes = JsCldr::Timezones.send(:build_attributes_for_mustache, :"es-MX")
      mustache_attributes[:locale].should eq("es_MX")
      mustache_attributes[:timezones].should have(124).items
    end
  end

  describe ".js_friendly_locale" do
    it "Substitutes dash for underscore" do
      locale = JsCldr::Timezones.send(:js_friendly_locale, :"es-MX")
      locale.should eq("es_MX")
    end

    it "Leaves the locale alone if there is no substitution" do
      locale = JsCldr::Timezones.send(:js_friendly_locale, :es)
      locale.should eq("es")
    end
  end

  describe ".build_timezones_for_mustache" do
    it "raises error if Cldr::Timezones.list if locale is empty" do
      expect{JsCldr::Timezones.send(:build_timezones_for_mustache, nil)}.to raise_error(ArgumentError, "Locale cannot be blank")
    end

    it "raises error if locale is not supported" do
      expect{JsCldr::Timezones.send(:build_timezones_for_mustache, :blah)}.to raise_error(ArgumentError, "Locale is not supported")
    end

    it "raises error if Cldr::Timezones.list returns nothing" do
      Cldr::Timezones.stub(:list => nil)
      expect{JsCldr::Timezones.send(:build_timezones_for_mustache, :es)}.to raise_error(ArgumentError, "Cldr::Timezones returned zero timezones")
    end

    it "returns the timezones mapped for mustache" do
      Cldr::Timezones.stub(:list => {"test of identifier" => "test of translation", "test of identifier 2" => "test of translation 2"})
      mustache_attributes = JsCldr::Timezones.send(:build_timezones_for_mustache, :es)
      mustache_attributes.should eq([{:identifier => "test of identifier", :translation => "test of translation"}, {:identifier => "test of identifier 2", :translation => "test of translation 2"}])
    end
  end

  describe ".generate_javascript" do
    it "generates the javascript using mustache" do
      template = JsCldr::Timezones.send(:cldr_timezones_template)
      mustache_attributes = {:locale => "test_of_locale", :timezones => {:identifier => "timezone_identifier", :translation => "timezone_translation"}}

      js = JsCldr::Timezones.send(:generate_javascript, template, mustache_attributes)
      js.should eq("test_of_locale_cldr_timezones_hash = {\n    \"timezone_identifier\":\"timezone_translation\"\n};")
    end
  end
end
