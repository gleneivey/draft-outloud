<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  version="1.0">

  <!-- ===================================================================== -->
  <!-- Modified the olink template from xhtml/xref.xsl.                      -->
  <!-- Modified olinks so that external links open in a new window.          -->
  <!-- ===================================================================== -->
  <xsl:template match="d:olink" name="olink">
    
    <xsl:call-template name="anchor"/>
    
    <xsl:variable name="localinfo" select="@localinfo"/>
    
    <xsl:variable name="targetdoc.att" select="@targetdoc"/>
    <xsl:variable name="targetptr.att" select="@targetptr"/>
    
    <xsl:variable name="olink.lang">
      <xsl:call-template name="l10n.language">
        <xsl:with-param name="xref-context" select="true()"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="target.database.filename">
      <xsl:call-template name="select.target.database">
        <xsl:with-param name="targetdoc.att" select="$targetdoc.att"/>
        <xsl:with-param name="targetptr.att" select="$targetptr.att"/>
        <xsl:with-param name="olink.lang" select="$olink.lang"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="target.database" select="document($target.database.filename,/)"/>
    
    <xsl:if test="$olink.debug != 0">
      <xsl:message>
        <xsl:text>Olink debug: root element of target.database '</xsl:text>
        <xsl:value-of select="$target.database.filename"/>
        <xsl:text>' is '</xsl:text>
        <xsl:value-of select="local-name($target.database/*[1])"/>
        <xsl:text>'.</xsl:text>
      </xsl:message>
    </xsl:if>
    
    <xsl:variable name="olink.key">
      <xsl:call-template name="select.olink.key">
        <xsl:with-param name="targetdoc.att" select="$targetdoc.att"/>
        <xsl:with-param name="targetptr.att" select="$targetptr.att"/>
        <xsl:with-param name="olink.lang" select="$olink.lang"/>
        <xsl:with-param name="target.database" select="$target.database"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:if test="string-length($olink.key) = 0">
      <xsl:message>
        <xsl:text>Error: unresolved olink: </xsl:text>
        <xsl:text>targetdoc/targetptr = '</xsl:text>
        <xsl:value-of select="$targetdoc.att"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="$targetptr.att"/>
        <xsl:text>'.</xsl:text>
      </xsl:message>
    </xsl:if>
    
    <xsl:variable name="href">
      <xsl:call-template name="make.olink.href">
        <xsl:with-param name="olink.key" select="$olink.key"/>
        <xsl:with-param name="target.database" select="$target.database"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="hottext">
      <xsl:call-template name="olink.hottext">
        <xsl:with-param name="target.database" select="$target.database"/>
        <xsl:with-param name="olink.key" select="$olink.key"/>
        <xsl:with-param name="olink.lang" select="$olink.lang"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="olink.docname.citation">
      <xsl:call-template name="olink.document.citation">
        <xsl:with-param name="olink.key" select="$olink.key"/>
        <xsl:with-param name="target.database" select="$target.database"/>
        <xsl:with-param name="olink.lang" select="$olink.lang"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="olink.page.citation">
      <xsl:call-template name="olink.page.citation">
        <xsl:with-param name="olink.key" select="$olink.key"/>
        <xsl:with-param name="target.database" select="$target.database"/>
        <xsl:with-param name="olink.lang" select="$olink.lang"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="$href != ''">
        <xsl:choose>
          <xsl:when test="$targetptr.att = ancestor::d:book/attribute::id">
            <a href="{$href}" class="olink" target="_blank">
              <xsl:copy-of select="$hottext"/>
            </a>
          </xsl:when>
          <xsl:when test="$targetdoc.att != $current.docid">
            <a href="{$href}" class="olink" target="_blank">
              <xsl:copy-of select="$hottext"/>
            </a>
          </xsl:when>
          <xsl:otherwise>
            <a href="{$href}" class="olink">
              <xsl:copy-of select="$hottext"/>
            </a>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:copy-of select="$olink.page.citation"/>
        <xsl:copy-of select="$olink.docname.citation"/>
      </xsl:when>
      <xsl:otherwise>
        <span class="olink"><xsl:copy-of select="$hottext"/></span>
        <xsl:copy-of select="$olink.page.citation"/>
        <xsl:copy-of select="$olink.docname.citation"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
