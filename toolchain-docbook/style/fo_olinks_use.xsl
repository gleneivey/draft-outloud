<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  version="1.0"
      xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">

  <!--Stylesheet fragments whose names begin with ziona_ are designed to be 
      included in DocBook XSL stylesheets, whose names begin with iona-*. 
      
      This is ziona_olinks_use.xsl
      which is included in all iona-* DocBook stylesheets that have an HTML 
      or PDF output target, where one or more chapter files use olink elements
      to cross-reference to other chapters or books. The olink system presumes
      that a site.xml file is one directory above all the book files in a 
      project, and presumes that your xsltproc command line includes a
      current.docid argument that specifies the book name being generated,
      using the exact book name specified in the site.xml file. 
  -->

  <xsl:param name="targets.filename" select="'targetpdf.db'" />
  <xsl:param name="target.database.document" select="'../sitepdf.xml'" />
  <xsl:param name="olink.doctitle" select="'yes'" />
  <xsl:param name="prefer.internal.olink" select="1" />

</xsl:stylesheet>