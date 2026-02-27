const issueTitle = context.payload.issue.title.trim();
const isSingleWord = /^\S+$/.test(issueTitle);

if (isSingleWord) {
const issueNumber = context.payload.issue.number;
const repo = context.repo.repo;

// Close the issue and add the invalid label
github.rest.issues.update({
owner: context.repo.owner,
repo: repo,
issue_number: issueNumber,
labels: ['invalid'],
state: 'closed'
});

// Comment on the issue
await github.rest.issues.createComment({
owner: context.repo.owner,
repo: repo,
issue_number: issueNumber,
body: `This issue may have been opened accidentally. I'm going to close it now, but feel free to open a new issue with a more descriptive title.`
});
}