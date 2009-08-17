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

  def tidy(text, temp_file)
    File.open(temp_file, "w") {|f| f.write(text) }
    system("tidy -q -m #{temp_file}")
    File.read(temp_file)
  end
  
  it "should render the representatives page exactly the same as the php version" do
    # Setting User-Agent so that the php code outputs the default stylesheets
    expected = Hpricot(open("http://dev.openaustralia.org/mps/", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    get "/mps/"
    result = Hpricot(@response.body).to_html

    tidy(result, "result.html").should == tidy(expected, "expected.html")
    ["expected.html", "result.html"].each {|f| File.delete(f)}
  end
  
  it "should render the senators page exactly the same as the php version" do
    # Setting User-Agent so that the php code outputs the default stylesheets
    expected = Hpricot(open("http://dev.openaustralia.org/senators/", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    get "/senators/"
    result = Hpricot(@response.body).to_html

    tidy(result, "result_senators.html").should == tidy(expected, "expected_senators.html")
    ["expected_senators.html", "result_senators.html"].each {|f| File.delete(f)}
  end
  
end

