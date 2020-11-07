<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:outline="http://wkhtmltopdf.org/outline"
                xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
              indent="yes" />
  <xsl:template match="outline:outline">
    <html>
      <head>
        <title>Table of Contents</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>
          h1 {
            font-size: 2rem;
            font-style: normal;
            margin-top: 1rem;
            margin-bottom: 2rem;
            letter-spacing: 0.03125em;
          }
          div {
            margin-top: 0.2em;
          }
          span {float: right;}
          li {list-style: none;}
          ul {
            font-size: 20px;
            font-family: ETBembo;
          }
          ul ul {font-size: 100%; }
          ul {padding-left: 0em;}
          ul ul {padding-left: 1em;}
          a {text-decoration:none; color: black;}
        </style>
      </head>
      <body>
        <h1>TAFEL</h1>
        <ul><xsl:apply-templates select="outline:item/outline:item"/></ul>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="outline:item">
    <li>
      <xsl:if test="@title!=''">
        <div>
          <xsl:variable name="level" select="count(ancestor::outline:item) + 1"/>
          <xsl:choose>
            <xsl:when test="$level &lt;= 2">
              <a>
                <xsl:if test="@link">
                  <xsl:attribute name="href"><xsl:value-of select="@link"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="@backLink">
                  <xsl:attribute name="name"><xsl:value-of select="@backLink"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="@title" /> 
              </a>
              <span> <xsl:value-of select="@page" /> </span>
            </xsl:when>
            <xsl:when test="$level = 3"/>
            <xsl:when test="$level = 4">
              <a>
                <xsl:if test="@link">
                  <xsl:attribute name="href"><xsl:value-of select="@link"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="@backLink">
                  <xsl:attribute name="name"><xsl:value-of select="@backLink"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="concat(parent::outline:item/@title,'. ',@title)" /> 
              </a>
              <span> <xsl:value-of select="@page" /> </span>
            </xsl:when>
          </xsl:choose>
        </div>
      </xsl:if>
      <ul>
        <xsl:comment>added to prevent self-closing tags in QtXmlPatterns</xsl:comment>
        <xsl:apply-templates select="outline:item"/>
      </ul>
    </li>
  </xsl:template>
  <xsl:template match="outline:item/outline:item/outline:item/outline:item/outline:item"/>
</xsl:stylesheet>
