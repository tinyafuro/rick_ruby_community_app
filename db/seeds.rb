# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)


#その他アカウントを99個作成
99.times do |n|
  #ユーザー名も日本語化
  Faker::Config.locale = 'ja'
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
end

#最初の6アカウントへ50個分のCommunityを追加
users = User.order(:created_at).take(6)
50.times do
  Faker::Config.locale = 'ja'
  community_title = Faker::University.name
  community_body = Faker::Address.state
  users.each { |user| user.community.create!(title: community_title, body: community_body) }
end
