# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_on_if_current(name, options, html_options)
    link_to_unless_current(name, options, html_options) do |name|
      link_to(name, options, html_options.merge(:class => "on"))
    end
  end
  
  def truncate(text, *args)
    options = args.extract_options!
    unless args.empty?
      ActiveSupport::Deprecation.warn('truncate takes an option hash instead of separate ' +
        'length and omission arguments', caller)

      options[:length] = args[0] || 30
      options[:omission] = args[1] || "..."
    end
    options.reverse_merge!(:length => 30, :omission => "...", :break_on_spaces => false)

    if text
      l = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      if chars.length > options[:length]
        chopped = chars[0...l]
        if options[:break_on_spaces]
          chopped = chopped.match(/(.*)\s.+/m)[1]
        end
        (chopped + options[:omission]).to_s
      else
        text.to_s
      end
    end
  end
  
  # Pass an absolute url
  def add_this(text, url)
    link_to text, "http://www.addthis.com/bookmark.php", :onmouseover => "return addthis_open(this, '', '#{url}', '');", :onmouseout => "addthis_close();", :onclick => "return addthis_sendto();"
  end
  
  def add_this_javascript
    <<-EOF
    <!-- ADDTHIS JAVASCRIPT BEGIN -->
    <script type="text/javascript">var addthis_pub = "foo";</script>
    <script src="http://s7.addthis.com/js/250/addthis_widget.js" type="text/javascript"></script>
    <!-- ADDTHIS JAVASCRIPT END -->
    EOF
  end
  
  # TODO: Would be nice if the following methods could be part of the routes.rb file where they really belong

  def debate_path(args)
    case args.delete(:house)
    when 1
      representatives_debate_path(args)
    when 2
      senate_debate_path(args)
    else
      raise "Unknown house"
    end
  end
  
  def member_path(args)
    case args.delete(:house)
    when 1
      representative_path(args)
    when 2
      senator_path(args)
    else
      raise "Unknown house"
    end
  end

  def speech_path(args)
    id = args.delete(:id)
    case args.delete(:house)
    when 1
      representative_speech_path(args.merge(:id => id))
    when 2
      senate_debate_path(args.merge(:gid => id))
    else
      raise "Unknown house"
    end
  end
end
