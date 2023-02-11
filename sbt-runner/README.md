# Build
Run `docker build` from this folder [./](./)
```bash
docker build --progress=plain --platform amd64 -t sbt-runner:amd64 .
```

# Run
[./entrypoint.sh](./entrypoint.sh) manages copying credentials after the initial token exchange and when the image starts. 
This requires a volume mounted to `/actions-runner/creds` to persist the credentials. 

## First time run
The docker image depends on a volume mount to persist credentials gathered during first-time setup with Github.
Provide environment variable for URL and TOKEN found via Github's new runner dialog found by: 
1. Go to https://github.com/YOUR-REPO-HERE/settings/actions/runners
2. Click on new self-hosted runner 
3. Copy TOKEN and URL from the examples to use with docker 
4. Run the image:  
   where GITHUB-REPO-URL and GITHUB-TOKEN are found in step #3
    ```bash
    docker run  -v absolute-path-to-creds-folder:/actions-runner/creds -e URL=GITHUB-REPO-URL -e TOKEN=GITHUB-TOKEN sbt-runner:amd64
    ```
## Subsequent runs
After the first time run, the image should only need to be started with:  
```bash 
docker run  -v absolute-path-to-creds-folder:/actions-runner/creds sbt-runner:amd64
```