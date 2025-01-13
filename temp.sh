#zero downtime deployment nextjs without vercel

echo "Deploy starting.."

git pull

yarn || exit

BUILD_DIR=temp yarn build || exit

if [ ! -d "temp" ]; then
  echo '\033[31m temp Directory not exists!\033[0m'  
  exit 1;
fi


rm -rf .next

mv temp .next

pm2 reload icdp-fe --update-env

echo "Deploy done."

#make sure `next.config.js` it set `distDir: process.env.BUILD_DIR`