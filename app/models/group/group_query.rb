class Group
  class GroupQuery
    attr_reader :search_query, :teacher_id
    def initialize(search_query: '', teacher_id: nil)
      @search_query = search_query
      @teacher_id = teacher_id
    end

    def result_query
      filtered
    end

    def count
      filtered.count
    end

    private

      def filtered
        if(teacher_id.present?)
          User.find(teacher_id).groups_teacher.uniq
        elsif(search_query.present?)
          Group.with_lessons.search_by_name(search_query)
        else
          Group.with_lessons
        end
      end
  end
end