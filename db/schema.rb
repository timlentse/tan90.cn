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

ActiveRecord::Schema.define(version: 20170812091555) do

  create_table "booking_airports", force: :cascade do |t|
    t.string   "name",             limit: 255,  default: "",   null: false
    t.string   "name_cn",          limit: 255,  default: "",   null: false
    t.string   "city",             limit: 256,  default: "",   null: false
    t.string   "city_cn",          limit: 256,  default: "",   null: false
    t.string   "iata",             limit: 3,    default: "",   null: false
    t.integer  "number_of_hotels", limit: 4,    default: 0,    null: false
    t.string   "country_code",     limit: 255,  default: "",   null: false
    t.string   "deeplink",         limit: 255,  default: "",   null: false
    t.string   "hotels",           limit: 6000, default: "[]", null: false
    t.datetime "updated_at",                                   null: false
    t.datetime "created_at",                                   null: false
  end

  add_index "booking_airports", ["iata"], name: "iata", unique: true, using: :btree

  create_table "booking_cities", force: :cascade do |t|
    t.string  "name",             limit: 128, default: "", null: false
    t.string  "full_name",        limit: 128, default: "", null: false
    t.string  "name_cn",          limit: 50,  default: "", null: false
    t.integer "number_of_hotels", limit: 4,                null: false
    t.string  "country_code",     limit: 2,   default: "", null: false
    t.string  "country_name",     limit: 50,  default: "", null: false
    t.string  "ufi",              limit: 11,  default: "", null: false
    t.integer "city_ranking",     limit: 1,                null: false
    t.string  "city_img",         limit: 255, default: "", null: false
    t.string  "deeplink",         limit: 255, default: "", null: false
  end

  add_index "booking_cities", ["country_code"], name: "ix_co_code", using: :btree
  add_index "booking_cities", ["deeplink"], name: "ix_depthlink", using: :btree

  create_table "booking_hot_destinations", force: :cascade do |t|
    t.string   "name_cn",         limit: 50,  default: "",   null: false
    t.string   "name_en",         limit: 128, default: "",   null: false
    t.string   "number_of_hotel", limit: 64,  default: "",   null: false
    t.string   "cc",              limit: 2,   default: "",   null: false
    t.integer  "cate",            limit: 1,                  null: false
    t.boolean  "is_show",                     default: true, null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "created_at",                                 null: false
  end

  add_index "booking_hot_destinations", ["name_cn"], name: "ix_name_en", using: :btree

  create_table "booking_hotels", force: :cascade do |t|
    t.string   "name",          limit: 128,                            default: "",   null: false
    t.string   "name_cn",       limit: 128,                            default: "",   null: false
    t.string   "address",       limit: 256,                            default: "",   null: false
    t.string   "address_cn",    limit: 256,                            default: "",   null: false
    t.string   "city_hotel",    limit: 50,                             default: "",   null: false
    t.string   "cc1",           limit: 2,                              default: "",   null: false
    t.integer  "star",          limit: 1,                                             null: false
    t.string   "currencycode",  limit: 20,                             default: "",   null: false
    t.integer  "minrate",       limit: 4,                                             null: false
    t.integer  "maxrate",       limit: 4,                                             null: false
    t.integer  "nr_rooms",      limit: 4,                                             null: false
    t.string   "nearby_hotels", limit: 500,                            default: "[]", null: false
    t.decimal  "longitude",                  precision: 17, scale: 14,                null: false
    t.decimal  "latitude",                   precision: 17, scale: 14,                null: false
    t.string   "hotel_url",     limit: 255,                            default: "",   null: false
    t.string   "photo_url",     limit: 255,                            default: "",   null: false
    t.string   "desc_en",       limit: 255,                            default: "",   null: false
    t.string   "desc_zh",       limit: 255,                            default: "",   null: false
    t.string   "desc_cn",       limit: 6000,                           default: "",   null: false
    t.string   "city_unique",   limit: 50,                             default: "",   null: false
    t.integer  "district",      limit: 4,                              default: 0,    null: false
    t.integer  "continent_id",  limit: 1,                              default: 8,    null: false
    t.decimal  "review_score",               precision: 3,  scale: 1,  default: 0.0,  null: false
    t.datetime "updated_at",                                                          null: false
  end

  add_index "booking_hotels", ["cc1"], name: "ix_cc", using: :btree
  add_index "booking_hotels", ["city_unique"], name: "ix_city", using: :btree

  create_table "booking_landmarks", force: :cascade do |t|
    t.string   "name_cn",          limit: 128,  default: "",   null: false
    t.string   "name",             limit: 128,  default: "",   null: false
    t.string   "city",             limit: 128,  default: "",   null: false
    t.string   "country_code",     limit: 2,    default: "",   null: false
    t.string   "hotels",           limit: 6000, default: "[]", null: false
    t.integer  "number_of_hotels", limit: 4,                   null: false
    t.string   "deeplink",         limit: 255,  default: "",   null: false
    t.string   "content",          limit: 6000, default: "",   null: false
    t.datetime "updated_at",                                   null: false
    t.datetime "created_at",                                   null: false
  end

  add_index "booking_landmarks", ["city"], name: "ix_city", using: :btree
  add_index "booking_landmarks", ["country_code"], name: "ix_cc", using: :btree

  create_table "booking_regions", force: :cascade do |t|
    t.string  "region_name",      limit: 50,  default: "", null: false
    t.string  "region_type",      limit: 10,  default: "", null: false
    t.integer "number_of_hotels", limit: 4,                null: false
    t.string  "country_code",     limit: 2,   default: "", null: false
    t.string  "deeplink",         limit: 255, default: "", null: false
  end

  add_index "booking_regions", ["country_code"], name: "ix_cc", using: :btree

  create_table "booking_reviews", force: :cascade do |t|
    t.integer  "hotel_id",     limit: 4,                                            null: false
    t.string   "good",         limit: 1000,                         default: "",    null: false
    t.string   "bad",          limit: 1000,                         default: "",    null: false
    t.string   "author",       limit: 50,                           default: "",    null: false
    t.string   "comment_time", limit: 20,                           default: "",    null: false
    t.decimal  "score",                     precision: 3, scale: 1,                 null: false
    t.string   "location",     limit: 50,                           default: "",    null: false
    t.string   "tags",         limit: 1000,                         default: "",    null: false
    t.boolean  "lang",                                              default: false, null: false
    t.datetime "updated_at",                                                        null: false
    t.datetime "created_at",                                                        null: false
  end

  add_index "booking_reviews", ["hotel_id"], name: "ix_hotel_id", using: :btree

  create_table "clock_hotel_details", force: :cascade do |t|
    t.integer  "hotel_id",     limit: 4,     null: false
    t.text     "room_json",    limit: 65535, null: false
    t.text     "desc_json",    limit: 65535, null: false
    t.text     "comment_json", limit: 65535, null: false
    t.text     "links_json",   limit: 65535, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "clock_hotel_details", ["hotel_id"], name: "ux_hotel_id", unique: true, using: :btree

  create_table "clock_hotels", force: :cascade do |t|
    t.string   "name",         limit: 100, default: "", null: false
    t.string   "elong_id",     limit: 8,   default: "", null: false
    t.string   "city_name",    limit: 50,  default: "", null: false
    t.string   "city_name_en", limit: 100, default: "", null: false
    t.string   "chain_name",   limit: 50,  default: "", null: false
    t.string   "chain_id",     limit: 10,  default: "", null: false
    t.string   "title",        limit: 100, default: "", null: false
    t.string   "img_url",      limit: 500, default: "", null: false
    t.integer  "price",        limit: 4,                null: false
    t.string   "shop_time",    limit: 50,               null: false
    t.integer  "room_hour",    limit: 4,                null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "clock_hotels", ["elong_id"], name: "ux_elong_id", unique: true, using: :btree

  create_table "countries", force: :cascade do |t|
    t.string "cc",                limit: 2,   default: "", null: false
    t.string "name_cn",           limit: 128, default: "", null: false
    t.string "country_or_region", limit: 128, default: "", null: false
  end

  add_index "countries", ["cc"], name: "ux_cc", using: :btree

  create_table "fishtrip_articles", force: :cascade do |t|
    t.string "article_id", limit: 4,   default: "", null: false
    t.string "title",      limit: 100, default: "", null: false
    t.string "link",       limit: 256, default: "", null: false
    t.string "type_name",  limit: 20,  default: "", null: false
    t.string "country",    limit: 10,  default: "", null: false
    t.string "city_en",    limit: 20,  default: "", null: false
    t.string "city",       limit: 20,  default: "", null: false
    t.string "time",       limit: 30,  default: "", null: false
  end

  add_index "fishtrip_articles", ["article_id"], name: "ux_article_id", unique: true, using: :btree

  create_table "fishtrip_cities", force: :cascade do |t|
    t.string  "name_en",          limit: 50,  default: "", null: false
    t.string  "name",             limit: 10,  default: "", null: false
    t.string  "country",          limit: 10,  default: "", null: false
    t.integer "number_of_hotels", limit: 4,   default: 0,  null: false
    t.string  "img",              limit: 255, default: "", null: false
  end

  add_index "fishtrip_cities", ["name_en"], name: "ix_country", using: :btree
  add_index "fishtrip_cities", ["name_en"], name: "ux_name_en", unique: true, using: :btree

  create_table "fishtrip_comments", force: :cascade do |t|
    t.string   "fishtrip_hotel_id", limit: 11,                          default: "", null: false
    t.string   "content",           limit: 512,                         default: "", null: false
    t.string   "comment_time",      limit: 20,                          default: "", null: false
    t.string   "author",            limit: 50,                          default: "", null: false
    t.decimal  "score",                         precision: 2, scale: 1,              null: false
    t.datetime "updated_at",                                                         null: false
    t.datetime "created_at",                                                         null: false
  end

  add_index "fishtrip_comments", ["fishtrip_hotel_id"], name: "ix_hotel_id", using: :btree

  create_table "fishtrip_hotels", force: :cascade do |t|
    t.string   "uri",               limit: 128,                          default: "",   null: false
    t.string   "name",              limit: 256,                          default: "",   null: false
    t.string   "address",           limit: 256,                          default: "",   null: false
    t.integer  "price",             limit: 4,                                           null: false
    t.string   "comment",           limit: 128,                          default: "",   null: false
    t.string   "city",              limit: 50,                           default: "",   null: false
    t.string   "shared_uri",        limit: 128,                          default: "",   null: false
    t.string   "image_uri",         limit: 128,                          default: "",   null: false
    t.string   "fishtrip_hotel_id", limit: 11,                           default: "",   null: false
    t.string   "city_en",           limit: 50,                           default: "",   null: false
    t.string   "country",           limit: 50,                           default: "",   null: false
    t.integer  "city_id",           limit: 4,                                           null: false
    t.string   "desc",              limit: 5000,                         default: "",   null: false
    t.string   "tuijian",           limit: 5000,                         default: "",   null: false
    t.string   "traffic",           limit: 5000,                         default: "",   null: false
    t.decimal  "score",                          precision: 2, scale: 1, default: 0.0,  null: false
    t.integer  "page_id",           limit: 4,                                           null: false
    t.string   "rooms",             limit: 3000,                         default: "[]", null: false
    t.datetime "updated_at",                                                            null: false
    t.datetime "created_at",                                                            null: false
  end

  add_index "fishtrip_hotels", ["city_id"], name: "ix_city_id", using: :btree
  add_index "fishtrip_hotels", ["name"], name: "ix_country", length: {"name"=>255}, using: :btree
  add_index "fishtrip_hotels", ["page_id"], name: "ix_page_id", using: :btree
  add_index "fishtrip_hotels", ["uri"], name: "ix_fish_id", using: :btree

  create_table "fishtrip_rooms", force: :cascade do |t|
    t.string   "info",       limit: 255
    t.integer  "price",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "hotel_id",   limit: 4
  end

  create_table "http_proxies", force: :cascade do |t|
    t.string   "ip",            limit: 15,  default: "",     null: false
    t.integer  "port",          limit: 4,                    null: false
    t.string   "http_type",     limit: 10,  default: "HTTP", null: false
    t.string   "modified_time", limit: 10,  default: "",     null: false
    t.string   "response_time", limit: 128,                  null: false
    t.boolean  "is_effect",                 default: true,   null: false
    t.string   "location",      limit: 100, default: "",     null: false
    t.string   "safety",        limit: 50,  default: "高匿名",  null: false
    t.integer  "is_outer",      limit: 1,   default: 0,      null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "created_at",                                 null: false
  end

  add_index "http_proxies", ["ip", "port"], name: "ux_ip_addr", unique: true, using: :btree

  create_table "mafengwo_hot_destinations", force: :cascade do |t|
    t.integer "city_id", limit: 4,   default: 0,     null: false
    t.string  "name",    limit: 255, default: "",    null: false
    t.boolean "done",                default: false, null: false
  end

  create_table "mafengwo_mdds", force: :cascade do |t|
    t.string   "name",       limit: 50,    default: "",    null: false
    t.string   "name_en",    limit: 128
    t.string   "mdd_id",     limit: 20,    default: "",    null: false
    t.boolean  "done",                     default: false, null: false
    t.text     "desc",       limit: 65535
    t.datetime "updated_at",                               null: false
    t.datetime "created_at",                               null: false
  end

  create_table "mafengwo_questions", force: :cascade do |t|
    t.integer  "q_id",           limit: 4,                    null: false
    t.string   "city_id",        limit: 10,   default: "",    null: false
    t.string   "city_name",      limit: 50,   default: "",    null: false
    t.string   "city_en",        limit: 50,   default: "",    null: false
    t.string   "title",          limit: 1000, default: "",    null: false
    t.string   "ask_user_id",    limit: 15,   default: ""
    t.string   "ask_user_name",  limit: 128
    t.string   "answer_user_id", limit: 15,   default: ""
    t.string   "ask_time",       limit: 20
    t.string   "tags",           limit: 256,  default: "[]",  null: false
    t.boolean  "is_send",                     default: false, null: false
    t.boolean  "is_left",                     default: false, null: false
    t.datetime "updated_at",                                  null: false
    t.datetime "created_at",                                  null: false
  end

  add_index "mafengwo_questions", ["city_id"], name: "ix_city_id", using: :btree
  add_index "mafengwo_questions", ["q_id"], name: "ux_qid", unique: true, using: :btree

  create_table "mafengwo_scenics", force: :cascade do |t|
    t.string   "name",       limit: 256, default: "",    null: false
    t.string   "name_en",    limit: 128
    t.boolean  "done",                   default: false, null: false
    t.string   "city",       limit: 128, default: "",    null: false
    t.string   "city_en",    limit: 128
    t.string   "tags",       limit: 128
    t.string   "poi_id",     limit: 20,  default: "",    null: false
    t.datetime "updated_at",                             null: false
    t.datetime "created_at",                             null: false
  end

  add_index "mafengwo_scenics", ["poi_id"], name: "ux_poi_id", unique: true, using: :btree

  create_table "mafengwo_tags", force: :cascade do |t|
    t.string "name",   limit: 64, default: "", null: false
    t.string "tag_id", limit: 10, default: "", null: false
  end

  create_table "mafengwo_users", force: :cascade do |t|
    t.string   "user_id",      limit: 20,  default: "",    null: false
    t.string   "name",         limit: 128
    t.boolean  "gender",                   default: false, null: false
    t.integer  "level",        limit: 4,   default: 1,     null: false
    t.string   "place",        limit: 128
    t.integer  "fans",         limit: 4,   default: 0,     null: false
    t.integer  "following",    limit: 4,   default: 0,     null: false
    t.integer  "honey",        limit: 4,   default: 0,     null: false
    t.boolean  "is_following",             default: false, null: false
    t.datetime "updated_at",                               null: false
    t.datetime "created_at",                               null: false
  end

  add_index "mafengwo_users", ["user_id"], name: "ux_user_id", unique: true, using: :btree

  create_table "minisite_hot_pois", force: :cascade do |t|
    t.string   "name",              limit: 255,  default: "", null: false
    t.string   "city_id",           limit: 4,    default: "", null: false
    t.string   "city_name",         limit: 30,   default: "", null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "suggest_direction", limit: 1000, default: "", null: false
    t.integer  "status",            limit: 1,    default: 0,  null: false
    t.integer  "display_weight",    limit: 2,    default: 0,  null: false
  end

  add_index "minisite_hot_pois", ["city_id"], name: "ix_hot_poi_cityid", using: :btree

end
