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
    body = conversation_params[:body]
    subject = conversation_params[:subject]
    if create_params[:type] == 'new_conversation'
      user_id = conversation_params[:user_id]
      user = User.find(user_id)
      receipt = @current_user.send_message(user, body, subject)
      render json: receipt.conversation, status: 201
    elsif create_params[:type] == 'new_broadcast_conversation'
      if !conversation_params[:receivers].empty?
        all_receivers = []
        
        conversation_params[:receivers][:groups].map do 
          |g| all_receivers.push(Group.find(g).students)
        end if !conversation_params[:receivers][:groups].nil?

        conversation_params[:receivers][:lessons].map do 
          |l| all_receivers.push(Lesson.find(l).students)
        end if !conversation_params[:receivers][:lessons].nil?
        
        conversation_params[:receivers][:users].map do 
          |u| all_receivers.push(User.find(u)) 
        end if !conversation_params[:receivers][:users].nil?
        receipt = @current_user.send_message(all_receivers.flatten.uniq, body, subject)

        render json: receipt.conversation, status: 201
      else 
        render json: {error: 'Empty receivers list'}, status: 404
      end
    end
  end

  private

    def conversation_params
      params.require(:conversation).permit(:body, :sender_id, :user_id, 
                                           :subject, receivers: [:groups => [], :lessons => [], :users => []])
    end

    def create_params
      params.permit(:type, :id)
    end

end
