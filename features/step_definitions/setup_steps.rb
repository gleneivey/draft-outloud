
BOOK_FIXTURES = {
  "minimal_book" => {
    :book_title => "My Book: Explanations for Stuff",
    :short_title => "My Book:Explanations",
    :page_footer => "<span style='color: green'>My book is super-cool!</span>"
  }
}

Given /^a site for the book "(.*)"$/ do |selector|
  book = BOOK_FIXTURES[selector]
  raise "Don't have a predefined data set for '#{selector}'" unless book.present?

  Customization.create!(
      :book_title => book[:book_title],
      :short_title => book[:short_title]
  )

  FileUtils.mkpath ApplicationController.cache_dir.fragments
  html = File.open(ApplicationController.cache_dir.page_footer, "w")
  html.puts book[:page_footer]
  html.close
end
