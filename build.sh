#!/bin/bash

# --- Configuration ---
SRC_DIR="src"
DOCS_DIR="docs"
CSS_PATH="$DOCS_DIR/css/style.css"
SITE_TITLE="¡Bienvenido!"

# --- Functions ---

# Generate the full HTML page with sidebar and content
generate_html_page() {
    local page_title="$1"
    local content_html="$2"
    local nav_html="$3"

    cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${page_title} - ${SITE_TITLE}</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
    <div class="page-wrapper">
        <aside class="sidebar">
            <h1>${SITE_TITLE}</h1>
            <nav>
                ${nav_html}
            </nav>
        </aside>
        <main class="content">
            ${content_html}
        </main>
    </div>
</body>
</html>
EOF
}

# Build the navigation menu dynamically from Markdown files
generate_nav() {
    local nav=""
    for file in "$SRC_DIR"/*.md; do
        local fname=$(basename "$file")
        local name="${fname%.*}"
        local title=$(grep -m1 "^# " "$file" | sed 's/^# //' | xargs)
        [ -z "$title" ] && title="${name^}"  # Capitalize fallback
        nav+="<li><a href=\"${name}.html\">${title}</a></li>"
    done
    echo "<ul>${nav}</ul>"
}

# --- Start Build ---

echo "📦 Starting static site build..."

# 1. Clean and set up output directory
rm -rf "$DOCS_DIR"
mkdir -p "$DOCS_DIR/css"
cp -r "$SRC_DIR/figures" "$DOCS_DIR/figures"
cp -r "$SRC_DIR/pdfs" "$DOCS_DIR/pdfs"

# 2. Write the CSS file (responsive layout + theme + sticky sidebar)
cat > "$CSS_PATH" << 'EOF'
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    margin: 0;
    padding: 0;
    line-height: 1.6;
}
.page-wrapper {
    display: flex;
    flex-direction: row;
    min-height: 100vh;
}
.sidebar {
    width: 250px;
    background: #f7f7f7;
    padding: 20px;
    box-sizing: border-box;
    border-right: 1px solid #ddd;
    position: sticky;
    top: 0;
    height: 100vh;
    overflow-y: auto;
}
.sidebar h1 {
    font-size: 1.5em;
    margin-top: 0;
}
.sidebar nav ul {
    list-style: none;
    padding-left: 0;
}
.sidebar nav ul li {
    margin-bottom: 10px;
}
.sidebar nav ul li a {
    text-decoration: none;
    color: #3498db;
    font-weight: bold;
}
.content {
    flex-grow: 1;
    padding: 30px;
    box-sizing: border-box;
    max-width: 960px;
    margin: auto;
}
h1, h2, h3 {
    border-bottom: 1px solid #eaecef;
    padding-bottom: 0.3em;
}
a {
    color: #3498db;
}

mark {
  background-color: #f7f7f7; /* Replace #ff0000 with your desired color code or name */
  color: #3498db; /* Optional: Change text color for better contrast */
}

/* Responsive layout */
@media (max-width: 768px) {
    .page-wrapper {
        flex-direction: column;
    }
    .sidebar {
        width: 100%;
        height: auto;
        position: relative;
        border-right: none;
        border-bottom: 1px solid #ddd;
    }
}
EOF

# 3. Generate navigation HTML
NAV_HTML=$(generate_nav)

# 4. Convert each Markdown file
for md_file in "$SRC_DIR"/*.md; do
    filename=$(basename "$md_file")
    name="${filename%.*}"
    output_file="$DOCS_DIR/$name.html"

    echo "⚙️ Converting '$filename' -> '$output_file'..."

    # Convert Markdown to HTML fragment
    CONTENT_HTML=$(pandoc -f markdown -t html "$md_file")

    # Extract title or fallback
    TITLE=$(grep -m1 "^# " "$md_file" | sed 's/^# //' | xargs)
    [ -z "$TITLE" ] && TITLE="${name^}"

    # Generate full HTML
    generate_html_page "$TITLE" "$CONTENT_HTML" "$NAV_HTML" > "$output_file"
done

echo "✅ Build complete! Output in '$DOCS_DIR'."
echo "💡 You can now deploy via GitHub Pages or open the .html files in your browser."
