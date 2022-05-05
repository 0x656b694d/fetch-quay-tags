# fetch-quay-tags
Scripts to fetch image tags from `Quay.io` and filter them by date.

Use [fetch-tags.sh](fetch-tags.sh) to get the json documents (per page) for the given repository/image, then [older-than.sh](older-than.sh)
to find the tags older than the given date.

# Example
```
$ ./fetch-tags.sh repo/image $QUAY_BEARER_TOKEN
Fetching page 1
Fetching page 2
Done for repo/image on page 2
$ cat repo-image.*.json | ./older-than.sh 2 months ago
"v24"
"v25"
```

## Tag info example
```json
{
  "name": "latest-amd64",
  "reversion": false,
  "start_ts": 1635280054,
  "end_ts": 1635322600,
  "manifest_digest": "sha256:xxxx",
  "is_manifest_list": false,
  "size": 336759195,
  "last_modified": "Tue, 26 Oct 2021 20:27:34 -0000",
  "expiration": "Wed, 27 Oct 2021 08:16:40 -0000"
}
```

### Notes on Quay API json output
* When a tag is reset to another image, the old tag gets an expiration date set to the start date of the new tag;
* The `onlyActiveTags` query parameter would hide the expired tags.

### Note on Quay image lifetime
* Even though the expiration date has well passed, the image is still pullable, despite Quay documentation saying there's only 14 days grace period.
