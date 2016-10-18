class User
  class UserQuery
    attr_reader :search_query, :account_type
    def initialize(search_query: '', account_type: 'student')
      @search_query = search_query
      account_type == 'student' ? @account_type = 'student' : @account_type = 'teacher'
    end

    def result_query
      filtered
    end

    def count
      filtered.count
    end

    private
      def filtered
        if(search_query.present? && account_type == 'student')
          User.students_with_groups.search_by_full_name(search_query)
        elsif(search_query.present? && account_type == 'teacher')
          User.teachers_with_lessons.search_by_full_name(search_query)
        elsif(account_type == 'teacher')
          User.teachers_with_lessons
        else
          User.students_with_groups
        end
      end
  end
end