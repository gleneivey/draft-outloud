<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0"
                xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">


     <!-- Customize the width of the running headers -->
  <xsl:param name="header.column.widths">3 1 3</xsl:param>
  
  <!-- Customize the width of the running footers -->
  <xsl:param name="footer.column.widths">4 0 1</xsl:param>

  <!-- Modifies the running headers on PDF output. The original version of this template can be found in fo\pagesetup.xsl. -->
  
<xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <fo:block>

    <!-- sequence can be odd, even, first, blank -->
    <!-- position can be left, center, right -->
    <xsl:choose>

      <xsl:when test="$position='left' and $sequence='even' and $pageclass='body'">
              <xsl:apply-templates select="." mode="object.title.markup"/>                  
      </xsl:when>

      <xsl:when test="$position='center'">
        <xsl:call-template name="draft.text"/>
      </xsl:when>

      <xsl:when test="$position='right' and $sequence='odd' and $pageclass='body'">
<fo:retrieve-marker 
      retrieve-class-name="section.head.marker"
      retrieve-position="first-including-carryover"
      retrieve-boundary="page-sequence"/>
      </xsl:when>
      
      <xsl:when test="$sequence = 'blank'">
      </xsl:when>

      <xsl:when test="$sequence = 'first'">
        <!-- nothing for first pages -->
      </xsl:when>

    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- Modifies the footers to include Book Title and version -->
  <xsl:template name="footer.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>
    
    <fo:block>
      <!-- pageclass can be front, body, back -->
      <!-- sequence can be odd, even, first, blank -->
      <!-- position can be left, center, right -->
      <xsl:choose>
        <xsl:when test="$pageclass = 'titlepage'">
          <!-- nop; no footer on title pages -->
        </xsl:when>
        
        <xsl:when test="$double.sided != 0 and $sequence = 'even'
          and $position='left'">
          <fo:page-number/>
        </xsl:when>

        <xsl:when test="$double.sided != 0 and $sequence = 'even'
          and $position='right'">
          <xsl:apply-templates select="/d:book/d:info[1]/d:productname[1]" />
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="/d:book[1]" mode="title.markup"/>
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="/d:book/d:info[1]/d:releaseinfo[1]" mode="titlepage.mode"/>
        </xsl:when>
        
        <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
          and $position='right'">
          <fo:page-number/>
        </xsl:when>

        <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
          and $position='left'">
          <xsl:apply-templates select="/d:book/d:info[1]/d:productname[1]" />
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="/d:book[1]" mode="title.markup"/>
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="/d:book/d:info[1]/d:releaseinfo[1]" mode="titlepage.mode"/>
        </xsl:when>
        
        <xsl:when test="$double.sided = 0 and $position='center'">
          <fo:page-number/>
        </xsl:when>
        
        <xsl:when test="$sequence='blank'">
          <xsl:choose>
            <xsl:when test="$double.sided != 0 and $position = 'left'">
              <fo:page-number/>
            </xsl:when>
            <xsl:when test="$double.sided != 0 and $position = 'right'">
              <xsl:apply-templates select="/d:book/d:info[1]/d:productname[1]" />
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="/d:book[1]" mode="title.markup"/>
              <xsl:text> </xsl:text>
              <xsl:apply-templates select="/d:book/d:info[1]/d:releaseinfo[1]" mode="titlepage.mode"/>
            </xsl:when>
            <xsl:when test="$double.sided = 0 and $position = 'center'">
              <fo:page-number/>
            </xsl:when>
            <xsl:otherwise>
              <!-- nop -->
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <!-- nop -->
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>

</xsl:stylesheet>