# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_on_if_current(name, options, html_options)
    link_to_unless_current(name, options, html_options) do |name|
      link_to(name, options, html_options.merge(:class => "on"))
    end
  end
  
  # TODO: There's most probably a standard method for doing this
  def escape_path(text)
    text.gsub('/','%2F').gsub('?', '%3F').gsub('=', '%3D').gsub('#', '%23')
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
end
