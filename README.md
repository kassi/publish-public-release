# Publish Public Release

Github Action to publish a release from a private repository to a secondary public repository.

This is useful when you want to keep the source private, but still use the release management of Github to publish releases with README and CHANGELOG, for instance.

The action can be configured to update files in the repository as well as upload a release file.

# Usage

```
- name: Create Public Release
  uses: kassi/publish-public-release@v1
  with:
    # Public repository name with owner. For example, kassi/publish-public-release
    repository: ''

    # Personal access token (PAT) used to fetch the repository. The PAT is configured
    # with the local git config, which enables your scripts to run authenticated git
    # commands. The post-job step removes the PAT.
    #
    # We recommend using a service account with the least permissions necessary. Also
    # when generating a new PAT, select the least scopes necessary.
    #
    # [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
    #
    # Default: ${{ github.token }}
    token: ''

    # SSH key used to fetch and update the public repository.
    #
    # Set this as a Deploy key inside the public repository and enable write access.
    deploy_key: ''

    # The e-mail used for committing to the public repository.
    committer_email: ''

    # The name used for committing to the public repository.
    committer_name: ''

    # Specifies whether the changelog should be copied to the release.
    # Set to 'false' in order to not touch a CHANGELOG file.
    # Default: to `CHANGELOG.md`.
    copy_changelog: CHANGELOG.md

    # Specifies the name of the readme file to be copied to the release.
    # Set to 'false' in order to not touch a README file.
    # Default: `README.md`.
    copy_readme: README.md

    # When given, the readme can be truncated at and including the given regular expression.
    #
    # Example:
    #   truncate_readme_regex: "^## Development"
    # Will remove everything from the README starting at the line beginning with "## Development".
    truncate_readme_regex: ''

    # A list of files to be uploaded to the release, given as multiline string.
    files: ''

    # When this is set to true, then the release notes are taken from the `CHANGELOG`.
    release_body_from_changelog: true

    # Gives the release a custom name. Defaults to tag name
    name: ''

    # The name of the tag to be used.
    tag_name: ${{ github.ref_name }}

    # Creates a draft release. Defaults to false
    draft: false

    # Identify the release as a prerelease. Defaults to false
    prerelease: false

    # Specifies whether this release should be set as the latest release for the repository. Drafts and prereleases cannot be set as latest. Can be `true`, `false`, or `legacy`.
    make_latest: false

```

# License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
