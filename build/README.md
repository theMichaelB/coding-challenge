# Static Site Generator

Simple Python-based static site generator that converts markdown articles to HTML with AI instruction context.

## Overview

This generator converts `.md` files from the `docs/` directory into clean, responsive HTML pages. It's designed specifically for educational articles that include AI instruction context at the end.

## Requirements

- Python 3.6+
- `markdown` library

Install the markdown library:

```bash
pip install markdown
```

## Usage

Run the generator from the project root:

```bash
python3 build/generate.py
```

This will:
1. Find all `.md` files in the `docs/` directory
2. Convert them to HTML using the template
3. Save `.html` files alongside the original `.md` files

## File Structure

### Markdown Files

Markdown files should contain just the article content:

```markdown
# Article Title

Article content here...

Regular markdown formatting...
```

Or with explicit `<article>` tags:

```markdown
<article>
# Article Title

Article content here...
</article>
```

### AI Context Template

The AI instruction context is stored separately in `build/context-template.md` and is automatically appended to ALL generated HTML files. This ensures consistent AI instructions across all articles.

The generator will:
- Extract only the article content from each `.md` file
- Ignore any existing context in the file
- Apply the shared context template from `context-template.md`
- Convert both to HTML
- Wrap article in `<article>` tags
- Wrap instructions in `<section>` tags

## Template Customization

Edit `build/template.html` to customize:
- Styling (CSS in `<style>` tags)
- Layout
- Meta tags
- External resources

The template uses two placeholders:
- `{{TITLE}}` - Replaced with the first h1 heading
- `{{CONTENT}}` - Replaced with the generated HTML

## Output

Generated HTML files:
- Are saved in the same directory as the source `.md` files
- Have the same filename with `.html` extension
- Include all styling inline (no external dependencies)
- Are fully responsive and mobile-friendly

## Example

Input: `docs/technical/cloud-computing-ai.md`
Output: `docs/technical/cloud-computing-ai.html`

## Deployment

The generated HTML files can be:
- Served directly from the `docs/` directory
- Deployed to S3/CloudFront (as configured in the Terraform setup)
- Served by any static web server

No build artifacts or dependencies needed for deployment - just the HTML files.
