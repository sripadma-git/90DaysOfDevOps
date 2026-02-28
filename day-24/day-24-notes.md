## Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick  

Task 1: Git Merge — Hands-On 

1.Create a new branch feature-login from main, add a couple of commits to it: git checkout –b feature-login. 

 2.Switch back to main and merge feature-login into main : git switch main 

3.Observe the merge — did Git do a fast-forward merge or a merge commit? :  

The target branch (main) has no new commits after the feature branch was created. 

Git simply moves the branch pointer forward. 

4.Now create another branch feature-signup, add commits to it — but also add a commit to main before merging : git checkout –b feature-signup and do git commit –m “added signup page” and then do git merge feature-signup 

5.Merge feature-signup into main — what happens this time? Git performed a Fast-Forward Merge. 

6.Answer in your notes: What is a fast-forward merge? When does Git create a merge commit instead? What is a merge conflict? (try creating one intentionally by editing the same line in both branches) 

What is a Fast-Forward Merge? 

A fast-forward merge occurs when: 

The target branch (e.g., main) has not received any new commits since the feature branch was created. 

The feature branch is simply ahead of the target branch. 

There is no divergence in history. 

When does Git create a merge commit instead? : git creates a three-way (scenario,Action, Purpose) 

What is a Merge Conflict? 

A merge conflict occurs when Git cannot automatically combine changes from two branches because the same part of a file was modified differently in each branch. 

In simple terms:Git does not know which change to keep. 

---

Task 2: Git Rebase — Hands-On 

 1.Create a branch feature-dashboard from main, add 2-3 commits : git checkout –b feature-dashboard and commit changes 2-3. 

2.While on main, add a new commit (so main moves ahead)  

3.Switch to feature-dashboard and rebase it onto main: switch feature-dashboard  

4.Observe your git log --oneline --graph --all — how does the history look compared to a merge?  

5.Answer in your notes:  

What does rebase actually do to your commits? Rebase rewrites history.  

It takes your branch’s commits 

Temporarily removes them 

Moves your branch pointer to the latest commit of the target branch 

Replays your commits on top 

Creates new commits with new hashes 

How is the history different from a merge?  

Merge : Preserves full branch structure , Non-linear history , Shows exact branch relationships 

Rebase : No merge commit , Clean, straight timeline, Looks like feature was built after latest main. 

Why should you never rebase commits that have been pushed and shared with others? When would you use rebase vs merge? 

Because rebase changes commit hashes.If you rebase a shared branch: 

Your history changes 

Teammates still have old commit hashes 

Git histories diverge 

You must force push (git push --force) 

This can overwrite others’ work 

---

TASK 3 — Squash Merge 

1. Create a branch feature-profile, add 4-5 small commits (typo fix, formatting, etc.) : git checkout –b feature-profile  

echo "Profile page" > profile.txt ,git add profile.txt , git commit -m "Add profile page" , echo "Fix typo" >> profile.txt , git add profile.txt ,git commit -m "Fix typo" ,echo "Formatting fix" >> profile.txt ,git add profile.txt , git commit -m "Formatting fix".  

2. Merge it into main using --squash — what happens? Squash merge: 

git merge --squash feature-profile 
git commit -m "Feature profile complete (squashed)" 

3.Check git log — how many commits were added to main? : git log --oneline 

4.Now create another branch feature-settings, add a few commits 

 5.Merge it into main without --squash (regular merge) — compare the history  

6.Answer in your notes: What does squash merging do?  

Takes all commits from a feature branch 

Combines them into one single commit 

Applies that single commit to the target branch 

Does NOT preserve individual commit history of that branch 

When would you use squash merge vs regular merge?  

Squash merge:  

Feature branch has many small commits 

Commits like “typo fix”, “format change”, “debug log” 

You want clean, readable main history 

Regular merge:  

Individual commits are meaningful 

Long-running features 

Team collaboration 

What is the trade-off of squashing? => clean history , easy to read main branch, one logical commit per feature. 

---

Task 4: Git Stash — Hands-On  

1.Start making changes to a file but do not commit : create a temp file dont commit it.  
2.Now imagine you need to urgently switch to another branch — try switching. What happens? git checkout feature-dashboard 

3.Use git stash to save your work-in-progress : git stash 

4.Switch to another branch, do some work, : git checkout feature-dashboard 

5.switch back Apply your stashed changes using: git stash pop  

6.Try stashing multiple times and list all stashes : git stash list 

7.Try applying a specific stash from the list : git stash apply stash@{1} 

8.Answer in your notes: What is the difference between git stash pop and git stash apply? When would you use stash in a real-world workflow? 

pop → apply + delete stash 

apply → apply only (keeps stash) 

--- 

TASK 5 — Cherry Pick :  

Create a branch feature-hotfix, make 3 commits with different changes Switch to main Cherry-pick only the second commit from feature-hotfix onto main Verify with git log that only that one commit was applied Answer in your notes: What does cherry-pick do? When would you use cherry-pick in a real project? What can go wrong with cherry-picking? 

Create feature-hotfix : git checkout -b feature-hotfix 

Make 3 commits:  

Cherry-pick only second commit 

First get commit hash: 

git log --oneline 

Copy hash of “Hotfix commit 2”. 

Switch to main: 

git checkout main 

Cherry-pick: 

git cherry-pick <commit-hash> 

Verify: 

git log --oneline 

You’ll see only that commit applied. 