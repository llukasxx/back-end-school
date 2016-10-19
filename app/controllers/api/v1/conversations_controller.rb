class Api::V1::ConversationsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    inbox = @current_user.mailbox.conversations
    render json: inbox
  end

  def update
    body = conversation_params[:body]
    conversation = Mailboxer::Conversation.find(create_params[:id])
    @current_user.reply_to_conversation(conversation, body)
    render json: conversation.reload, status: 201
  end

  def create
    conversation = Conversation::ConversationCreation.new(@current_user, params)
    if conversation.save!
      render json: conversation.get_conversation, status: :created
    else
      render json: conversation.errors, status: 404
    end
  end

  private

    def conversation_params
      params.require(:conversation).permit(:body, :sender_id, :user_id, 
                                           :subject, receivers: [:groups => [], 
                                                                 :lessons => [], 
                                                                 :users => []])
    end

    def create_params
      params.permit(:type, :id)
    end

end
