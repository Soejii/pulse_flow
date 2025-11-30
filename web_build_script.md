# 1. Build Flutter web with correct base href for GitHub Pages
flutter build web --base-href /pulse_flow/

# 2. Remove old docs folder if it exists
if (Test-Path docs) {
    Remove-Item docs -Recurse -Force
}

# 3. Recreate docs folder
New-Item docs -ItemType Directory | Out-Null

# 4. Copy new web build into docs
Copy-Item "build\web\*" "docs\" -Recurse -Force

# 5. Commit and push (change the message if you want)
git add .
git commit -m "chore: updating web build"
git push
