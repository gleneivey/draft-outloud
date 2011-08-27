### Run this script in place to populate the 'bin' and 'style' directories
### with the necessary third-party packages


    #### unpack jar files into 'bin'
cd  bin
mkdir -p temp

wget -O jing.zip http://jing-trang.googlecode.com/files/jing-20091111.zip
cd temp
unzip ../jing.zip
cd jing*
cp bin/jing.jar ../..
cp bin/saxon.jar ../..
cd ..  # temp
rm -r jing*

cd ..  # bin
wget -O fop-bin.tar.gz http://apache.cs.utah.edu/xmlgraphics/fop/binaries/fop-1.0-bin.tar.gz
cd temp
tar -xzf ../fop-bin.tar.gz
cd fop*
cp build/fop.jar ../..
cp lib/avalon-framework*.jar ../../avalon-framework.jar
cp lib/batik-all*.jar ../../batik-all.jar
cp lib/commons-io*.jar ../../commons-io.jar
cp lib/commons-logging*.jar ../../commons-logging.jar
cp lib/xercesImpl*.jar ../../xercesImpl.jar
cp lib/xmlgraphics-commons*.jar ../../xmlgraphics-commons.jar
cd ..  # temp
rm -r fop*

cd ..  # bin
wget -O offo-hyphenation.zip http://downloads.sourceforge.net/project/offo/offo-hyphenation/2.0/offo-hyphenation-binary_v2.0.zip\?r=\&ts=1314411676\&use_mirror=iweb
cd temp
unzip ../offo-hyphenation.zip
cp offo-hyphenation*/fop-hyph.jar ..
rm -r offo-hyphenation*

cd ..  # bin
wget -O resolver.tar.gz http://apache.cs.utah.edu//xerces/xml-commons/xml-commons-resolver-1.2.tar.gz
cd temp
tar -xzf ../resolver.tar.gz
cp xml-commons-resolver*/resolver.jar ..
rm -r xml-commons-resolver*

cd ..  # bin
rmdir temp
cd ..  # toolchain-docbook



    #### instal 'docbook-xsl-ns' into 'style'
cd style
wget -m -np -nH --cut-dirs=3 -P docbook-xsl-ns http://docbook.sourceforge.net/release/xsl-ns/current/
