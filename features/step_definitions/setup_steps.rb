
BOOK_FIXTURES = {
  "minimal_book" => {
    :book_title => "My Book: Explanations for Stuff",
    :short_title => "My Book:Explanations"
  }
}

Given /^a site for the book "(.*)"$/ do |selector|
  book = BOOK_FIXTURES[selector]
  raise "Don't have a predefined data set for '#{selector}'" unless book.present?

  Customization.create!(
      :book_title => book[:book_title],
      :short_title => book[:short_title]
  )
end
