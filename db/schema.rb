# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_03_171014) do

  create_table "courses", force: :cascade do |t|
    t.string "department_name"
    t.string "course_number"
    t.string "course_name"
    t.string "semester"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_name", "course_number", "semester"], name: "course_index", unique: true
  end

  create_table "enrollments", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "message_text"
    t.datetime "time"
    t.integer "user_id"
    t.integer "office_hours_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_hours_session_id"], name: "index_messages_on_office_hours_session_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "office_hours_sessions", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["course_id"], name: "index_office_hours_sessions_on_course_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_text"
    t.datetime "time_added"
    t.datetime "time_started"
    t.datetime "time_completed"
    t.integer "student_id"
    t.integer "instructor_id"
    t.integer "course_id"
    t.integer "office_hours_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_questions_on_course_id"
    t.index ["instructor_id"], name: "index_questions_on_instructor_id"
    t.index ["office_hours_session_id"], name: "index_questions_on_office_hours_session_id"
    t.index ["student_id"], name: "index_questions_on_student_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "picture"
    t.string "session_token"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
