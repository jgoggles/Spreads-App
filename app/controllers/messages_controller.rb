class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(params[:message])
    @topic = Topic.find(params[:message][:topic_id])
    @message.topic_id = @topic.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to :back, notice: 'Message posted.' }
      else
        #this is not the right way to do it, but going with it for now
        format.html { redirect_to :back, notice: "You have to enter a message" }
        # this SHOULD work but ir fucking doesnt
        # format.html { render :template => "/topics/show", :locals => { :topic_id => @topic.id, :message => @message } }
      end
    end
  end

end
