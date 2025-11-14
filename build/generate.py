#!/usr/bin/env python3
"""
Static site generator for converting markdown articles to HTML.
Preserves AI instruction context at the end of each article.
"""

import os
import re
from pathlib import Path

try:
    import markdown
except ImportError:
    print("Error: markdown library not found.")
    print("Install it with: pip install markdown")
    exit(1)


def extract_title(content):
    """Extract the first h1 heading as the title."""
    match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return "Article"


def split_content(md_content):
    """
    Split markdown content into article and context sections.
    Context sections start with ### Article Context or similar.
    """
    # Look for </article> tag first (if content has explicit structure)
    if '</article>' in md_content:
        parts = md_content.split('</article>', 1)
        article = parts[0].strip()
        context = parts[1].strip() if len(parts) > 1 else ""
        return article, context

    # Otherwise, look for the context section (starts with ### and contains 'Context' or 'Your Role')
    # Use a more precise regex that captures from the beginning of the line
    pattern = r'\n(###\s+(?:Article Context|Your Role).*)'
    match = re.search(pattern, md_content, re.DOTALL)

    if match:
        split_index = match.start()
        article = md_content[:split_index].strip()
        context = md_content[split_index:].strip()
        return article, context

    # If no context section found, return all as article
    return md_content.strip(), ""


def convert_md_to_html(md_file_path, template_path, output_dir, context_template):
    """Convert a single markdown file to HTML using the template."""
    print(f"Processing: {md_file_path}")

    # Read markdown file
    with open(md_file_path, 'r', encoding='utf-8') as f:
        md_content = f.read()

    # Check if content starts with <article> tag (already has structure)
    has_article_tag = md_content.strip().startswith('<article>')

    # Split into article and context FIRST (before removing tags)
    article_content, existing_context = split_content(md_content)

    # If it has <article> tag, remove it from the article content
    if has_article_tag:
        article_content = re.sub(r'^<article>\s*', '', article_content)
        article_content = re.sub(r'\s*</article>\s*$', '', article_content)

    # Extract title
    title = extract_title(article_content)

    # Convert markdown to HTML
    md = markdown.Markdown(extensions=['extra', 'nl2br', 'sane_lists'])
    article_html = md.convert(article_content)

    # Always use the context template (ignore any existing context in the file)
    context_html = ""
    if context_template:
        md_context = markdown.Markdown(extensions=['extra', 'nl2br', 'sane_lists'])
        context_html = f"\n    <section>\n        {md_context.convert(context_template)}\n    </section>"

    # Wrap article content in <article> tag
    full_content = f"    <article>\n        {article_html}\n    </article>{context_html}"

    # Read template
    with open(template_path, 'r', encoding='utf-8') as f:
        template = f.read()

    # Replace placeholders
    html = template.replace('{{TITLE}}', title)
    html = html.replace('{{CONTENT}}', full_content)

    # Determine output path (preserve directory structure)
    docs_parent = Path(__file__).parent.parent / 'docs'
    rel_path = md_file_path.relative_to(docs_parent)
    output_path = output_dir / rel_path.with_suffix('.html')

    # Create output directory if needed
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # Write HTML file
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html)

    print(f"  → {output_path}")
    return output_path


def main():
    """Main function to generate all HTML files."""
    # Setup paths
    project_root = Path(__file__).parent.parent
    docs_dir = project_root / 'docs'
    build_dir = project_root / 'build'
    output_dir = project_root / 'docs'
    template_path = build_dir / 'template.html'
    context_template_path = build_dir / 'context-template.md'

    # Verify template exists
    if not template_path.exists():
        print(f"Error: Template not found at {template_path}")
        exit(1)

    # Load context template
    context_template = ""
    if context_template_path.exists():
        with open(context_template_path, 'r', encoding='utf-8') as f:
            context_template = f.read()
        print(f"Loaded AI context template from {context_template_path.name}")
    else:
        print(f"Warning: Context template not found at {context_template_path}")

    # Find all .md files in docs directory
    md_files = list(docs_dir.rglob('*.md'))

    if not md_files:
        print("No markdown files found in docs/ directory")
        return

    print(f"Found {len(md_files)} markdown file(s)")
    print("-" * 60)

    # Convert each markdown file
    converted = 0
    for md_file in md_files:
        try:
            convert_md_to_html(md_file, template_path, output_dir, context_template)
            converted += 1
        except Exception as e:
            print(f"  ✗ Error processing {md_file}: {e}")

    print("-" * 60)
    print(f"Successfully converted {converted}/{len(md_files)} files")
    if context_template:
        print("✓ AI context template applied to all files")


if __name__ == '__main__':
    main()
