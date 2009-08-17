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
  fixtures :member, :moffice

  it "should render the representatives page exactly the same as the php version" do
    # Setting User-Agent so that the php code outputs the default stylesheets
    expected = Hpricot(open("http://dev.openaustralia.org/mps/", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    File.open("expected.html", "w") {|f| f.write(expected) }
    get "/mps/"
    result = Hpricot(@response.body).to_html
    # Write out the expected and resulting html
    File.open("result.html", "w") {|f| f.write(result) }
    system("tidy -q -m expected.html")
    system("tidy -q -m result.html")
    expected = File.read("expected.html")
    result = File.read("result.html")
    result.should == expected
    ["expected.html", "result.html"].each {|f| File.delete(f)}
  end
  
  it "should render the senators page exactly the same as the php version" do
    # Setting User-Agent so that the php code outputs the default stylesheets
    expected = Hpricot(open("http://dev.openaustralia.org/senators/", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    File.open("expected_senators.html", "w") {|f| f.write(expected) }
    get "/senators/"
    result = Hpricot(@response.body).to_html
    # Write out the expected and resulting html
    File.open("result_senators.html", "w") {|f| f.write(result) }
    system("tidy -q -m expected_senators.html")
    system("tidy -q -m result_senators.html")
    expected = File.read("expected_senators.html")
    result = File.read("result_senators.html")
    result.should == expected
    ["expected_senators.html", "result_senators.html"].each {|f| File.delete(f)}
  end
  
end

