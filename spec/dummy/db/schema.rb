ActiveRecord::Schema.define version: 0 do
  create_table "self_updated_at_test_models", force: true do |t|
    t.string "title"
    t.text "body"
    t.datetime "service_updated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
