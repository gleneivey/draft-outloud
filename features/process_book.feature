Feature: process_book.rb checks out the specified book version and processes it

  Scenario: Clone test repo with original version of page_footer.html
    When I successfully run `../../tools/process_book git://github.com/gleneivey/test-data-for-draft-outloud.git initial-page_footer`
    Then the file "book-cache/web/fragments/page_footer.html" should contain exactly:
      """
      Book-specific page footer<br/>
      from the repository test-data-for-draft-outloud
      <div>
        content from initial checkin to git
      </div>


      """

  Scenario: Checkout test repo with second version of page_footer.html
    Given I run `git clone git://github.com/gleneivey/test-data-for-draft-outloud.git book-repo`
    When I successfully run `../../tools/process_book git://github.com/gleneivey/test-data-for-draft-outloud.git second-page_footer`
    Then the stderr should not contain "fatal: destination path 'book-repo' already exists and is not an empty directory."
    And the file "book-cache/web/fragments/page_footer.html" should contain exactly:
      """
      Book-specific page footer<br/>
      from the repository test-data-for-draft-outloud
      <div>
        second version of this file to be put in git
      </div>


      """

