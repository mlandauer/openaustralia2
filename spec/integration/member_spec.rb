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

  def tidy(text)
    File.open("temp.html", "w") {|f| f.write(text) }
    system("tidy -q -m temp.html")
    r = File.read("temp.html")
    File.delete("temp.html")
    r
  end
  
  def compare_with_php(url, name)
    # Setting User-Agent so that the php code outputs the default stylesheets
    expected = Hpricot(open("http://dev.openaustralia.org#{url}", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    get url
    result = Hpricot(@response.body).to_html

    expected = tidy(expected)
    result = tidy(result)
    if result != expected
      # If failed then write out result for easy comparison
      File.open("expected_#{name}.html", "w") {|f| f.write(expected)}
      File.open("result_#{name}.html", "w") {|f| f.write(result)}
    end
    result.should == expected
  end
  
  it "should render the representatives page exactly the same as the php version" do
    compare_with_php("/mps/", "mps")
  end
  
  it "should render the senators page exactly the same as the php version" do
    compare_with_php("/senators/", "senators")
  end  
end

