# Day 23 – Git Branching & GitHub Notes

Task 1: Understanding Branches:

1.What is a branch in Git? 
=> A branch is a movable pointer to a commit.
It allows independent development from the main codebase.

2. Why use branches instead of committing everything to main?
=>Branches isolate work.
They prevent unstable code from breaking production.
They allow parallel feature development.

3.What is HEAD in Git?
=> HEAD is a pointer to the current branch.
It tells Git which commit you are currently working on.

4.What happens to your files when you switch branches?
=>Git changes your working directory files
to match the snapshot of that branch’s latest commit.
Uncommitted changes may prevent switching.

---

Task 2: Branching Commands — Hands-On
In your devops-git-practice repo, perform the following:

1.List all branches in your repo: git branch
2.Create a new branch called feature-1:git branch feature-1
3.Switch to feature-1: git checkout feature-1
4.Create a new branch and switch to it in a single command — call it feature-2. : git checkout -b feature-2
5.Try using git switch to move between branches — how is it different from git checkout? 
git checkout → Old command (does multiple things: switch branches, restore files)

git switch → Only switches branches (cleaner & safer)

6.Make a commit on feature-1 that does not exist on main: git switch feature-1
7.Switch back to main — verify that the commit from feature-1 is not there.: git switch main
8.Delete a branch you no longer need.: git branch -d feature-2
9.Add all branching commands to your git-commands.md.

---

Task 3 – Push to GitHub
1.Create a new repository on GitHub (do NOT initialize it with a README)
2.Connect your local devops-git-practice repo to the GitHub remote.
3.Push your main branch to GitHub : git push -u origin main
4.Push feature-1 branch to GitHub : git push -u origin feature-1
5.Verify both branches are visible on GitHub
6.Answer in your notes: What is the difference between origin and upstream?
origin : The default remote name for the repository you cloned or created.
upstream : The original repository you forked, or the "main" source project.

---

Task 4 – Pull from GitHub
1.Make a change to a file directly on GitHub (use the GitHub editor) 
2.Pull that change to your local repo :git pull origin main
3.Answer in your notes: What is the difference between git fetch and git pull?
=> git fetch : Downloads changes
git pull : Downloads and merges changes automatically.

---

Task 5 – Clone vs Fork
1.Clone any public repository from GitHub to your local machine
2.Fork the same repository on GitHub, then clone your fork
3.Answer in your notes:
What is the difference between clone and fork?
When would you clone vs fork?
=> Fork:On a remote hosting platform
Clone:On your local machine
After forking, how do you keep your fork in sync with the original repo?
=>To keep a forked repository in sync with the original (upstream) repo, you can use the "Sync fork" button on GitHub for automatic updates or configure an upstream remote locally using git.