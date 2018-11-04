set -e
set -o xtrace

if [ -e app/videos.json ]; then
  rm app/videos.json
fi

ROOT=/projects/data/videos
for d in $ROOT/*; do
  for j in $d/*.info.json; do
    jq -s '.[0] * .[1]' $j $d/api.json | jq -c '{put: .id, fields: {id: .id, tags: .tags, title: .title, description: .description, like_count: .like_count, dislike_count: .dislike_count, thumbnail: .thumbnail, view_count: .view_count, upload_date: .upload_date, duration: .duration, embeddable:.items[0].status.embeddable,relevantTopicIds:.items[0].relevantTopicIds,topicCategories:.items[0].topicCategories,embedHtml:.items[0].player.embedHtml}}' >> app/videos.json
  done
done
