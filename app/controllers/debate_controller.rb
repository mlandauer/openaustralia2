class DebateController < ApplicationController
  def show
    raise "at the moment this method should only work for one id value" unless params[:id] == "2009-05-14.65.2"
    
    @subheading = Hansard.find_by_gid("uk.org.publicwhip/debate/#{params[:id]}")
    @subheading_text = @subheading.to_s
    
    @titles = [@subheading_text, "14 May 2009", "House debates"]
    # Hack to deal with not entirely consistent behaviour of "Debates" menu
    @debates_menu_on = true
  end
  
  # Display a single speech
  def speech
    raise "at the moment this method should only work for one id value" unless params[:id] == "2009-05-14.66.1"

    @speech = Hansard.find_by_id(params[:id])
    @member = @speech.speaker

    @titles = [@speech.just_text, @speech.hdate.to_formatted_s(:simple), "House debates"]
    @debates_menu_on = true
  end
end
