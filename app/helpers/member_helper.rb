module MemberHelper
  def nbsp_if_empty(text)
    if text == ""
      "&nbsp;"
    else
      text
    end
  end
end
