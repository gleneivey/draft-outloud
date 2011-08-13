Feature: Site home page displays general information and book's tabel of contents
  In order to understand what information and actions are available,
  a visitor to the top of a Draft Outloud site
  wants a simple introduction and the content of the book draft
  
  Scenario: Visit home page
    Given a site for the book "minimal_book"
    When I go to the home page
    Then I should see "My Book:Explanations" within the page title
    And I should see "My Book" within the title
    And I should see "Explanations for Stuff" within the subtitle

