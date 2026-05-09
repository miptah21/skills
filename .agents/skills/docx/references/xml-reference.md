# DOCX XML Reference & Advanced Patterns

> Extracted from SKILL.md — loaded when editing existing documents or working with XML.

## XML Reference

### Schema Compliance

- **Element order in `<w:pPr>`**: `<w:pStyle>`, `<w:numPr>`, `<w:spacing>`, `<w:ind>`, `<w:jc>`, `<w:rPr>` last
- **Whitespace**: Add `xml:space="preserve"` to `<w:t>` with leading/trailing spaces
- **RSIDs**: Must be 8-digit hex (e.g., `00AB1234`)

### Tracked Changes

**Insertion:**
```xml
<w:ins w:id="1" w:author="Claude" w:date="2025-01-01T00:00:00Z">
  <w:r><w:t>inserted text</w:t></w:r>
</w:ins>
```

**Deletion:**
```xml
<w:del w:id="2" w:author="Claude" w:date="2025-01-01T00:00:00Z">
  <w:r><w:delText>deleted text</w:delText></w:r>
</w:del>
```

**Inside `<w:del>`**: Use `<w:delText>` instead of `<w:t>`.

**Minimal edits — only mark what changes:**
```xml
<w:r><w:t>The term is </w:t></w:r>
<w:del w:id="1" w:author="Claude" w:date="...">
  <w:r><w:delText>30</w:delText></w:r>
</w:del>
<w:ins w:id="2" w:author="Claude" w:date="...">
  <w:r><w:t>60</w:t></w:r>
</w:ins>
<w:r><w:t> days.</w:t></w:r>
```

**Deleting entire paragraphs** — also mark paragraph mark:
```xml
<w:p>
  <w:pPr><w:rPr>
    <w:del w:id="1" w:author="Claude" w:date="..."/>
  </w:rPr></w:pPr>
  <w:del w:id="2" w:author="Claude" w:date="...">
    <w:r><w:delText>Entire paragraph content</w:delText></w:r>
  </w:del>
</w:p>
```

**Rejecting another author's insertion:**
```xml
<w:ins w:author="Jane" w:id="5">
  <w:del w:author="Claude" w:id="10">
    <w:r><w:delText>their inserted text</w:delText></w:r>
  </w:del>
</w:ins>
```

### Comments

After running `comment.py`, add markers to document.xml:
```xml
<w:commentRangeStart w:id="0"/>
<w:r><w:t>commented text</w:t></w:r>
<w:commentRangeEnd w:id="0"/>
<w:r><w:rPr><w:rStyle w:val="CommentReference"/></w:rPr><w:commentReference w:id="0"/></w:r>
```

**CRITICAL**: `<w:commentRangeStart>` and `<w:commentRangeEnd>` are siblings of `<w:r>`, never inside.

### Images in XML

1. Add image to `word/media/`
2. Add relationship to `word/_rels/document.xml.rels`
3. Add content type to `[Content_Types].xml`
4. Reference with `<w:drawing><wp:inline>...<a:blip r:embed="rId5"/>`

### Smart Quote Entities

| Entity | Character |
|--------|-----------|
| `&#x2018;` | ' (left single) |
| `&#x2019;` | ' (right single / apostrophe) |
| `&#x201C;` | " (left double) |
| `&#x201D;` | " (right double) |

## Advanced docx-js Patterns

### Tab Stops
```javascript
// Right-align text on same line
new Paragraph({
  children: [new TextRun("Company Name"), new TextRun("\tJanuary 2025")],
  tabStops: [{ type: TabStopType.RIGHT, position: TabStopPosition.MAX }],
})
```

### Multi-Column Layouts
```javascript
sections: [{
  properties: {
    column: { count: 2, space: 720, equalWidth: true, separate: true },
  },
  children: [/* content flows across columns */]
}]
```

### Footnotes
```javascript
const doc = new Document({
  footnotes: {
    1: { children: [new Paragraph("Source: Annual Report 2024")] },
  },
  sections: [{
    children: [new Paragraph({
      children: [new TextRun("Revenue grew 15%"), new FootnoteReferenceRun(1)],
    })]
  }]
});
```

### Hyperlinks
```javascript
// External
new ExternalHyperlink({
  children: [new TextRun({ text: "Click here", style: "Hyperlink" })],
  link: "https://example.com",
})

// Internal (bookmark + reference)
new Bookmark({ id: "chapter1", children: [new TextRun("Chapter 1")] })
new InternalHyperlink({ children: [...], anchor: "chapter1" })
```
