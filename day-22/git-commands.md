Day 22 – Introduction to Git: Your First Repository

Task 1: Install and Configure Git.
1.Verify Git is installed on your machine : git --version
2.Set up your Git identity — name and email :
git config --global user.name "<your username>"
git config --global user.email "<your email>"
3.Verify your configuration:
git config --list

---

Task 2: Create Your Git Project.
1. Create a new folder called devops-git-practice.
2.Initialize it as a Git repository : git init
3.Check the status — read and understand what Git is telling you : git status 
4.Explore the hidden .git/ directory — look at what's inside : ls -a

---

Task 3: Create Your Git Commands Reference.
1. Create a file called git-commands.md inside the  DevOps repo. : touch git-commands.md
2.Add the Git commands you've used so far, organized by category:
- Setup & Config
- Basic Workflow
- Viewing Changes

---

Task 4: Stage and Commit.
1. Stage your file : git add git-commands.md
2. Check What’s Staged :
git status
3.Commit: git commit -m "Initial commit: Added Git commands reference file".
4.View History : git log

---

Task 5: Build Commit History
1.Edit git-commands.md — add more commands as you discover them.
2.Check what changed since your last commit.
3.Stage and commit again with a different, descriptive message.
4.Repeat this process at least 3 times so you have multiple commits in your history.
5.View the full history in a compact format.

---

Task 6: Understand the Git Workflow

Answer these questions in your own words (add them to a day-22-notes.md file):

1.What is the difference between git add and git commit?
2.What does the staging area do? Why doesn't Git just commit directly?
3.What information does git log show you?
4.What is the .git/ folder and what happens if you delete it?
5.What is the difference between a working directory, staging area, and repository?