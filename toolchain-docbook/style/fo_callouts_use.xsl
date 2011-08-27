<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">

  <!-- Customizes callouts so that they use unicode characters instead of 
    graphics  -->

  <xsl:param name="callout.graphics" select="'0'" />
  <xsl:param name="callout.unicode" select="'1'" />
   <xsl:param name="callout.unicode.number.limit" select="'10'" />
  
</xsl:stylesheet>