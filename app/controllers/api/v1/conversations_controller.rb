class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_user_from_token!

  def get_conversations
    inbox = @current_user.mailbox.conversations.includes(messages: [:sender, receipts: [:receiver]])
    render json: inbox
  end

  def reply_to_conversation
    body = conversation_params[:body]
    conversation = Mailboxer::Conversation.find(params[:id])
    @current_user.reply_to_conversation(conversation, body)
    render json: conversation.reload, status: 201
  end

  def new_conversation
    body = conversation_params[:body]
    subject = conversation_params[:subject]
    user_id = conversation_params[:user_id]
    user = User.find(user_id)
    receipt = @current_user.send_message(user, body, subject)
    render json: receipt.conversation, status: 201
  end

  private

    def conversation_params
      params.require(:conversation).permit(:body, :sender_id, :user_id, 
                                           :subject, receivers: [:groups => [], :lessons => [], :users => []])
    end

end
