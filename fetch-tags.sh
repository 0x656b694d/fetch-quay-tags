#!/bin/sh

IMAGE="$1"
TOKEN="$2"

set -eu

if [ -z "$IMAGE" -o -z "$TOKEN" ]
then
    echo -e "Usage:\n\tfetch_tags.sh REPO/IMAGE BEARER_TOKEN"
    exit 1
fi

PAGE=1
while true
do
    echo "Fetching page $PAGE"
    FILENAME="${IMAGE/\//-}.$PAGE.json"
    curl --fail -sS -H "Authorization: Bearer $TOKEN" -X GET \
        "https://quay.io/api/v1/repository/${IMAGE}/tag/?limit=100&page=$PAGE" -o "$FILENAME"
    [ "$?" -gt 0 ] && break
    has_more=$(jq ".has_additional" "$FILENAME")
    [ "$has_more" == "false" ] && break
    PAGE=$((PAGE+1))
done
echo "Done for $IMAGE on page $PAGE"

