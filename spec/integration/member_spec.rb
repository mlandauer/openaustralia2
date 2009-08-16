require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'hpricot'
require 'open-uri'

# Monkeypatch ahoy
# Sort the outputted attributes into alphabetical order so that they can simply be compared
module Hpricot
  class STag < BaseEle
    def attributes_as_html
      if @raw_attributes
        @raw_attributes.sort.map do |aname, aval|
          " #{aname}" +
            (aval ? "=\"#{aval}\"" : "")
        end.join
      end
    end
  end
end

describe "MembersController" do
  fixtures :member

  it "should render the representatives page exactly the same as the php version" do
    expected = Hpricot(open("http://dev.openaustralia.org/mps")).to_html
    get "/member"
    result = Hpricot(@response.body).to_html
    # Write out the expected and resulting html
    File.open("expected.html", "w") {|f| f.write(expected) }
    File.open("result.html", "w") {|f| f.write(result) }
    system("tidy -q -m expected.html")
    system("tidy -q -m result.html")
    expected = File.read("expected.html")
    result = File.read("result.html")
    result.should == expected
  end
end

