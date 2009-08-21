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
  fixtures :member, :moffice, :personinfo, :hansard, :epobject

  def tidy(text)
    File.open("temp.html", "w") {|f| f.write(text) }
    system("tidy -q -m temp.html")
    r = File.read("temp.html")
    # Make sure that comments of the form <!-- comment --> are followed by a new line
    File.delete("temp.html")
    r.gsub("--><", "-->\n<")
  end
  
  def compare_with_php(url, name, use_cache_file = false)
    if use_cache_file && File.exists?("cached_#{name}.html")
      expected = File.read("cached_#{name}.html")
    else
      # Setting User-Agent so that the php code outputs the default stylesheets
      expected = Hpricot(open("http://dev.openaustralia.org#{url}", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    end
    if use_cache_file && !File.exists?("cached_#{name}.html")
      File.open("cached_#{name}.html", "w") {|f| f.write(expected)}
    end
    
    get url
    result = Hpricot(@response.body).to_html

    expected_tidy = tidy(expected)
    result_tidy = tidy(result)
    if result_tidy == expected_tidy
      ["expected_#{name}.html", "result_#{name}.html", "expected_#{name}_tidy.html", "result_#{name}_tidy.html"].each do |f|
        File.delete(f) if File.exists?(f)
      end
    else
      # If failed then write out result for easy comparison
      File.open("expected_#{name}.html", "w") {|f| f.write(expected)}
      File.open("result_#{name}.html", "w") {|f| f.write(result)}
      File.open("expected_#{name}_tidy.html", "w") {|f| f.write(expected_tidy)}
      File.open("result_#{name}_tidy.html", "w") {|f| f.write(result_tidy)}
    end
    result_tidy.should == expected_tidy
  end
  
  it "should render the representatives page exactly the same as the php version" do
    compare_with_php("/mps/", "mps")
  end
  
  it "should render the senators page exactly the same as the php version" do
    compare_with_php("/senators/", "senators")
  end
  
  it "should render the page of an individual senator the same as the php version" do
    compare_with_php("/senator/eric_abetz/tasmania", "senator", true)
  end
  
  it "should render judith adam's page correctly" do
    compare_with_php("/senator/judith_adams/wa", "judith_adams", true)
  end
  
  it "should render tony abbott's page correctly" do
    compare_with_php("/mp/tony_abbott/warringah", "tony_abbott", true)
  end
  
  it "should render a speech correctly" do
    compare_with_php("/debates/?id=2009-05-14.65.2", "debates")
  end
end

