<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version="1.0"  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">

  <!--  Customizes the resolution of olink references. -->

  <!-- Always use the title of the book if the olink refers to content that is 
  not in the current book. -->
  <xsl:param name="olink.doctitle" select="'yes'" />
  
  <!-- Resolve olink element's targetptr attribute using the current book's 
    target data before checking the target data of the book specified by the 
    olink element's targetdoc attribute. -->
  <xsl:param name="prefer.internal.olink" select="1" />

</xsl:stylesheet>