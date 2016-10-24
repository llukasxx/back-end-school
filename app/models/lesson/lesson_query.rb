class Lesson
  class LessonQuery
    attr_reader :search_query, :student_id
    def initialize(search_query: '', student_id: nil)
      @search_query = search_query
      @student_id = student_id
    end

    def result_query
      filtered
    end

    def count
      filtered.count
    end

    private

      def filtered
        if(student_id.present?)
          student = User.find(student_id)
          student.student_lessons.includes(:lesson_dates, :students, :teachers)
        elsif(search_query.present?)
          Lesson.with_groups.search_by_name(search_query)
        else
          Lesson.with_groups.all
        end
      end
  end
end