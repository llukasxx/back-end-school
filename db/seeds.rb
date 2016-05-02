require 'ffaker'
# Admin account
User.create(first_name: "Adam", last_name: "Nowak", 
            email: "admin@example.com", password: "password", 
            password_confirmation: "password", account_type: "admin")
# Teacher account
User.create(first_name: "Jan", last_name: "Kowalski", 
            email: "teacher@example.com", password: "password", 
            password_confirmation: "password", account_type: "teacher")
#Student account
User.create(first_name: "Janusz", last_name: "Galla", 
            email: "student@example.com", password: "password", 
            password_confirmation: "password", account_type: "student")


## Bunch of students
30.times do
  User.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name,
              email: FFaker::Internet.email, password: "password", password_confirmation: "password",
              account_type: "student")
end

## Bunch of teachers
5.times do
  User.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name,
              email: FFaker::Internet.email, password: "password", password_confirmation: "password",
              account_type: "teacher")
end

## Some groups
5.times do |i|
  Group.create(name: "1k11#{i}")
end

## Some lessons
10.times do |i|
  Lesson.create(name: "Lesson #{i}")
end

## Some messages
u = User.second
u.send_message(User.third, "Hello, this is just a test message", "Testing")
users = User.where(account_type: "student")
## Message to students from teacher
u.send_message(users, "I just wanna say hello :)", "Announcement")

## Associations

## Teacher-Lesson, each teacher with one lesson.
teachers = User.where(account_type: "teacher")
teachers.each do |t|
  TeacherLesson.create(teacher_id: t.id, lesson_id: rand(1..10))
end
## Group-lesson, each lesson at least one group.
10.times do |i|
  GroupLesson.create(lesson_id: i, group_id: rand(1..5))
end
## Student-group, each student one group.
students = User.where(account_type: "student")
students.each do |s|
  GroupStudent.create(student_id: s.id, group_id: rand(1..5))
end