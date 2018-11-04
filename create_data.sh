set -e
set -o xtrace

if [ -e app/videos.json ]; then
  rm app/videos.json
fi

ROOT=/projects/data/videos
for d in $ROOT/*; do
  for j in $d/*.info.json; do
    cat $j | jq -c '{put: .id, fields: {id: .id, tags: .tags, title: .title, description: .description, like_count: .like_count, dislike_count: .dislike_count, thumbnail: .thumbnail, view_count: .view_count, upload_date: .upload_date, duration: .duration}}' >> app/videos.json
  done
done
