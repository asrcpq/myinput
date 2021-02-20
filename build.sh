set -e
cd "$(dirname "$0")"
mkdir -p dicts
bash ./mozc/build.sh
bash ./sunpinyin/build.sh
