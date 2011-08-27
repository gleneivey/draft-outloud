<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <!-- Customization to make gui... elements print bold -->
  <xsl:template match="d:guibutton">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="d:guiicon">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="d:guilabel">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="d:guimenu">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="d:guimenuitem">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

<xsl:template match="d:guisubmenu">
  <xsl:call-template name="inline.boldseq"/>
</xsl:template>

</xsl:stylesheet>