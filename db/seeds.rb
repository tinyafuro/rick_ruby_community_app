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
  community_tag = Faker::App.name
  users.each { |user| user.community.create!(title: community_title, body: community_body, tag: community_tag) }
end


# UserとCommunityのリレーションシップ
users = User.all
communities = Community.all

user1  = users.first
user2  = users.second
community1 = communities.first
community2 = communities.second

users1 = users[1..20]
users2 = users[10..15]
communities1 = communities[3..50]
communities2 = communities[10..40]

# ID1のユーザーがID3〜50のコミュニティをフォローする
communities1.each { |community| user1.follow(community) }
# ID2のユーザーがID10〜40のコミュニティをフォローする
communities2.each { |community| user2.follow(community) }

# ID1から20のユーザーがID1のコミュニティをフォローする
users1.each { |user|  user.follow(community1)}
# ID10から15のユーザーがID2のコミュニティをフォローする
users2.each { |user|  user.follow(community2)}
