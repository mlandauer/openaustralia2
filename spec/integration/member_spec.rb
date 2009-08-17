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
    unless File.exists?("expected.html")
      expected = Hpricot(open("http://dev.openaustralia.org/mps")).to_html
      File.open("expected.html", "w") {|f| f.write(expected) }
    end
    get "/member/representatives"
    result = Hpricot(@response.body).to_html
    # Write out the expected and resulting html
    File.open("result.html", "w") {|f| f.write(result) }
    system("tidy -q expected.html > expected_tidy.html")
    system("tidy -q result.html > result_tidy.html")
    expected = File.read("expected_tidy.html")
    result = File.read("result_tidy.html")
    result.should == expected
  end
  
  it "should render the senators page exactly the same as the php version" do
    unless File.exists?("expected_senators.html")
      expected = Hpricot(open("http://dev.openaustralia.org/senators")).to_html
      File.open("expected_senators.html", "w") {|f| f.write(expected) }
    end

    get "/member/senators"
    result = Hpricot(@response.body).to_html
    # Write out the expected and resulting html
    File.open("result_senators.html", "w") {|f| f.write(result) }
    system("tidy -q expected_senators.html > expected_senators_tidy.html")
    system("tidy -q result_senators.html > result_senators_tidy.html")
    expected = File.read("expected_senators_tidy.html")
    result = File.read("result_senators_tidy.html")
    result.should == expected
  end
  
end

