puts "🌱 Seeding users..."

User.create!(
  email: "admin@example.com",
  password: "admin123",
  password_confirmation: "admin123",
  role: "admin"
)

User.create!(
  email: "organizer@example.com",
  password: "organizer123",
  password_confirmation: "organizer123",
  role: "organizer"
)

User.create!(
  email: "user@example.com",
  password: "user123",
  password_confirmation: "user123",
  role: "regular_user"
)

puts "✅ Seeded admin, organizer, and normal user!"
