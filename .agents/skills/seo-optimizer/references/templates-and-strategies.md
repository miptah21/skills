# SEO Content Templates & Advanced Strategies

> Extracted from SKILL.md — content structure templates, advanced strategies, and monitoring.

## Content Structure Template

```markdown
# [Primary Keyword] — [Compelling Modifier]

## What is [Topic]? (H2)
Answer the core question directly in the first paragraph.
Include a definition that could be used as a featured snippet.

## Why [Topic] Matters (H2)
Value proposition with supporting data.

## How to [Action] (H2)
Step-by-step practical guide.

## Best Practices (H2)
Advanced tips for experienced practitioners.

## Common Mistakes to Avoid (H2)
Actionable warnings with alternatives.

## Conclusion
Summarize key points. Include a call to action.
```

## Page Type Templates

### Blog Post SEO

```html
<title>[Primary Keyword]: [Compelling Descriptor] (2025)</title>
<meta name="description" content="Learn [topic] with our comprehensive guide.
  Covers [key point 1], [key point 2], and [key point 3]. Updated for 2025.">
```

### Product/Service Page

```html
<title>[Product] - [Key Benefit] | [Brand]</title>
<meta name="description" content="[Product] helps you [benefit].
  Features: [feature 1], [feature 2]. [Social proof]. [CTA].">
```

### Local Business

```html
<title>[Service] in [City] | [Business Name] - [Differentiator]</title>
<meta name="description" content="[Service] in [City, State].
  [Years] experience. [Rating] stars. [Differentiator]. Call [phone].">
```

## Schema Markup Examples

### Article

```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Article Title",
  "datePublished": "2025-01-15",
  "dateModified": "2025-01-20",
  "author": { "@type": "Person", "name": "Author" },
  "publisher": { "@type": "Organization", "name": "Site" }
}
```

### FAQ

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "What is SEO?",
    "acceptedAnswer": {
      "@type": "Answer",
      "text": "SEO is the practice of optimizing..."
    }
  }]
}
```

### Local Business

```json
{
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "Business Name",
  "address": { "@type": "PostalAddress", "streetAddress": "123 Main St" },
  "geo": { "@type": "GeoCoordinates", "latitude": 40.7128, "longitude": -74.006 },
  "openingHoursSpecification": [{
    "@type": "OpeningHoursSpecification",
    "dayOfWeek": ["Monday", "Tuesday"],
    "opens": "09:00", "closes": "17:00"
  }]
}
```

---

## Advanced Strategies

### E-E-A-T Signals (Experience, Expertise, Authority, Trust)

- Author bios with credentials and links
- About page with organization history
- External citations and data sources
- Reviews/testimonials with schema markup

### Core Web Vitals Targets

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| LCP | ≤ 2.5s | 2.5-4.0s | > 4.0s |
| INP | ≤ 200ms | 200-500ms | > 500ms |
| CLS | ≤ 0.1 | 0.1-0.25 | > 0.25 |

### Local SEO Checklist

- [ ] Google Business Profile claimed and optimized
- [ ] NAP (Name, Address, Phone) consistent across all listings
- [ ] LocalBusiness schema markup on every page
- [ ] Location-specific content with city/region keywords
- [ ] Local backlinks from directories and organizations

---

## Monitoring & Analytics

### Key Metrics to Track

| Metric | Tool | Frequency |
|--------|------|-----------|
| Organic traffic | GA4, Search Console | Weekly |
| Keyword rankings | Ahrefs, SEMrush | Weekly |
| Core Web Vitals | PageSpeed Insights | Monthly |
| Crawl errors | Search Console | Weekly |
| Backlink profile | Ahrefs | Monthly |
| Conversion rate | GA4 | Weekly |
