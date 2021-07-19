# mass-repo-migrator
Migrate N git repositories from X to Y in just Z clicks

## Prerequisites

- git has been installed in your machine
- git credentials for both side have been configured
- A list of source repositories has been prepared
- A list of target repositories has been prepared
- All target repositories must be empty

## Usages

- Download ``migrate.sh`` to your local machine
- Update ``source_repositories`` and ``target_repositories`` <br><br>
  ```bash
  # list of source repositories
  source_repositories=(
    # example: bitbucket as source
    "https://bitbucket.org/foo/repo1.git"
    "https://bitbucket.org/foo/repo2.git"
    "https://bitbucket.org/foo/repo3.git"
    "https://bitbucket.org/foo/repo4.git"
  )

  # list of target repositories
  target_repositories=(
    # example: AWS CodeCommit as target
    "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo1"
    "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo2"
    "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo3"
    "https://git-codecommit.ap-southeast-1.amazonaws.com/v1/repos/repo4"
  )
  ```
 - Run the script <br><br>
   ```
   $ chmod +x ./migrate.sh
   $ ./migrate.sh
   ```
