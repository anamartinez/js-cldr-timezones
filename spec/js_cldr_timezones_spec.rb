require "spec_helper"

describe JsCldrTimezones do
  it "has a VERSION" do
    JsCldrTimezones::VERSION.should =~ /^[\.\da-z]+$/
  end
end
