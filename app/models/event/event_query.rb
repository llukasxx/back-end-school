class Event
  class EventQuery
    attr_reader :filter, :kind, :user
    
    def initialize(filter: nil, kind: nil, user: nil)
      @filter = filter
      @kind = kind
      @user = user
    end

    def result_query
      filtered
    end

    def count
      result_query.count
    end

    private

      def filtered
        case [filter, kind]
        when %w(upcoming connected) then Event.upcoming.connected(user)
        when %w(upcoming created) then Event.upcoming.created(user)
        when %w(past connected) then Event.past.connected(user)
        when %w(past created) then Event.past.created(user)
        when ['upcoming', nil] then Event.upcoming
        when ['past', nil] then Event.past
        else
          Event.all
        end
      end
  end
end
