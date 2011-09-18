
BOOK_FIXTURES = {
  "minimal_book" => {
    :repository_url =>
        "git://github.com/gleneivey/test-data-for-draft-outloud.git",
    :book_title => "My Book: Explanations for Stuff",
    :short_title => "My Book:Explanations",
    :page_footer => "<span style='color: green'>My book is super-cool!</span>",
    :root_path => "book/my-book.xml"
  },
  "invalid_book" => {
    :repository_url =>
        "git://github.com/gleneivey/test-data-for-draft-outloud.git",
    :book_title => "My Book: Explanations for Stuff",
    :short_title => "My Book:Explanations",
    :page_footer => "<span style='color: green'>My book is super-cool!</span>",
    :root_path => "book/invalid-xml.xml"
  },
  "bad_book" => {
    :repository_url =>
        "git://github.com/gleneivey/no-such-repository.git",
    :book_title => "My Book: Explanations for Stuff",
    :short_title => "My Book:Explanations",
    :page_footer => "<span style='color: green'>My book is super-cool!</span>",
    :root_path => "book/invalid-xml.xml"
  }
}

Given /^a site for the book "(.*)"$/ do |selector|
  book = BOOK_FIXTURES[selector]
  raise "Don't have a predefined data set for '#{selector}'" unless book.present?

  Customization.create!(
      :repository_url => book[:repository_url],
      :book_title => book[:book_title],
      :short_title => book[:short_title],
      :book_root_file_path => book[:root_path]
  )

  FileUtils.mkpath ApplicationController.cache_dir.fragments
  html = File.open(ApplicationController.cache_dir.page_footer, "w")
  html.puts book[:page_footer]
  html.close
end
