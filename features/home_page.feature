Feature: Site home page displays general information and book's tabel of contents
  In order to understand what information and actions are available,
  a visitor to the top of a Draft Outloud site
  wants a simple introduction and the content of the book draft
  
  Scenario: Visit home page
    When I go to the home page
    Then I should see "table of contents"

