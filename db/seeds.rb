@admin = User.create!(username: "admin",
  email: "firesoul0608@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  status: 1,
  role: 0)
@admin.create_user_profile(name: "Le Duy Vuong")
@user = User.create!(username: "khachvanglai",
  email: "khachvanglai@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  status: 1,
  role: 0)
@user.create_user_profile(name: "Khach vang lai")

Category.create!(category_name: "Food")
Category.create!(category_name: "Drink")
Tag.create(content: "A")
Faker::Config.locale = "vi"


