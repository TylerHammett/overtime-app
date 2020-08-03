100.times do |post|
    Post.create!(date: Date.today, rationale: "rationale #{post}")
end

