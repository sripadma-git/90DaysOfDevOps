# Day 22 Notes – Understanding Git Workflow

## 1. Difference Between git add and git commit

git add moves changes from working directory to staging area.
git commit saves staged changes permanently to the repository history.

---

## 2. What Does the Staging Area Do?

The staging area acts as a preparation zone.
It allows selective committing of changes instead of committing everything at once.

Without staging, commits would be messy and uncontrolled.

---

## 3. What Does git log Show?

- Commit ID (SHA)
- Author
- Date
- Commit message

It shows the complete history of the repository.

---

## 4. What is the .git Folder?

.git is the core database of Git.
It stores:
- Commit objects
- Branch references
- Configuration
- Logs

If deleted, the project loses version control history.

---

## 5. Working Directory vs Staging Area vs Repository

Working Directory:
Where you edit files.

Staging Area:
Where you prepare selected changes.

Repository:
Where commits are permanently stored.


Stage and commit:

git add day-22-notes.md
git commit -m "Added Day 22 Git workflow notes"