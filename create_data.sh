set -e
set -o xtrace

if [ -e app/videos.json ]; then
  rm app/videos.json
fi

ROOT=/projects/data/videos
for d in $ROOT/*; do
  for j in $d/*.info.json; do
    API_FILE=$d/api.json

    if [ -f $API_FILE ]; then
      jq -s '.[0] * .[1]' $j $d/api.json | jq -c '{put: ("id:video:video::" + .id), fields: {id: .id, tags: .tags, title: .title, description: .description, like_count: .like_count, dislike_count: .dislike_count, thumbnail: .thumbnail, view_count: .view_count, upload_date: .upload_date, duration: .duration, embeddable:(if .items[0].status.embeddable then 1 else 0 end),relevantTopicIds:.items[0].relevantTopicIds,topicCategories:.items[0].topicCategories,embedHtml:.items[0].player.embedHtml}}' | jq -c "del(.fields[] | nulls)" >> app/videos.json
    fi
  done
done
