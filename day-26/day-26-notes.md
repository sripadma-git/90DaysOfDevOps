Day 26 – GitHub CLI (gh) 

---

Task 1: Install GitHub CLI 

Task 1: Install and Authenticate Install the GitHub CLI on your machine Authenticate with your GitHub account Verify you're logged in and check which account is active Answer in your notes: What authentication methods does gh support? 

Windows(power shell/git bash) : winget install –id GitHub.cli 

Authenticate with GitHub : gt auth login  

Verify authentication : gt auth status 

---

Task 2 – Working With Repositories:  

Create a new GitHub repo directly from the terminal — make it public with a README Clone a repo using gh instead of git clone View details of one of your repos from the terminal List all your repositories Open a repo in your browser directly from the terminal Delete the test repo you created (be careful!) 

1.Create a public Repo with README :  

gh repo create day25-gh-tes \ 

 -- public \  

-- add-readme \ 

-- clone 

This: Creates repo , Makes it public, Adds README, Clones it locally 

 Check: cd day26-gh-test , git status 

2.Clone a Repo using gh : gh repo clone <your-username>/<repo-name> 

3.View repo Details : gh repo view and with more details: gh repo view –web 

4.List All your repositories: gh repo list and limit output : gh repo list --limit 20 

5.open Repo in Browser : gh repo view - - web 

6. Delete Test Repo : gh repo delete day26-gh-test 

---

Task 3 – issues:  

Move inside any existing repo:cd your-repo 

1.Create an Issue: gh issue create \ 

  --title "Fix login bug" \ 

  --body "Users cannot login after password reset." \ 

  --label "bug" 

2. List Open Issues: gh issue list 

3. View Specific Issue: gh issue view 1 

4. Close an Issue : gh issue close 1 

---

Task 4 – Pull Requests :  

1. Create Branch + Change + PR :  

git checkout -b feature-readme-update 

echo "New update" >> README.md 

git add README.md 

git commit -m "Updated README" 

git push origin feature-readme-update 

Now create PR: gh pr create --fill 

2. List Open PRs : gh pr list 

3. view PR Details : gh pr view 1 

4. Merge PR from Terminal : gh pr merge 1 –merge  or gh pr merge 1 –squash or gh pr merge 1 –rebase. 

---

Task 5 – GitHub Actions: 

List workflow Runs : gh run list --repo actions/checkout 

View Specific Run : gh run view <run-id> --repo actions/checkout 

---

Task 6 – Useful gh Tricks  

gh api : gh api user  ( List your repos via API: gh api user/repos) 

gh gist : gh gist create file.txt (List gists: gh gist list) 

gh release: gh release create v1.0.0 --title "Version 1.0.0" --notes "Initial release" 

Gh alias : (Create shortcut:  gh alias set co 'pr checkout')  

Search Repositories : gh search repos docker --limit 5 

 