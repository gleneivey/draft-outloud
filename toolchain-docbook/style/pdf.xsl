<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Customization style sheet for PDF output. -->

  <!-- Imports the base DocBook style sheet. -->
  <xsl:import href="docbook-xsl-ns/fo/docbook.xsl"/>

  <!-- Sets up the olink target database. -->
  <xsl:import href="fo_olinks_use.xsl"/>

  <!-- Customizes how the code callouts are generated. -->
  <xsl:import href="fo_callouts_use.xsl"/>
  
  <!-- Makes content marked using the gui elements bold face. -->
  <xsl:import href="fo_guitext.xsl" />
  
  <xsl:import href="fo_titlepage.xsl" />
  
  <!-- Adds the headers and footers to the pages. -->
  <xsl:import href="fo_header.xsl" />

  <!-- Activates the proper XSLT extensions for the FOP FO processor. -->
  <xsl:param name="fop1.extensions" select="1"></xsl:param>
  
  <!-- Specifies that the publication system should prefer imageobject 
    elements that  use role="fo" when generating PDF. -->
  <xsl:param name="use.role.for.mediaobject" select="1" />
  <xsl:param name="preferred.mediaobject.role" select="fo" />
  
  <xsl:param name="formal.procedures" select="1" />
  <xsl:attribute-set name="formal.object.properties">
    <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
  </xsl:attribute-set> 
  
  <!-- Makes pages double sided -->
  <xsl:param name="double.sided" select="1"></xsl:param>
  
  <!-- Makes monospace text wrap -->
  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">8pt</xsl:attribute>
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-size">90%</xsl:attribute>    
  </xsl:attribute-set>
  
  <!-- Makes admonitions use graphics -->
  <xsl:param name="admon.graphics" select="1" />
  <xsl:param name="admon.graphics.path" select="'output/imagesdb/'" />
  <xsl:param name="admon.graphics.extension" select="'.gif'" />
  <xsl:template match="*" mode="admon.graphic.width">
    <xsl:text>25px</xsl:text>
  </xsl:template>

</xsl:stylesheet>
