class News
  attr_reader :user, :timestamp, :title, :content

  def initialize(atts)
    @timestamp = atts.delete(:timestamp)
    @user = atts.delete(:user)
    @title = atts.delete(:title)
    @content = atts.delete(:content)
    raise "Unexpected attributes: #{atts.keys.join(', ')}" unless atts.empty?
  end
  
  def year_param
    '%04d' % timestamp.year
  end
  
  def month_param
    '%02d' % timestamp.month
  end
  
  def day_param
    '%02d' % timestamp.day
  end
  
  def title_param
    title.parameterize('_')[0..15]
  end

  def News.all
    all = []
    all << News.new(
      :timestamp => DateTime.new(2009, 5, 12, 16, 30, 0, 0),
      :user => "Matthew",
      :title => "Our new home on Facebook",
      :content => <<-EOF
      <p>If you're a user of Facebook, come and visit <a href="http://www.facebook.com/pages/OpenAustralia/59877428354">our new home on Facebook</a> and invite your friends along. Do your bit by letting even more people know about OpenAustralia.org.</p>
      <p>Also, you can talk amongst your fellow OpenAustralia fans, leave comments, post links and all the usual stuff.</p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2009, 5, 6, 18, 15, 0, 0),
      :user => "Kat",
      :title => "Opening up the procedures of Parliament",
      :content => <<-EOF
      <p>So far we've shown you what they say (speeches) not what they do (procedures). Believe it or not proceedings of Parliament take place within a highly structured system. The speeches don't always give the full picture of what's going on. So, to help provide some more context, we've now added "procedural text".</p>
      <p>Procedural text is a standardised description of what's going on. Examples include: someone putting forward a motion, reading a bill, a debate ending, or someone leaving the chamber.</p>
      <p>We hadn't included it in the past because we simply hadn't supported the translation of the information from the official source.</p>
      <p>Also, we have a further incentive. It's also preparation for some very exciting new developments which we hope to announce soon!</p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2009, 2, 26, 8, 30, 0, 0),
      :user => "Matthew",
      :title => "Another big step forward for government transparency in Australia",
      :content => <<-EOF
      <p>Today we proudly bring you the Register of Members' Interests. We have now made these extremely important documents available online for the first time ever.</p>
      <p>In the Register of Interests, Representatives and Senators declare information of financial interests, stocks and shares held, gifts received over a certain value, and memberships of Clubs and Associations.</p>
      <p>Now, the Register of Interests is available for all sitting Senators and Representatives and is available at the bottom of each of their pages.</p>
      <p>See, for instance, the <a href="/mp/kevin_rudd/griffith#register">Register of Interests for the Prime Minister, Kevin Rudd</a>, available at the bottom of his page. (<a href="/regmem/scan/register_interests_10552.pdf">direct link</a>)</p>
      <p>This latest addition was largely made possible by the generous help of volunteer <a href="http://shiny.thorne.id.au/">Stephen Thorne</a> at <a href="http://netboxblue.com/">Netbox Blue</a> who scanned the 1500 pages of the Register of Members' Interests and <a href="http://www.aph.gov.au/HOUSE/dept/bios/bw.htm">Bernard Wright</a>, the Registrar of Members' Interests, for providing us with the hardcopy material.
      </p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2009, 2, 19, 17, 29, 0, 0),
      :user => "Matthew",
      :title => "Multiple email alerts over the last few days",
      :content => <<-EOF
      <p>
      <p>Some of you might have been getting multiple email alerts for the same day's speeches over the last few days. We're sorry about this. It turns out one of the email alerts was causing the mailing system to fail and each day it was retrying and sending out the old mails again. We found the wayward alert and fixed it. Tomorrow (Friday 20 February) you might get another duplicate email but after that everything should be back to normal.</p></p>
      <p>
      <p>As always, if you find a problem or something isn't working as expected please do let us know by <a href="mailto:contact@openaustralia.org">emailing us at contact@openaustralia.org</a>.</p></p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2009, 1, 5, 11, 5, 0, 0),
      :user => "Matthew",
      :title => "Read the Register of Senators' Interests here",
      :content => <<-EOF
      <p>Today is a big milestone. We are the first website to make the Register of Senators' Interests available online. This important public document until now has only been available to the small number of people who were able to visit the office in Canberra where the documents are held. In the Register each Senator declares information of financial interests, stocks and shares held, gifts received over a certain value, and memberships of Clubs and Associations.</p>
      <p>The register is available on each Senator's page. For example, <a href="/senator/judith_adams/wa#register">have a look at the Register for Senator Judith Adams</a>.
      <p>As soon as we can we will also make the Register of Members' Interests available online, the equivalent document for the Representatives. Our main obstacle right now is getting our paper copy of the register scanned. If you have access to a bulk scanner and can help please <a href="mailto:contact&#64;openaustralia.org">contact us</a>.</p></p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2008, 11, 3, 23, 57, 0, 0),
      :user => "Matthew",
      :title => "Government website changes everything",
      :content => <<-EOF
      <p>We've completely rewritten the engine that drives OpenAustralia. We didn't want to, the government (website) made us do it. No really. For a bit of background read our blog post <a href="http://blog.openaustralia.org/2008/10/13/why-is-openaustralia-not-getting-updated/">"Why is OpenAustralia not getting updated?"</a>.</p>
      <p>The outage of new update has only been over the last couple of weeks (from 13 Oct) and this all fixed now. I did quit a paying job to make it happen, so if that makes you feel like <a href="http://blog.openaustralia.org/join-us/">donating some money to us</a>, please go ahead!</p>
      <p>Catch up on the debates that happened while we were down. As of next week when parliament resumes, email updates will be back in action too.</p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2008, 10, 4, 12, 26, 0, 0),
      :user => "Matthew",
      :title => "A new look OpenAustralia",
      :content => <<-EOF
      <p>OpenAustralia has a lovely and sleek new look courtesy of <a href="http://www.purecaffeine.com/">Nathanael Boehm</a>.</p>
      <p>We're always interested in feedback, so let us know what you think by <a href="mailto:contact@openaustralia.org">emailing us</a> at the usual place. Enjoy! </p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2008, 8, 17, 19, 40, 0, 0),
      :user => "Katherine",
      :title => "The Senate is Here!",
      :content => <<-EOF
      <p>Just in time for the next sitting, for your civic pleasure, we bring you the Senate. Read the Senate Hansard as
      far back as 2006, and get to know those lovely people working on your behalf, the Senators.</p>
      <p>No bills pass without the say so of the Senate, so get over there and see what they're up to. Better still,
      write to them and ask them what they've been doing on your behalf over the recess.</p>
      <p>While we've tried to bring you a perfectly working website, it is in beta, so if you find anything broken,
      or see anything wrong, please <a href="mailto:contact@openaustralia.org">drop us a line</a>.</p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2008, 7, 6, 19, 56, 0, 0),
      :user => "Matthew",
      :title => "OpenAustralia behind the scenes",
      :content => <<-EOF
      <p>This news feed will tell you about updates to the site.</p>
      <p>There have been some pretty exciting developments behind the scenes, which you can follow on our blog at
      <a href="http://blog.openaustralia.org">blog.openaustralia.org</a>. There's a link at the bottom of every page as well.</p>
      <p>For live updates follow @openaustralia on <a href="http://www.twitter.com/openaustralia">twitter</a>. </p>
      EOF
    )
    all << News.new(
      :timestamp => DateTime.new(2008, 7, 6, 19, 35, 0, 0),
      :user => "Matthew",
      :title => "Photos on all representatives page",
      :content => <<-EOF
      <p>On the "<a href="/mps">All Representatives</a>" page you now get a photo for each member so you can more easily
      browse through the list and find the person you're looking for.</p>
      EOF
    )
    all
  end
end
