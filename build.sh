set -e

REVEALOPTS="--css css/custom.css,css/font-awesome.min.css --scripts scripts/custom.js,scripts/print.js"
reveal-md ${REVEALOPTS} --theme black -S _static slides.md
reveal-md ${REVEALOPTS} --theme white -S _static/white slides.md

cp -a fonts _static/assets/fonts
cp -a fonts _static/white/assets/fonts
cp -a img _static/img
cp -a img _static/white/img

HEAD=$(git rev-parse HEAD)
git add _static/
TREE=$(git write-tree --prefix=_static)
git rm -rf _static/
COMMIT=$(git commit-tree -m "site at ${HEAD}" ${TREE})
git branch -f gh-pages ${COMMIT}
git archive --prefix davidep-ad17-slides/ --format zip -o davidep-ad17-slides.zip gh-pages
