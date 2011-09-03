<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
    xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
version="1.0">

<!--  This file modifies how link text is generated for HTML output targets. -->

 <!-- Modifies the chapter xref text gen to be plain -->
  <xsl:template match="d:chapter|d:appendix|d:section|d:simplesect" mode="insert.title.markup">
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="title"/>
    
    <xsl:copy-of select="$title"/>

  </xsl:template>
  
  <!-- Modifies the book xref text gen to be italics -->
  <xsl:template match="d:book" mode="insert.title.markup">
    <xsl:param name="purpose"/>
    <xsl:param name="xrefstyle"/>
    <xsl:param name="title"/>
    
    <xsl:choose>
      <xsl:when test="$purpose = 'xref'">
        <i><xsl:copy-of select="$title"/></i>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$title"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

</xsl:stylesheet>