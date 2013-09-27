namespace :categories do
  desc "Category management"
  task :create => :environment do
    category = Category.create(name: "Arts")
      sub = category.categories.create(name: "Design")
      sub = category.categories.create(name: "Fashion &amp; Beauty")
      sub = category.categories.create(name: "Food")
      sub = category.categories.create(name: "Literature")
      sub = category.categories.create(name: "Performing Arts")
      sub = category.categories.create(name: "Visual Arts")

    category = Category.create(name: "Business")
      sub = category.categories.create(name: "Business News")
      sub = category.categories.create(name: "Careers")
      sub = category.categories.create(name: "Investing")
      sub = category.categories.create(name: "Management &amp; Marketing")
      sub = category.categories.create(name: "Shopping")

    category = Category.create(name: "Comedy")

    category = Category.create(name: "Education")
      sub = category.categories.create(name: "Education")
      sub = category.categories.create(name: "Education Technology")
      sub = category.categories.create(name: "Higher Education")
      sub = category.categories.create(name: "K-12")
      sub = category.categories.create(name: "Language Courses")
      sub = category.categories.create(name: "Training")

    category = Category.create(name: "Games &amp; Hobbies")
      sub = category.categories.create(name: "Automotive")
      sub = category.categories.create(name: "Aviation")
      sub = category.categories.create(name: "Hobbies")
      sub = category.categories.create(name: "Other Games")
      sub = category.categories.create(name: "Video Games")

    category = Category.create(name: "Government &amp; Organizations")
      sub = category.categories.create(name: "Local")
      sub = category.categories.create(name: "National")
      sub = category.categories.create(name: "Non-profit")
      sub = category.categories.create(name: "Regional")

    category = Category.create(name: "Health")
      sub = category.categories.create(name: "Alternative Health")
      sub = category.categories.create(name: "Fitness &amp; Nutrition")
      sub = category.categories.create(name: "Self-Help")
      sub = category.categories.create(name: "Sexuality")

    category = Category.create(name: "Kids &amp; Family")
    category = Category.create(name: "Music")
    category = Category.create(name: "News &amp; Politics")

    category = Category.create(name: "Religion &amp; Spirituality")
      sub = category.categories.create(name: "Buddhism")
      sub = category.categories.create(name: "Christianity")
      sub = category.categories.create(name: "Hinduism")
      sub = category.categories.create(name: "Islam")
      sub = category.categories.create(name: "Judaism")
      sub = category.categories.create(name: "Other")
      sub = category.categories.create(name: "Spirituality")

    category = Category.create(name: "Science &amp; Medicine")
      sub = category.categories.create(name: "Medicine")
      sub = category.categories.create(name: "Natural Sciences")
      sub = category.categories.create(name: "Social Sciences")

    category = Category.create(name: "Society &amp; Culture")
      sub = category.categories.create(name: "History")
      sub = category.categories.create(name: "Personal Journals")
      sub = category.categories.create(name: "Philosophy")
      sub = category.categories.create(name: "Places &amp; Travel")

    category = Category.create(name: "Sports &amp; Recreation")
      sub = category.categories.create(name: "Amateur")
      sub = category.categories.create(name: "College &amp; High School")
      sub = category.categories.create(name: "Outdoor")
      sub = category.categories.create(name: "Professional")

    category = Category.create(name: "Technology")
      sub = category.categories.create(name: "Gadgets")
      sub = category.categories.create(name: "Tech News")
      sub = category.categories.create(name: "Podcasting")
      sub = category.categories.create(name: "Software How-To")

    category = Category.create(name: "TV &amp; Film")
  end

  task :destroy => :environment do
    Category.destroy_all
  end
end
