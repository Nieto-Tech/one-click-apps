# from your repo root
npm ci
npm run validate_apps
npm run formatter-write
npm run build   # creates dist/ with v2/v3/v4
cp -f public/index.html dist/index.html || true

# publish dist to gh-pages using a worktree
rm -rf /tmp/oneclick-pages
git worktree prune
git fetch origin
git worktree add -B gh-pages /tmp/oneclick-pages origin/gh-pages

rsync -av --delete --exclude '.git' dist/ /tmp/oneclick-pages/
touch /tmp/oneclick-pages/.nojekyll
rm -f /tmp/oneclick-pages/CNAME

cd /tmp/oneclick-pages
git add -A
git commit -m "publish: rebuild catalog"
git push --force-with-lease origin HEAD:gh-pages
cd -
git worktree remove /tmp/oneclick-pages -f
