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
  fixtures :member, :moffice, :personinfo, :hansard, :epobject, :users, :comments

  def tidy(text)
    File.open("temp.html", "w") {|f| f.write(text) }
    # Requires HTML Tidy (http://tidy.sourceforge.net/) version 14 June 2007 or later
    system("tidy --sort-attributes alpha -q -m temp.html")
    r = File.read("temp.html")
    # Make sure that comments of the form <!-- comment --> are followed by a new line
    File.delete("temp.html")
    r.gsub("--><", "-->\n<")
  end
  
  def compare_with_php(url, name, use_cache_file = false)
    cached_filename = File.dirname(__FILE__) + "/../regression_data/#{name}.html"
    if use_cache_file && File.exists?(cached_filename)
      expected = File.read(cached_filename)
    else
      # Setting User-Agent so that the php code outputs the default stylesheets
      expected = Hpricot(open("http://dev.openaustralia.org#{url}", "User-Agent" => "Ruby/#{RUBY_VERSION}")).to_html
    end
    if use_cache_file && !File.exists?(cached_filename)
      File.open(cached_filename, "w") {|f| f.write(expected)}
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
    compare_with_php("/senator/eric_abetz/tasmania", "eric_abetz", true)
  end
  
  it "should render judith adam's page correctly" do
    compare_with_php("/senator/judith_adams/wa", "judith_adams", true)
  end
  
  it "should render tony abbott's page correctly" do
    compare_with_php("/mp/tony_abbott/warringah", "tony_abbott", true)
  end
  
  it "should render a debate correctly" do
    compare_with_php("/debates/?id=2009-05-13.1.2", "debates-2009-05-13")
    compare_with_php("/debates/?id=2009-05-14.1.2", "debates-2009-05-14")
  end
  
  it "should render a single speech correctly" do
    compare_with_php("/debate/?id=2009-05-14.2.1", "speech1")
  end

  it "should render a single speech correctly" do
    compare_with_php("/debate/?id=2009-05-14.2.2", "speech2")
  end
  
  it "should render a list of all debates on a single day in the House of Representatives correctly" do
    compare_with_php("/debates/?d=2009-05-13", "debates_2009_05_13")
    compare_with_php("/debates/?d=2009-05-14", "debates_2009_05_14")
  end
  
  it "should render the calendar for the year 2009" do
    # Because we're using a cached version to compare with we need to change the effective date
    Date.stub!(:today).and_return(Date.new(2009,9,8))
    compare_with_php("/debates/?y=2009", "debates_2009", true)
  end
  
  it "should render the main debate page" do
    compare_with_php("/hansard/", "hansard")
  end
  
  it "should render the main news page" do
    compare_with_php("/news/", "news")
  end
  
  it "should render an individual news item" do
    compare_with_php("/news/archives/2009/05/12/our_new_home_on_", "news_2009_05_12", true)
    compare_with_php("/news/archives/2009/05/06/opening_up_the_p", "news_2009_05_06", true)
  end
  
  it "should render the news archive for a month" do
    compare_with_php("/news/archives/2009/05", "news_2009_05", true)
    compare_with_php("/news/archives/2009/02", "news_2009_02", true)
    compare_with_php("/news/archives/2008/06", "news_2008_06", true)
  end
  
  it "should render recent comments" do
    compare_with_php("/comments/recent/", "comments_recent")
  end
  
  it "should redirect a member url with id to the pretty version" do
    get "/mp/?m=1"
    response.should redirect_to(:controller => "member", :action => "show", :name => "tony_abbott", :constituency => "warringah")
  end
  
  it "should redirect a link to a section to the first subsection" do
    get "/debates/?id=2009-05-14.1.1"
    response.should redirect_to(:controller => "debate", :action => "debate", :id => "2009-05-14.1.2")
  end
  
  it "should render the static help page" do
    compare_with_php("/help/", "help")
  end
  
  it "should render the static about page" do
    compare_with_php("/about/", "about")
  end
end

