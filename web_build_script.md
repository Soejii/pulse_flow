# 1. Build Flutter web with correct base href for GitHub Pages
fvm flutter build web --release --base-href "/pulse_flow/"

# 2. Remove old docs folder if it exists
if (Test-Path docs) {
    Remove-Item docs -Recurse -Force
}

# 3. Recreate docs folder
New-Item docs -ItemType Directory | Out-Null

# 4. Copy new web build into docs
Copy-Item "build\web\*" "docs\" -Recurse -Force

# 5. GitHub Pages SPA fallback (recommended)
Copy-Item "docs\index.html" "docs\404.html" -Force

# 6. Commit and push
git add .
git commit -m "chore: update web build"
git push
