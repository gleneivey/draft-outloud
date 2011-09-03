<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  
  <!-- Adds a header to the top of the generated HTML pages. 
  This particular customization is intended to match the headers on the default FUSE Forge 
  Web site templates. -->
  <xsl:template name="user.header.navigation">
    <div id="forgeheader">
      <div class="wrapper">
        <ul>
          <li><a href="http://forgedp.fusesource.org/index.html">Home</a></li>
          <li><a href="http://forgedp.fusesource.org/download.html">Download</a></li>
          <li><a href="http://forgedp.fusesource.org/source.html">Source</a></li>
          <li><a href="http://forgedp.fusesource.org/license.html">Licensing</a></li>
          <li><a href="http://forgedp.fusesource.org/documentation/index.html">Documentation</a></li>
        </ul>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>