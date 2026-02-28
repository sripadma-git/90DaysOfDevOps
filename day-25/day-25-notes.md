Day 25  - Git Reset vs Revert & Branching Strategies 

Task 1: Git Reset  

Make 3 commits in your practice repo (commit A, B, C) Use git reset --soft to go back one commit — what happens to the changes? Re-commit, then use git reset --mixed to go back one commit — what happens now? Re-commit, then use git reset --hard to go back one commit — what happens this time? Answer in your notes: What is the difference between --soft, --mixed, and --hard? Which one is destructive and why? When would you use each one? Should you ever use git reset on commits that are already pushed? 

=> Make create 3 commits: 
1.echo "A" > reset.txt , git add reset.txt , git commit -m "Commit A". 

2. echo "B" >> reset.txt , git add reset.txt ,git commit -m "Commit B". 

3. echo "C" >> reset.txt , git add reset.txt , commit -m "Commit C". 

Check: git log --oneline 

You should see: 

Commit C 
Commit B 
Commit A 

Run: git reset --soft HEAD~1 

Now check:git status 

Verify:git log –oneline 

You should now only see: 

Commit B 
Commit A 

But: git diff –cached 

Shows Line C is staged. 

Recommit C: git commit -m "Commit C again" 

git reset --mixed (default) 

Run:git reset HEAD~1 

Check:git status 

--mixed moves HEAD and unstages changes. 

Recommit Again 

git add . 
git commit -m "Commit C final" 
git reset –hard  

Run:git reset --hard HEAD~1 

Check:git log --oneline 
cat reset-lab.txt 

---

TASK 2 — Git Revert  

Create 3 Commits X, Y, Z  

Check: git log –oneline 

Revert Middle Commit (Y) :Find commit hash of Y: 

git log –oneline 

Copy hash of Commit Y. 

Now:git revert <hash-of-Y> 

Check History: git log –oneline 

You will see: 

Revert "Commit Y" 
Commit Z 
Commit Y 
Commit X 

If it does not work try this : Mark Conflict as Resolved 

git add revert-lab.txt 

Step 5 — Continue Revert 

git revert --continue 

Now check:git log –oneline 
If you ever get stuck like this, you have 3 options: 

Continue (after fixing conflict): git revert --continue 

Cancel revert: git revert --abort 

Skip this revert: git revert --skip 

---

TASK 3 — Dangerous Scenario Simulation 

Let’s simulate pushing. 

Pretend you pushed. 

Now do: git reset --hard HEAD~1 

Then: git push origin day25-lab 

You’ll get rejection. 

To force: git push --force 

⚠️ This rewrites history. 
⚠️ This can break teammates’ clones. 

This is why reset is dangerous after push. 

---

TASK 4 — Branching Strategy Simulation: 
Simulate GitHub Flow 

Create feature branch: git checkout -b feature-payment 
echo "Payment feature" > payment.txt 
git add . 
git commit -m "Add payment feature" 

Merge to main: 
git checkout main 
git merge feature-payment 

Simulate GitFlow 

Create develop branch: 
git checkout -b develop 
Create feature branch from develop: 
git checkout -b feature-auth develop 

After commits: 
git checkout develop 
git merge feature-auth 

Then release branch: 
git checkout -b release-v1 develop 

Then merge release to main: 
git checkout main 
git merge release-v1 

This is structured release flow. 