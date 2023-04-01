Post.destroy_all
10.times do |i|
  Post.create(
    title: "My #{(i + 1).ordinalize} post",
    body: Faker::Lorem.paragraphs(number: 3).join("\n")
  )
end
