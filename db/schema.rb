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

ActiveRecord::Schema.define(version: 20140607171327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address", primary_key: "address", force: true do |t|
    t.decimal "address_type_fk",             precision: 10, scale: 0
    t.decimal "subject_fk",                  precision: 10, scale: 0
    t.decimal "subject_type_fk",             precision: 10, scale: 0
    t.string  "country",         limit: 50
    t.string  "county",          limit: 100
    t.string  "town_village",    limit: 100
    t.string  "street_address",  limit: 100
    t.string  "zipcode",         limit: 50
  end

  add_index "address", ["address"], name: "address_idx1", using: :btree
  add_index "address", ["address_type_fk"], name: "address_idx2", using: :btree
  add_index "address", ["subject_type_fk"], name: "address_idx3", using: :btree

  create_table "address_type", id: false, force: true do |t|
    t.decimal "address_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",    limit: 200
  end

  create_table "atr_type_selection_value", primary_key: "atr_type_selection_value", force: true do |t|
    t.decimal "doc_attribute_type_fk", precision: 10, scale: 0
    t.text    "value_text"
    t.decimal "orderby",               precision: 10, scale: 0
  end

  add_index "atr_type_selection_value", ["atr_type_selection_value"], name: "atr_type_selection_value_idx1", using: :btree
  add_index "atr_type_selection_value", ["doc_attribute_type_fk"], name: "atr_type_selection_value_idx2", using: :btree

  create_table "contact", primary_key: "contact", force: true do |t|
    t.decimal "subject_fk",      precision: 10, scale: 0
    t.decimal "contact_type_fk", precision: 10, scale: 0
    t.text    "value_text"
    t.decimal "orderby",         precision: 10, scale: 0
    t.decimal "subject_type_fk", precision: 10, scale: 0
    t.text    "note"
  end

  add_index "contact", ["contact"], name: "contact_idx1", using: :btree
  add_index "contact", ["contact_type_fk"], name: "contact_idx4", using: :btree
  add_index "contact", ["subject_fk"], name: "contact_idx2", using: :btree
  add_index "contact", ["subject_type_fk"], name: "contact_idx3", using: :btree

  create_table "contact_type", id: false, force: true do |t|
    t.decimal "contact_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",    limit: 200
  end

  create_table "customer", primary_key: "customer", force: true do |t|
    t.decimal "subject_fk",      precision: 10, scale: 0
    t.decimal "subject_type_fk", precision: 10, scale: 0
  end

  add_index "customer", ["customer"], name: "customer_idx1", using: :btree
  add_index "customer", ["subject_fk"], name: "customer_idx2", using: :btree
  add_index "customer", ["subject_type_fk"], name: "customer_idx3", using: :btree

  create_table "data_type", id: false, force: true do |t|
    t.decimal "data_type",             precision: 10, scale: 0, null: false
    t.string  "type_name", limit: 200
  end

  create_table "doc_attribute", primary_key: "doc_attribute", force: true do |t|
    t.decimal "atr_type_selection_value_fk",           precision: 10, scale: 0
    t.decimal "doc_attribute_type_fk",                 precision: 10, scale: 0
    t.decimal "document_fk",                           precision: 10, scale: 0
    t.text    "type_name"
    t.text    "value_text"
    t.decimal "value_number"
    t.date    "value_date"
    t.decimal "data_type",                             precision: 1,  scale: 0
    t.decimal "orderby",                               precision: 10, scale: 0
    t.string  "required",                    limit: 1
  end

  add_index "doc_attribute", ["atr_type_selection_value_fk"], name: "doc_attribute_idx4", using: :btree
  add_index "doc_attribute", ["doc_attribute"], name: "doc_attribute_idx1", using: :btree
  add_index "doc_attribute", ["doc_attribute_type_fk"], name: "doc_attribute_idx3", using: :btree
  add_index "doc_attribute", ["document_fk"], name: "doc_attribute_idx2", using: :btree
  add_index "doc_attribute", ["value_date", "data_type"], name: "doc_attribute_idx8", using: :btree
  add_index "doc_attribute", ["value_number", "data_type"], name: "doc_attribute_idx7", using: :btree

  create_table "doc_attribute_type", primary_key: "doc_attribute_type", force: true do |t|
    t.decimal "default_selection_id_fk",           precision: 10, scale: 0
    t.text    "type_name"
    t.text    "default_value_text"
    t.decimal "data_type_fk",                      precision: 1,  scale: 0
    t.string  "multiple_attributes",     limit: 1
  end

  add_index "doc_attribute_type", ["doc_attribute_type"], name: "doc_attribute_type_idx1", using: :btree

  create_table "doc_catalog", primary_key: "doc_catalog", force: true do |t|
    t.decimal  "catalog_owner_fk",    precision: 10, scale: 0
    t.decimal  "doc_catalog_type_fk", precision: 10, scale: 0
    t.text     "name"
    t.text     "description"
    t.decimal  "level",               precision: 10, scale: 0
    t.datetime "content_updated"
    t.decimal  "content_updated_by",  precision: 10, scale: 0
    t.decimal  "upper_catalog_fk",    precision: 10, scale: 0
    t.text     "folder"
  end

  add_index "doc_catalog", ["catalog_owner_fk"], name: "doc_catalog_idx5", using: :btree
  add_index "doc_catalog", ["content_updated"], name: "doc_catalog_idx6", using: :btree
  add_index "doc_catalog", ["content_updated_by"], name: "doc_catalog_idx7", using: :btree
  add_index "doc_catalog", ["doc_catalog"], name: "doc_catalog_idx1", using: :btree
  add_index "doc_catalog", ["upper_catalog_fk"], name: "doc_catalog_idx4", using: :btree

  create_table "doc_catalog_type", id: false, force: true do |t|
    t.decimal "doc_catalog_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",        limit: 200
  end

  create_table "doc_status", primary_key: "doc_status", force: true do |t|
    t.decimal  "document_fk",        precision: 10, scale: 0
    t.decimal  "doc_status_type_fk", precision: 10, scale: 0
    t.datetime "status_begin"
    t.datetime "status_end"
    t.decimal  "created_by",         precision: 10, scale: 0
  end

  add_index "doc_status", ["created_by"], name: "doc_status_idx4", using: :btree
  add_index "doc_status", ["doc_status"], name: "doc_status_idx1", using: :btree
  add_index "doc_status", ["doc_status_type_fk"], name: "doc_status_idx3", using: :btree
  add_index "doc_status", ["document_fk"], name: "doc_status_idx2", using: :btree
  add_index "doc_status", ["status_begin"], name: "doc_status_idx5", using: :btree
  add_index "doc_status", ["status_end"], name: "doc_status_idx6", using: :btree

  create_table "doc_status_type", primary_key: "doc_status_type", force: true do |t|
    t.string "type_name", limit: 200
  end

  create_table "doc_subject", primary_key: "doc_subject", force: true do |t|
    t.decimal "doc_subject_relation_type_fk", precision: 10, scale: 0
    t.decimal "doc_subject_type_fk",          precision: 10, scale: 0
    t.decimal "document_fk",                  precision: 10, scale: 0
    t.decimal "subject_fk",                   precision: 10, scale: 0
    t.text    "note"
  end

  add_index "doc_subject", ["doc_subject"], name: "doc_subject_idx1", using: :btree
  add_index "doc_subject", ["subject_fk", "doc_subject_type_fk"], name: "doc_subject_idx3", using: :btree
  add_index "doc_subject", ["subject_fk"], name: "doc_subject_idx2", using: :btree

  create_table "doc_subject_relation_type", id: false, force: true do |t|
    t.decimal "doc_subject_relation_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",                 limit: 200
  end

  create_table "doc_subject_type", id: false, force: true do |t|
    t.decimal "doc_subject_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",        limit: 200
  end

  create_table "doc_type", primary_key: "doc_type", force: true do |t|
    t.decimal "super_type_fk",             precision: 10, scale: 0
    t.decimal "level",                     precision: 10, scale: 0
    t.string  "type_name",     limit: 200
  end

  add_index "doc_type", ["doc_type"], name: "doc_type_idx1", using: :btree
  add_index "doc_type", ["super_type_fk"], name: "doc_type_idx3", using: :btree
  add_index "doc_type", ["type_name"], name: "doc_type_idx2", using: :btree

  create_table "doc_type_attribute", primary_key: "doc_type_attribute", force: true do |t|
    t.decimal "doc_attribute_type_fk",           precision: 10, scale: 0
    t.decimal "doc_type_fk",                     precision: 10, scale: 0
    t.decimal "orderby",                         precision: 10, scale: 0
    t.string  "required",              limit: 1
    t.string  "created_by_default",    limit: 1
  end

  add_index "doc_type_attribute", ["doc_attribute_type_fk"], name: "doc_type_attribute_idx2", using: :btree
  add_index "doc_type_attribute", ["doc_type_attribute"], name: "doc_type_attribute_idx1", using: :btree
  add_index "doc_type_attribute", ["doc_type_fk"], name: "doc_type_attribute_idx3", using: :btree

  create_table "document", primary_key: "document", force: true do |t|
    t.text     "doc_nr"
    t.text     "name"
    t.text     "description"
    t.datetime "created"
    t.decimal  "created_by",         precision: 10, scale: 0
    t.datetime "updated"
    t.decimal  "updated_by",         precision: 10, scale: 0
    t.decimal  "doc_status_type_fk", precision: 10, scale: 0
    t.text     "filename"
  end

  add_index "document", ["created"], name: "document_idx6", using: :btree
  add_index "document", ["created_by"], name: "document_idx7", using: :btree
  add_index "document", ["description"], name: "document_idx5", using: :btree
  add_index "document", ["doc_status_type_fk"], name: "document_idx10", using: :btree
  add_index "document", ["document"], name: "document_idx1", using: :btree
  add_index "document", ["updated"], name: "document_idx8", using: :btree
  add_index "document", ["updated_by"], name: "document_idx9", using: :btree

  create_table "document_doc_catalog", primary_key: "document_doc_catalog", force: true do |t|
    t.decimal  "document_fk",    precision: 10, scale: 0
    t.decimal  "doc_catalog_fk", precision: 10, scale: 0
    t.datetime "catalog_time"
  end

  add_index "document_doc_catalog", ["doc_catalog_fk"], name: "document_doc_catalog_idx3", using: :btree
  add_index "document_doc_catalog", ["document_doc_catalog"], name: "document_doc_catalog_idx1", using: :btree
  add_index "document_doc_catalog", ["document_fk"], name: "document_doc_catalog_idx2", using: :btree

  create_table "document_doc_type", primary_key: "document_doc_type", force: true do |t|
    t.decimal "doc_type_fk", precision: 10, scale: 0
    t.decimal "document_fk", precision: 10, scale: 0
  end

  add_index "document_doc_type", ["doc_type_fk"], name: "document_doc_type_idx2", using: :btree
  add_index "document_doc_type", ["document_doc_type"], name: "document_doc_type_idx1", using: :btree
  add_index "document_doc_type", ["document_fk"], name: "document_doc_type_idx3", using: :btree

  create_table "employee", primary_key: "employee", force: true do |t|
    t.decimal "person_fk",                precision: 10, scale: 0
    t.decimal "enterprise_fk",            precision: 10, scale: 0
    t.decimal "struct_unit_fk",           precision: 10, scale: 0
    t.string  "active",         limit: 1
  end

  add_index "employee", ["employee"], name: "employee_idx1", using: :btree
  add_index "employee", ["enterprise_fk"], name: "employee_idx3", using: :btree
  add_index "employee", ["person_fk"], name: "employee_idx2", using: :btree
  add_index "employee", ["struct_unit_fk"], name: "employee_idx4", using: :btree

  create_table "employee_role", primary_key: "employee_role", force: true do |t|
    t.decimal "employee_fk",                     precision: 10, scale: 0
    t.decimal "employee_role_type_fk",           precision: 10, scale: 0
    t.string  "active",                limit: 1
  end

  add_index "employee_role", ["employee_fk"], name: "employee_role_idx2", using: :btree
  add_index "employee_role", ["employee_role"], name: "employee_role_idx1", using: :btree
  add_index "employee_role", ["employee_role_type_fk"], name: "employee_role_idx3", using: :btree

  create_table "employee_role_type", id: false, force: true do |t|
    t.decimal "employee_role_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",          limit: 200
  end

  create_table "ent_per_relation_type", id: false, force: true do |t|
    t.decimal "ent_per_relation_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",             limit: 200
  end

  create_table "enterprise", primary_key: "enterprise", force: true do |t|
    t.text     "name"
    t.text     "full_name"
    t.decimal  "created_by", precision: 10, scale: 0
    t.decimal  "updated_by", precision: 10, scale: 0
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "enterprise", ["enterprise"], name: "enterprise_idx1", using: :btree

  create_table "enterprise_person_relation", primary_key: "enterprise_person_relation", force: true do |t|
    t.decimal "person_fk",                precision: 10, scale: 0
    t.decimal "enterprise_fk",            precision: 10, scale: 0
    t.decimal "ent_per_relation_type_fk", precision: 10, scale: 0
  end

  add_index "enterprise_person_relation", ["ent_per_relation_type_fk"], name: "enterprise_person_relation_idx4", using: :btree
  add_index "enterprise_person_relation", ["enterprise_fk"], name: "enterprise_person_relation_idx3", using: :btree
  add_index "enterprise_person_relation", ["enterprise_person_relation"], name: "enterprise_person_relation_idx1", using: :btree
  add_index "enterprise_person_relation", ["person_fk"], name: "enterprise_person_relation_idx2", using: :btree

  create_table "person", primary_key: "person", force: true do |t|
    t.string   "first_name",    limit: 100
    t.string   "last_name",     limit: 100
    t.string   "identity_code", limit: 20
    t.date     "birth_date"
    t.decimal  "created_by",                precision: 10, scale: 0
    t.decimal  "updated_by",                precision: 10, scale: 0
    t.datetime "created"
    t.datetime "updated"
  end

  add_index "person", ["birth_date"], name: "person_idx5", using: :btree
  add_index "person", ["created"], name: "person_idx6", using: :btree
  add_index "person", ["created_by"], name: "person_idx7", using: :btree
  add_index "person", ["identity_code"], name: "person_idx4", using: :btree
  add_index "person", ["person"], name: "person_idx1", using: :btree

  create_table "struct_unit", primary_key: "struct_unit", force: true do |t|
    t.decimal "enterprise_fk",             precision: 10, scale: 0
    t.decimal "upper_unit_fk",             precision: 10, scale: 0
    t.decimal "level",                     precision: 10, scale: 0
    t.string  "name",          limit: 200
  end

  add_index "struct_unit", ["enterprise_fk"], name: "struct_unit_idx2", using: :btree
  add_index "struct_unit", ["struct_unit"], name: "struct_unit_idx1", using: :btree
  add_index "struct_unit", ["upper_unit_fk"], name: "struct_unit_idx3", using: :btree

  create_table "subject_attribute", primary_key: "subject_attribute", force: true do |t|
    t.decimal "subject_fk",                precision: 10, scale: 0
    t.decimal "subject_attribute_type_fk", precision: 10, scale: 0
    t.decimal "subject_type_fk",           precision: 10, scale: 0
    t.decimal "orderby",                   precision: 10, scale: 0
    t.text    "value_text"
    t.decimal "value_number"
    t.date    "value_date"
    t.decimal "data_type",                 precision: 1,  scale: 0
  end

  add_index "subject_attribute", ["subject_attribute"], name: "subject_attribute_idx1", using: :btree
  add_index "subject_attribute", ["subject_attribute_type_fk"], name: "subject_attribute_idx5", using: :btree
  add_index "subject_attribute", ["subject_fk"], name: "subject_attribute_idx2", using: :btree
  add_index "subject_attribute", ["subject_type_fk"], name: "subject_attribute_idx6", using: :btree
  add_index "subject_attribute", ["value_date"], name: "subject_attribute_idx9", using: :btree
  add_index "subject_attribute", ["value_number"], name: "subject_attribute_idx8", using: :btree

  create_table "subject_attribute_type", primary_key: "subject_attribute_type", force: true do |t|
    t.decimal "subject_type_fk",                 precision: 10, scale: 0
    t.string  "type_name",           limit: 200
    t.decimal "data_type",                       precision: 1,  scale: 0
    t.decimal "orderby",                         precision: 10, scale: 0
    t.string  "required",            limit: 1
    t.string  "multiple_attributes", limit: 1
    t.string  "created_by_default",  limit: 1
  end

  add_index "subject_attribute_type", ["subject_attribute_type"], name: "subject_attribute_type_idx1", using: :btree
  add_index "subject_attribute_type", ["subject_type_fk"], name: "subject_attribute_type_idx2", using: :btree

  create_table "subject_type", id: false, force: true do |t|
    t.decimal "subject_type",             precision: 10, scale: 0, null: false
    t.string  "type_name",    limit: 200
  end

  create_table "user_account", primary_key: "user_account", force: true do |t|
    t.decimal  "subject_type_fk",                    precision: 10, scale: 0
    t.decimal  "subject_fk",                         precision: 10, scale: 0
    t.string   "username",               limit: 50
    t.string   "passw",                  limit: 300
    t.decimal  "status",                             precision: 10, scale: 0
    t.date     "valid_from"
    t.date     "valid_to"
    t.decimal  "created_by",                         precision: 10, scale: 0
    t.datetime "created"
    t.string   "password_never_expires", limit: 1
  end

  add_index "user_account", ["subject_fk"], name: "user_account_idx4", using: :btree
  add_index "user_account", ["subject_type_fk"], name: "user_account_idx3", using: :btree
  add_index "user_account", ["user_account"], name: "user_account_idx1", using: :btree
  add_index "user_account", ["username", "passw", "status"], name: "user_account_idx2", using: :btree

end
