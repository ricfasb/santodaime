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

ActiveRecord::Schema.define(version: 20190728113614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "zip_code"
    t.string   "street"
    t.string   "number"
    t.string   "complement"
    t.string   "reference"
    t.string   "neighbourhood"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.integer  "city_id"
    t.integer  "state_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree
    t.index ["addressable_type"], name: "index_addresses_on_addressable_type", using: :btree
    t.index ["city_id"], name: "index_addresses_on_city_id", using: :btree
    t.index ["state_id"], name: "index_addresses_on_state_id", using: :btree
  end

  create_table "cashes", force: :cascade do |t|
    t.string   "type"
    t.string   "person"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "insert_tuition"
    t.integer  "tuition_id"
    t.index ["tuition_id"], name: "index_categories_on_tuition_id", using: :btree
  end

  create_table "checkins", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_checkins_on_company_id", using: :btree
    t.index ["person_id"], name: "index_checkins_on_person_id", using: :btree
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "telephone"
    t.integer  "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_companies_on_address_id", using: :btree
  end

  create_table "deficiency_people", force: :cascade do |t|
    t.string   "chronic_disease"
    t.string   "controlled_medication"
    t.integer  "deficiencable_id"
    t.string   "deficiencable_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["deficiencable_id"], name: "index_deficiency_people_on_deficiencable_id", using: :btree
    t.index ["deficiencable_type"], name: "index_deficiency_people_on_deficiencable_type", using: :btree
  end

  create_table "degree_educations", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "driver_licenses", force: :cascade do |t|
    t.string   "number_cnh"
    t.string   "category_cnh"
    t.date     "date_issue"
    t.date     "expering_date"
    t.integer  "licensable_id"
    t.string   "licensable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["licensable_id"], name: "index_driver_licenses_on_licensable_id", using: :btree
    t.index ["licensable_type"], name: "index_driver_licenses_on_licensable_type", using: :btree
  end

  create_table "emails", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "person_id"
    t.integer  "category_id"
    t.string   "title"
    t.string   "subject"
    t.string   "message"
    t.string   "email_type"
    t.datetime "schedule"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_emails_on_category_id", using: :btree
    t.index ["company_id"], name: "index_emails_on_company_id", using: :btree
    t.index ["person_id"], name: "index_emails_on_person_id", using: :btree
  end

  create_table "invoice_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "invoice_type_id"
    t.string   "description"
    t.date     "due_date"
    t.float    "amount"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "pay_day"
    t.float    "discount"
    t.string   "amount_paied"
    t.index ["invoice_type_id"], name: "index_invoices_on_invoice_type_id", using: :btree
    t.index ["person_id"], name: "index_invoices_on_person_id", using: :btree
  end

  create_table "marital_states", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "occupations", force: :cascade do |t|
    t.string   "description"
    t.string   "experience_time"
    t.integer  "address_id"
    t.integer  "occupatiable_id"
    t.string   "occupatiable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["address_id"], name: "index_occupations_on_address_id", using: :btree
    t.index ["occupatiable_id"], name: "index_occupations_on_occupatiable_id", using: :btree
    t.index ["occupatiable_type"], name: "index_occupations_on_occupatiable_type", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "invoice_id"
    t.datetime "pay_day"
    t.float    "pay_amount"
    t.float    "discount"
    t.string   "obs_discount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree
    t.index ["person_id"], name: "index_payments_on_person_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.date     "date_born"
    t.date     "date_enroll"
    t.float    "height"
    t.string   "rg"
    t.string   "cpf",                       limit: 11
    t.string   "telephone_residence",       limit: 11
    t.string   "smartphone_number",         limit: 11
    t.string   "telephone_message",         limit: 11
    t.string   "message_person"
    t.string   "facebook"
    t.string   "father_name"
    t.string   "mother_name"
    t.integer  "category_id"
    t.integer  "address_id"
    t.integer  "driver_license_id"
    t.integer  "occupation_id"
    t.integer  "deficiency_person_id"
    t.integer  "marital_state_id"
    t.integer  "degree_education_id"
    t.string   "wifes_name"
    t.integer  "among_sun"
    t.string   "course"
    t.string   "motive"
    t.string   "complementary_information"
    t.string   "fingerprint"
    t.integer  "on_line"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.binary   "photo_file"
    t.index ["address_id"], name: "index_people_on_address_id", using: :btree
    t.index ["category_id"], name: "index_people_on_category_id", using: :btree
    t.index ["cpf"], name: "index_people_on_cpf", using: :btree
    t.index ["deficiency_person_id"], name: "index_people_on_deficiency_person_id", using: :btree
    t.index ["degree_education_id"], name: "index_people_on_degree_education_id", using: :btree
    t.index ["driver_license_id"], name: "index_people_on_driver_license_id", using: :btree
    t.index ["marital_state_id"], name: "index_people_on_marital_state_id", using: :btree
    t.index ["occupation_id"], name: "index_people_on_occupation_id", using: :btree
  end

  create_table "periodicities", force: :cascade do |t|
    t.string   "description"
    t.string   "days"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer "person_id"
    t.string  "style"
    t.binary  "file_contents"
  end

  create_table "states", force: :cascade do |t|
    t.string   "uf"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tuition_people", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "tuition_id"
    t.datetime "due_date"
    t.datetime "pay_day"
    t.string   "status_payment", limit: 50
    t.float    "discount"
    t.string   "amount_paied"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["person_id"], name: "index_tuition_people_on_person_id", using: :btree
    t.index ["tuition_id"], name: "index_tuition_people_on_tuition_id", using: :btree
  end

  create_table "tuitions", force: :cascade do |t|
    t.string   "description"
    t.integer  "day"
    t.float    "amount"
    t.boolean  "send_email"
    t.integer  "day_email"
    t.integer  "email_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["email_id"], name: "index_tuitions_on_email_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "states"
  add_foreign_key "categories", "tuitions"
  add_foreign_key "checkins", "companies"
  add_foreign_key "checkins", "people"
  add_foreign_key "cities", "states"
  add_foreign_key "companies", "addresses"
  add_foreign_key "emails", "categories"
  add_foreign_key "emails", "companies"
  add_foreign_key "emails", "people"
  add_foreign_key "invoices", "invoice_types"
  add_foreign_key "invoices", "people"
  add_foreign_key "occupations", "addresses"
  add_foreign_key "payments", "invoices"
  add_foreign_key "payments", "people"
  add_foreign_key "people", "addresses"
  add_foreign_key "people", "categories"
  add_foreign_key "people", "deficiency_people"
  add_foreign_key "people", "degree_educations"
  add_foreign_key "people", "driver_licenses"
  add_foreign_key "people", "marital_states"
  add_foreign_key "people", "occupations"
  add_foreign_key "tuition_people", "people"
  add_foreign_key "tuition_people", "tuitions"
  add_foreign_key "tuitions", "emails"
end
