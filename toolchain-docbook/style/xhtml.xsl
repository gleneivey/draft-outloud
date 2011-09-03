<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d"
  version="1.0">
  <!-- Customization for generating HTML output. -->

  <!-- Imports the base DocBook XSLT style sheet. -->
  <xsl:import href="docbook-xsl-ns/xhtml/chunk.xsl"/>
 
 <!-- Sets up the target database for using olinks. -->
 <xsl:import href="html_olinks_use.xsl"/>

  <!-- Customizes xref generation to look cleaner. -->
  <xsl:import href="html_xrefs.xsl"/>
  
    <!-- Customizes olinks to generate links that open in a new window. -->
  <xsl:import href="html_olinks.xsl"/>
  
  <!-- Customizes the navigation header and footer added to HTML pages. -->
  <xsl:import href="html_navigation.xsl"/>
  
  <!--Adds a user defined navigation header to the generated pages. -->
  <xsl:import href="html_header.xsl"/>
  
  <!-- Imports the title page customization. -->
  <xsl:import href="html_titlepage.xsl" />
  
  <!-- Adds a line needed by IE to figure out the proper encoding -->
  <xsl:template name="user.head.content">
    <meta  content="text/html;  charset=UTF-8"  http-equiv="Content-Type" />
  </xsl:template>
  
  <!-- Activates the use of processor extensions -->
  <xsl:param name="use.extensions" select="1"></xsl:param>
  
  <!-- Specifies the name of the output directory into which the chunks are 
    written .-->
  <xsl:param name="base.dir">./output/</xsl:param>
  
  <!--Create separate legal notice page"-->
  <xsl:param name="generate.legalnotice.link" select="1"/>
  
  <!--Use id attribute as chunk filename-->
  <xsl:param name="use.id.as.filename">1</xsl:param>
  
  <!--Use this CSS stylesheet in the HTML output-->
  <xsl:param name="html.stylesheet" select="'./imagesdb/docbook.css'"/>
  
  <!--Do not display a title on abstracts-->
  <xsl:param name="abstract.notitle.enabled" select="1"></xsl:param>
  
  <!--Break on sections-->
  <xsl:param name="chunk.section.depth" select="2"/>
  <xsl:param name="chunk.first.sections" select="1"/>
  
  <!-- Allow lower organizational levels to inherit keyword metadata from 
  parent pages -->
  <xsl:param name="inherit.keywords" select="1" />
  
  <!-- Add the contents of an abstract element to the META description of 
  a generated HTML page. -->
  <xsl:param name="generate.meta.abstract" select="1" />
  
  <!-- Use | to separate  GUI menus. -->
  <xsl:param name="menuchoice.separator" select="'|'" />
  <xsl:param name="menuchoice.menu.separator" select="'|'" />
  
  <!--Control which pages include a TOC-->
  <xsl:param name="generate.toc">appendix  toc,title
    article   toc,title
    book      toc,title,figure,table,example
    chapter   toc,title
    part      toc,title
    reference toc,title
    section   toc,title
    set       toc,title</xsl:param>
  <xsl:param name="generate.section.toc.level" select="2"/>
  
  <!-- Make admonitions use graphics -->
  <xsl:param name="admon.graphics" select="1" />
  <xsl:param name="admon.graphics.path" select="'imagesdb/'" />
  <xsl:param name="admon.graphics.extension" select="'.gif'" />
  <xsl:param name="admon.style" select="''" />
  
  <!-- Do not let XSLT generate style information -->
  <xsl:param name="css.decoration" select="0" />
  
  <!-- Generate valid XHTML -->
  <xsl:param name="make.valid.html" select="1" />

  <!-- Forces Web links to open in new page -->
  <xsl:param name="ulink.target">_blank</xsl:param>
  
  <!-- Use graphics for page navigation -->
  <xsl:param name="navig.graphics" select="1" />
  <xsl:param name="navig.graphics.path" select="'imagesdb/'" />
  <xsl:param name="navig.graphics.extension" select="'.png'" />
  <xsl:param name="navig.showtitles" select="0" />
  
  <!-- Needed to make Saxon generate proper XHTML -->
  <xsl:output method="saxon:xhtml" />  
  
</xsl:stylesheet>
