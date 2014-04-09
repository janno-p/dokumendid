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

ActiveRecord::Schema.define(version: 20140409143042) do

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

  create_table "doc_attribute_type", primary_key: "doc_attribute_type", force: true do |t|
    t.integer  "default_selection_id_fk"
    t.string   "type_name"
    t.string   "default_value_text"
    t.integer  "data_type_fk"
    t.string   "multiple_attributes",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_catalog", primary_key: "doc_catalog", force: true do |t|
    t.integer  "catalog_owner_fk"
    t.integer  "doc_catalog_type_fk"
    t.string   "name"
    t.string   "description"
    t.integer  "level"
    t.datetime "content_updated"
    t.integer  "content_updated_by"
    t.integer  "upper_catalog_fk"
    t.string   "folder"
  end

  create_table "doc_status_type", primary_key: "doc_status_type", force: true do |t|
    t.string "type_name", limit: 200
  end

  create_table "doc_statuse", primary_key: "doc_status", force: true do |t|
    t.integer  "document_fk"
    t.integer  "doc_status_type_fk"
    t.datetime "status_begin"
    t.datetime "status_end"
    t.integer  "created_by"
  end

  create_table "doc_subject", primary_key: "doc_subject", force: true do |t|
    t.integer "doc_subject_relation_type_fk"
    t.integer "doc_subject_type_fk"
    t.integer "document_fk"
    t.integer "subject_fk"
    t.string  "note"
  end

  create_table "doc_subject_relation_type", primary_key: "doc_subject_relation_type", force: true do |t|
    t.string "type_name", limit: 200
  end

  create_table "doc_subject_type", primary_key: "doc_subject_type", force: true do |t|
    t.string "type_name", limit: 200
  end

  create_table "doc_type", primary_key: "doc_type", force: true do |t|
    t.integer "super_type_fk"
    t.integer "level"
    t.string  "type_name",     limit: 200
  end

end
