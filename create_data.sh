set -e
set -o xtrace

if [ -e app/talks.json ]; then
  rm app/talks.json
fi

ROOT=/projects/data/videos
for d in $ROOT/*; do
  for j in $d/*.info.json; do
    cat $j | jq -c '{put: .id, fields: {tags: .tags, title: .title, description: .description, like_count: .like_count, dislike_count: .dislike_count, thumbnail: .thumbnail, view_count: .view_count, upload_date: .upload_date, duration: .duration}}' >> app/talks.json
  done
done
