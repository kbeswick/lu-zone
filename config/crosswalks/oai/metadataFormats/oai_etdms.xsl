<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
	Developed by DSpace @ Lyncode <dspace@lyncode.com>

 -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" />
	
	<xsl:template match="/">
		<oai_etdms:thesis xmlns:oai_etdms="http://www.ndltd.org/standards/metadata/etdms/1.0/" 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			xsi:schemaLocation="http://www.ndltd.org/standards/metadata/etdms/1.0/ http://www.ndltd.org/standards/metadata/etdms/1.0/etdms.xsd">
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
				<oai_etdms:title><xsl:value-of select="." /></oai_etdms:title>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field[@name='value']">
				<oai_etdms:creator><xsl:value-of select="." /></oai_etdms:creator>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name!='author']/doc:element/doc:field[@name='value']">
				<oai_etdms:contributor><xsl:value-of select="." /></oai_etdms:contributor>
			</xsl:for-each>
			<xsl:choose>
				<xsl:when test="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
					<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
						<oai_etdms:subject><xsl:value-of select="." /></oai_etdms:subject>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<oai_etdms:subject/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element/doc:field[@name='value']">
				<oai_etdms:description><xsl:value-of select="." /></oai_etdms:description>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
				<oai_etdms:description><xsl:value-of select="." /></oai_etdms:description>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[1]/doc:element/doc:field[@name='value']">
				<oai_etdms:date><xsl:value-of select="substring(.,0,11)" /></oai_etdms:date>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']">
				<oai_etdms:type><xsl:value-of select="." /></oai_etdms:type>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='bundles']/doc:element[@name='bundle']">
				<xsl:if test="doc:field[@name='name']/text() = 'ORIGINAL'">
					<xsl:variable name="bitstreamurl" select="doc:element[@name='bitstreams']/doc:element[@name='bitstream']/doc:field[@name='url']"/>
					<xsl:for-each select="doc:element[@name='bitstreams']/doc:element[@name='bitstream']/doc:field[@name='format']">
						<oai_etdms:format><xsl:value-of select="." /></oai_etdms:format>
					</xsl:for-each>
					<oai_etdms:identifier><xsl:value-of select="concat(substring($bitstreamurl, 0, string-length($bitstreamurl)-8), doc:element[@name='bitstreams']/doc:element[@name='bitstream']/doc:field[@name='name'])"/></oai_etdms:identifier>
				</xsl:if>
			</xsl:for-each>

			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:identifier><xsl:value-of select="." /></oai_etdms:identifier>
			</xsl:for-each>

			<xsl:if test="doc:metadata/doc:element[@name='thesis']">
				<xsl:variable name="ident" select="substring-after(doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element/doc:element/doc:field[@name='value'], 'https://zone.biblio.laurentian.ca/dspace/handle/10219/')" />
				<oai_etdms:identifier><xsl:value-of select="concat('TC-OSUL-', $ident)" /></oai_etdms:identifier>
			</xsl:if>
   			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:field[@name='value']">	
				<oai_etdms:rights><xsl:value-of select="." /></oai_etdms:rights>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='covarage']/doc:element/doc:field[@name='value']">
				<oai_etdms:covarage><xsl:value-of select="." /></oai_etdms:covarage>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='covarage']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:covarage><xsl:value-of select="." /></oai_etdms:covarage>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:field[@name='value']">
				<oai_etdms:publisher><xsl:value-of select="." /></oai_etdms:publisher>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:publisher><xsl:value-of select="." /></oai_etdms:publisher>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='source']/doc:element/doc:field[@name='value']">
				<oai_etdms:source><xsl:value-of select="." /></oai_etdms:source>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='source']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:source><xsl:value-of select="." /></oai_etdms:source>
			</xsl:for-each>
			<xsl:if test="doc:metadata/doc:element[@name='thesis']">
			<oai_etdms:degree>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='name']/doc:element/doc:field[@name='value']">
				<oai_etdms:name><xsl:value-of select="." /></oai_etdms:name>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='name']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:name><xsl:value-of select="." /></oai_etdms:name>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='level']/doc:element/doc:field[@name='value']">
				<oai_etdms:level><xsl:value-of select="." /></oai_etdms:level>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='level']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:level><xsl:value-of select="." /></oai_etdms:level>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='discipline']/doc:element/doc:field[@name='value']">
				<oai_etdms:discipline><xsl:value-of select="." /></oai_etdms:discipline>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='discipline']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:discipline><xsl:value-of select="." /></oai_etdms:discipline>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='grantor']/doc:element/doc:field[@name='value']">
				<oai_etdms:grantor><xsl:value-of select="." /></oai_etdms:grantor>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='grantor']/doc:element/doc:element/doc:field[@name='value']">
				<oai_etdms:grantor><xsl:value-of select="." /></oai_etdms:grantor>
			</xsl:for-each>
			</oai_etdms:degree>
			</xsl:if>
		</oai_etdms:thesis>
	</xsl:template>
</xsl:stylesheet>
