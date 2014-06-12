<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" />
    <xsl:template match="/">
        <div class="panel panel-default">
            <div class="panel-heading"><h4 class="panel-title">Otsingu tulemused</h4></div>
            <div class="panel-body">
                <xsl:choose>
                    <xsl:when test="count(objects/object) &gt; 0">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Dokumendi nimetus</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="objects/object">
                                    <tr>
                                        <td><xsl:value-of select="doc/document" /></td>
                                        <td><a href="{path}"><xsl:value-of select="doc/name" /></a></td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="alert alert-warning">
                            <strong>Otsingutingimustele ei leitud ühtegi vastet!</strong>
                            Vajadusel korrigeeri sisestatud otsingutingimusi.
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
