### This is a trivial script for processing a DocBook book into PDF, I use
### it to test the content of the toolchain directory.


echo 'validate against schema'
java -jar bin/jing.jar -C schema/catalog.xml schema/docbook.rng $1


# XML -> HTML
echo 'XML to HTML'
java -cp bin:bin/saxon.jar:bin/resolver.jar:bin/xercesImpl.jar -Xmx1G \
      -Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl \
      -Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl \
      -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration \
    com.icl.saxon.StyleSheet \
      -x org.apache.xml.resolver.tools.ResolvingXMLReader \
      -y org.apache.xml.resolver.tools.ResolvingXMLReader \
      -r org.apache.xml.resolver.tools.CatalogResolver \
    $1 \
      style/onechunk.xsl \
      target.database.document=book-site-html.xml \
      current.docid=book

exit
# don't need olink processing yet

# XML -> FO -> PDF
echo 'XML to FO'
java -cp bin:bin/saxon.jar:bin/resolver.jar:bin/xercesImpl.jar -Xmx1G \
      -Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl \
      -Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl \
      -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration \
    com.icl.saxon.StyleSheet \
      -x org.apache.xml.resolver.tools.ResolvingXMLReader \
      -y org.apache.xml.resolver.tools.ResolvingXMLReader \
      -r org.apache.xml.resolver.tools.CatalogResolver \
    -o book.fo \
    $1 \
      style/pdf.xsl \
      target.database.document=book-site-pdf.xml \
      current.docid=book

echo 'FO to PDF'
java -Xmx1G -cp bin/fop.jar:bin/fop-hyph.jar:bin/avalon-framework.jar:bin/batik-all.jar:bin/commons-io.jar:bin/commons-logging.jar:bin/xmlgraphics-commons.jar \
    org.apache.fop.cli.Main \
      -q -fo book.fo -pdf book.pdf
