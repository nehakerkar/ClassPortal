# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160217221054) do

  create_table "course_instructors", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.datetime "startdate"
    t.datetime "enddate"
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "course_instructors", ["course_id"], name: "index_course_instructors_on_course_id", using: :btree
  add_index "course_instructors", ["user_id"], name: "index_course_instructors_on_user_id", using: :btree

  create_table "course_students", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.integer  "course_instructor_id", limit: 4
    t.string   "grades",               limit: 255
    t.string   "status",               limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "course_students", ["course_instructor_id"], name: "index_course_students_on_course_instructor_id", using: :btree
  add_index "course_students", ["user_id", "course_instructor_id"], name: "index_course_students_on_user_id_and_course_instructor_id", unique: true, using: :btree
  add_index "course_students", ["user_id"], name: "index_course_students_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "coursenumber", limit: 255
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "materials", force: :cascade do |t|
    t.integer  "course_instructor_id", limit: 4
    t.text     "material",             limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "materials", ["course_instructor_id"], name: "index_materials_on_course_instructor_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "name",            limit: 255
    t.string   "type",            limit: 255
    t.boolean  "deleteable"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "course_instructors", "courses"
  add_foreign_key "course_instructors", "users"
  add_foreign_key "course_students", "course_instructors"
  add_foreign_key "course_students", "users"
  add_foreign_key "materials", "course_instructors"
end
