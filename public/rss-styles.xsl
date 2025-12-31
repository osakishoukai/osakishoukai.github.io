<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ja">
      <head>
        <title><xsl:value-of select="/rss/channel/title"/> - RSS Feed</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style type="text/css">
          * {
            box-sizing: border-box;
          }
          body {
            font-family: 'Zen Maru Gothic', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem;
            background: #FFF8F0;
            color: #5D4037;
            line-height: 1.6;
          }
          .header {
            background: linear-gradient(135deg, #FF8C00 0%, #FF6B00 100%);
            color: white;
            padding: 2rem;
            border-radius: 1rem;
            margin-bottom: 2rem;
            text-align: center;
          }
          .header h1 {
            margin: 0 0 0.5rem 0;
            font-size: 1.75rem;
            font-weight: 900;
          }
          .header p {
            margin: 0;
            opacity: 0.9;
          }
          .notice {
            background: white;
            border: 2px solid #FF8C00;
            border-radius: 0.75rem;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
          }
          .notice h2 {
            color: #FF8C00;
            margin: 0 0 0.5rem 0;
            font-size: 1rem;
          }
          .notice p {
            margin: 0;
            font-size: 0.875rem;
          }
          .notice code {
            background: #FFF3E0;
            padding: 0.125rem 0.375rem;
            border-radius: 0.25rem;
            font-family: monospace;
          }
          .items {
            list-style: none;
            padding: 0;
            margin: 0;
          }
          .item {
            background: white;
            border: 2px solid #FF8C00;
            border-radius: 0.75rem;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: transform 0.2s ease;
          }
          .item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
          }
          .item-title {
            margin: 0 0 0.5rem 0;
            font-size: 1.125rem;
            font-weight: 700;
          }
          .item-title a {
            color: #5D4037;
            text-decoration: none;
          }
          .item-title a:hover {
            color: #FF8C00;
          }
          .item-date {
            font-size: 0.875rem;
            color: #8D6E63;
            margin-bottom: 0.5rem;
          }
          .item-description {
            font-size: 0.9375rem;
            color: #5D4037;
            margin: 0;
          }
          .footer {
            text-align: center;
            padding: 2rem;
            font-size: 0.875rem;
            color: #8D6E63;
          }
          .footer a {
            color: #FF8C00;
          }
        </style>
      </head>
      <body>
        <div class="header">
          <h1>🍊 <xsl:value-of select="/rss/channel/title"/></h1>
          <p><xsl:value-of select="/rss/channel/description"/></p>
        </div>
        
        <div class="notice">
          <h2>📡 RSSフィードについて</h2>
          <p>これはRSSフィードです。このURLをRSSリーダーに登録すると、大崎商会の最新情報を受け取れます。<br/>
          フィードURL: <code><xsl:value-of select="/rss/channel/link"/>rss.xml</code></p>
        </div>
        
        <ul class="items">
          <xsl:for-each select="/rss/channel/item">
            <li class="item">
              <h3 class="item-title">
                <a>
                  <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                  </xsl:attribute>
                  <xsl:value-of select="title"/>
                </a>
              </h3>
              <div class="item-date">
                <xsl:value-of select="pubDate"/>
              </div>
              <p class="item-description">
                <xsl:value-of select="description"/>
              </p>
            </li>
          </xsl:for-each>
        </ul>
        
        <div class="footer">
          <p>© 2025 大崎商会 | <a href="https://osakishoukai.github.io">サイトに戻る</a></p>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
