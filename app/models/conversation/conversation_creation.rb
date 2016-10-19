class Conversation
  class ConversationCreation
    attr_reader :sender, :params, 
                :receivers, :type,
                :body, :subject
    attr_accessor :receipt
    def initialize(sender, params)
      @sender = sender
      @params = params
      @type = params[:type]
      @receivers = params[:conversation][:receivers]
      @subject = params[:conversation][:subject]
      @body = params[:conversation][:body]
    end

    def save!
      if(params[:type] == 'new_conversation')
        user = get_users(params[:conversation][:user_id])
        @receipt = sender.send_message(user, body, subject)
      elsif(params[:type] == 'new_broadcast_conversation')
        users = get_users(receivers[:users]) | 
                get_groups_users(receivers[:groups]) |
                get_lessons_users(receivers[:lessons])
        @receipt = sender.send_message(users.flatten.uniq, body, subject)
      else
        raise ArgumentError, 'Wrong params provided'
      end 
    end

    def get_conversation
      @receipt.conversation
    end

    def errors
      @receipt.conversation.errors
    end

    private
      def get_groups_users(ids = [])
        students = Group.find(ids).map do |g|
          g.students
        end if ids.present?
        students.present? ? students : []
      end

      def get_lessons_users(ids = [])
        students = Lesson.find(ids).map do |l|
          l.students
        end if ids.present?
        students.present? ? students : []
      end

      def get_users(ids = [])
        users = User.find(ids) if ids.present?
        users.present? ? users : []
      end
  end
end