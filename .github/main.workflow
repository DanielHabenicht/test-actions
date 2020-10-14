name: PR - Preview
on:
  pull_request:
    branches: [ master ]
    

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Find Comment
      uses: peter-evans/find-comment@v1
      id: fc
      with:
        issue-number: ${{ github.event.pull_request.number }}
        comment-author: github-actions
        body-includes: This PR is available as a preview

    - run: |
          echo ${{ steps.fc.outputs.comment-id }}
          echo ${{ steps.fc.outputs.comment-body }}

    - name: Create comment
      if
      uses: peter-evans/create-or-update-comment@v1
      with:
        issue-number: ${{ github.event.pull_request.number }}
        :  
        body: |
          This PR is available as a preview [here](https://${{ env.STORAGE_NAME }}.z16.web.core.windows.net).
        reaction-type: "rocket"

