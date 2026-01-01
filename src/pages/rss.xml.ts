import rss from '@astrojs/rss';
import type { APIContext } from 'astro';
import productsData from '../data/products.json';
import eventsData from '../data/events.json';

export async function GET(context: APIContext) {
  const products = productsData.products || [];
  const events = eventsData.events || [];
  
  // 商品をRSSアイテムに変換
  const productItems = products.slice(0, 10).map((product) => ({
    title: product.name,
    pubDate: parseJapaneseDate(product.published_at),
    description: `VRChat向けワールドアセット「${product.name}」を公開しました。Quest対応・軽量化にこだわった大崎商会のアセットです。`,
    link: `/products/${product.id}/`,
    categories: product.tags?.slice(0, 5) || [],
  }));
  
  // イベントをRSSアイテムに変換
  const eventItems = events.slice(0, 5).map((event) => ({
    title: `KemonoBarずんどこ ${event.date} 開催レポート`,
    pubDate: new Date(event.date),
    description: event.summary || `${event.date}に開催された「KemonoBarずんどこ」のレポートです。参加者${event.participants}名。`,
    link: `/events/archive/${event.date.replace(/-/g, '')}/`,
    categories: ['イベント', 'KemonoBarずんどこ'],
  }));
  
  // 全アイテムを日付順にソート
  const allItems = [...productItems, ...eventItems].sort((a, b) => 
    new Date(b.pubDate).getTime() - new Date(a.pubDate).getTime()
  );

  return rss({
    title: '大崎商会 - みんなVRでたのしくくらそう',
    description: 'VRChatで使える軽量・Quest対応ワールドアセットを開発。居酒屋イベント「KemonoBarずんどこ」も定期開催中！新商品やイベント情報をお届けします。',
    site: context.site!,
    items: allItems.slice(0, 20),
    customData: `<language>ja</language>
<copyright>© 2025 大崎商会</copyright>
<managingEditor>osaki_vrc@example.com (おおさきくん)</managingEditor>
<webMaster>osaki_vrc@example.com (おおさきくん)</webMaster>
<lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
<category>VRChat</category>
<category>ワールドアセット</category>
<category>3Dモデル</category>`,
    stylesheet: '/rss-styles.xsl',
  });
}

// 日本語日付をパース（例: "2025年12月29日 22時30分"）
function parseJapaneseDate(dateStr: string): Date {
  if (!dateStr) return new Date();
  
  const match = dateStr.match(/(\d{4})年(\d{1,2})月(\d{1,2})日\s*(\d{1,2})時(\d{1,2})分?/);
  if (match) {
    const [, year, month, day, hour, minute] = match;
    return new Date(
      parseInt(year),
      parseInt(month) - 1,
      parseInt(day),
      parseInt(hour),
      parseInt(minute) || 0
    );
  }
  
  return new Date();
}
