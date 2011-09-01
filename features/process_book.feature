Feature: process_book.rb checks out the specified book version and processes it

  Scenario: Process book from clone of repo with original version of page_footer.html
    Given a site for the book "minimal_book"
    And a directory named "public"
    When I successfully run `process_book --no-xml git://github.com/gleneivey/test-data-for-draft-outloud.git initial-page_footer`
    Then the file "book-cache/web/fragments/page_footer.html" should contain exactly:
      """
      Book-specific page footer<br/>
      from the repository test-data-for-draft-outloud
      <div>
        content from initial checkin to git
      </div>


      """
    And the file "public/processing-status.html" should contain "NO XML</b>: true"
    And the file "public/processing-status.html" should contain:
      """
      Exiting with status code <b>0</b>.</p>
          <h3>Done</h3>
        </body>
      </html>

      """

  Scenario: Process book from checkout of repo with second version of page_footer.html
    Given I run `git clone git://github.com/gleneivey/test-data-for-draft-outloud.git book-repo`
    And a site for the book "minimal_book"
    And a directory named "public"
    When I successfully run `process_book --no-xml git://github.com/gleneivey/test-data-for-draft-outloud.git second-page_footer`
    Then the stderr should not contain "fatal: destination path 'book-repo' already exists and is not an empty directory."
    And the file "book-cache/web/fragments/page_footer.html" should contain exactly:
      """
      Book-specific page footer<br/>
      from the repository test-data-for-draft-outloud
      <div>
        second version of this file to be put in git
      </div>


      """
    And the file "public/processing-status.html" should contain:
      """
      Exiting with status code <b>0</b>.</p>
          <h3>Done</h3>
        </body>
      </html>

      """

  Scenario: Processing aborts if git clone fails
    Given a directory named "public"
    When I run `process_book --no-xml git://github.com/gleneivey/no-such-repository.git master`
    Then the file "public/processing-status.html" should contain "Could not find Repository gleneivey/no-such-repository"
    And a file named "book-cache/web/fragments/page_footer.html" should not exist
    And a file named "public/my-book.pdf" should not exist
    And a file named "public/favicon.ico" should not exist

  Scenario: Processing aborts if git checkout fails
    Given I run `git clone git://github.com/gleneivey/test-data-for-draft-outloud.git book-repo`
    And a directory named "public"
    When I run `process_book --no-xml git://github.com/gleneivey/test-data-for-draft-outloud.git no-such-tag`
    Then the file "public/processing-status.html" should contain "pathspec 'no-such-tag' did not match any file(s) known to git"
    And the file "public/processing-status.html" should contain:
      """
      Exiting with status code <b>2</b>.</p>
          <h3>Done</h3>
        </body>
      </html>

      """
    And a file named "book-cache/web/fragments/page_footer.html" should not exist
    And a file named "public/my-book.pdf" should not exist
    And a file named "public/favicon.ico" should not exist


  Scenario: Process book from checkout of latest repo to content in cache...public
    Given I run `git clone git://github.com/gleneivey/test-data-for-draft-outloud.git book-repo`
    And a site for the book "minimal_book"
    And a directory named "public"
    When I successfully run `process_book git://github.com/gleneivey/test-data-for-draft-outloud.git master`
    Then a file named "public/my-book.pdf" should exist
    And the file "public/processing-status.html" should contain "NO XML</b>: false"
    And the file "public/processing-status.html" should contain:
      """
      Exiting with status code <b>0</b>.</p>
          <h3>Done</h3>
        </body>
      </html>

      """
    And a file named "public/favicon.ico" should exist
    And the file "book-cache/web/fragments/page_footer.html" should contain exactly:
      """
      Book-specific page footer<br/>
      from the repository test-data-for-draft-outloud
      <div>
        third version of this file to be put in git
      </div>


      """

  Scenario: Processing of book whose XML doesn't validate aborts, doesn't update cache
    Given a site for the book "invalid_book"
    And a directory named "public"
    When I run `process_book git://github.com/gleneivey/test-data-for-draft-outloud.git master`
    Then the file "public/processing-status.html" should match /element .book. not allowed here/
    And the file "public/processing-status.html" should match /error: element .chapter. incomplete/
    And the file "public/processing-status.html" should match /The element type .book. must be terminated/
    And the file "public/processing-status.html" should contain:
      """
      Exiting with status code <b>5</b>.</p>
          <h3>Done</h3>
        </body>
      </html>

      """
    And a file named "book-cache/web/fragments/page_footer.html" should not exist
    And a file named "public/my-book.pdf" should not exist
    And a file named "public/favicon.ico" should not exist
