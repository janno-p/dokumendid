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

ActiveRecord::Schema.define(version: 20140408145934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atr_type_selection_value", primary_key: "atr_type_selection_value", force: true do |t|
    t.integer "doc_attribute_type_fk"
    t.string  "value_text"
    t.integer "orderby"
  end

  create_table "data_type", primary_key: "data_type", force: true do |t|
    t.string "type_name", limit: 200
  end

  create_table "doc_attribute", primary_key: "doc_attribute", force: true do |t|
    t.integer "atr_type_selection_value_fk"
    t.integer "doc_attribute_type_fk"
    t.integer "document_fk"
    t.string  "type_name"
    t.string  "value_text"
    t.decimal "value_number"
    t.date    "value_date"
    t.integer "data_type"
    t.integer "orderby"
    t.string  "required",                    limit: 1
  end

end
