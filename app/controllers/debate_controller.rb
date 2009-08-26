class DebateController < ApplicationController
  def show
    raise "at the moment this method should only work for one id value" unless params[:id] == "2009-05-14.65.2"
    
    @subheading = Hansard.find_by_gid("uk.org.publicwhip/debate/#{params[:id]}")
    @subheading_text = @subheading.text_object.body
    
    @title = "#{@subheading_text}: 14 May 2009: House debates"
    @extra_keyword = "#{@subheading_text}: 14 May 2009"
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
  end
  
  # Display a single speech
  def speech
    raise "at the moment this method should only work for one id value" unless params[:id] == "2009-05-14.66.1"

    @speech = Hansard.find_by_id(params[:id])
    @member = @speech.speaker

    @speech_text = @speech.text_object.display_body
    @date = @speech.hdate
    truncated = "I do not propose to long detain the..."
    @title = "#{truncated}: #{@date.to_formatted_s(:simple)}: House debates"
    @extra_keyword = "#{truncated}: #{@date.to_formatted_s(:simple)}"
    @debates_menu_on = true
  end
end
