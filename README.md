# debian snapshot container for garden linux 
The `mirror-snapshot.sh` script creates a multi arch container for Garden Linux package builds, and tags it with a Garden Linux version and uploads it to ghcr.io

# Why?

- Debian snapshot container do not offer a multi arch container. A multi arch container enables our build cre to decide to use the apropriate architecture 
- mirroring debian snapshot container for reproducibility



# Example
The following cmd creates a multi arch debian-snapshot-container for bookworm-202221024, 
which is the snapshot version used for 934.0.

You will need to set up a Personal access token.
```
./mirror-snapshot.sh arm64v8/debian:bookworm-20221024  debian/snapshot:bookworm-20221024 934.10
```



