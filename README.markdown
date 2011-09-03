Copyright (C) 2011 - Glen E. Ivey
  (see the end of this file for copyright/licensing information)


## This is Draft Outloud ##

Draft Outloud is a Ruby-on-Rails web application for hosting the draft
of a book while it is being written.

The project is hosted on GitHub at:  https://github.com/gleneivey/draft-outloud

Documentation is located in its GitHub wiki, and bug reporting uses
GitHub Issues.  The development roadmap is located in Pivotal Tracker
at:  https://www.pivotaltracker.com/projects/342047


## Structure of a Draft Book ##

Draft Outload displays books written using the DocBook XML markup.  It
fetches the content for the book from a git repository, processes it
using standard DocBook XSL style sheets into HTML for display and HTML
and PDF for download.  The HTML is displayed using a combination of
the CSS built into Draft Outloud and included in the git repository
along with the book's content.

The repository also contains metadata about the book specifically for
display in the Draft Outloud web application, including custom home
page content, headers, and footers.


## Configuring Draft Outloud ##

As a Ruby-on-Rails web application, Draft Outloud expects to be
configured to use a SQL database.  As installed, it includes a sample
database configuration file:  `config/database-mysql-development.yml`.

Within the database is a special single-row table, `book_info`, that
contains the information that Draft Outloud uses to load the book
content that it presents.  Data must be loaded into this table "by
hand" prior to running Draft Outload.

These two mechanisms are described in the Draft Outloud wiki at
https://github.com/gleneivey/draft-outloud/wiki/Customizing-a-Draft-Outloud-Installation


----------------------------------------------------------------

    Permission is granted to copy, distribute and/or modify this
    document under the terms of the GNU Free Documentation License,
    Version 1.3, published by the Free Software Foundation; with no
    Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.

    You should have received a copy of the GNU Free Documentation
    License along with document in the file COPYING.DOCUMENTATION.  If
    not, see http://www.gnu.org/licenses/.

