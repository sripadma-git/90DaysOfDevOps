# Day 40 – Your First GitHub Actions Workflow

---

## Challenge Tasks

### Task 1: Set Up
1. Create a new **public** GitHub repository called `github-actions-practice`
2. Clone it locally
3. Create the folder structure: `.github/workflows/`


---

### Task 2: Hello Workflow
Create `.github/workflows/hello.yml` with a workflow that:
1. Triggers on every `push`
2. Has one job called `greet`
3. Runs on `ubuntu-latest`
4. Has two steps:
   - Step 1: Check out the code using `actions/checkout`
   - Step 2: Print `Hello from GitHub Actions!`

Push it. Go to the **Actions** tab on GitHub and watch it run.

**Verify:** Is it green? Click into the job and read every step.

   - Yes,it is green

  

---

### Task 3: Understand the Anatomy
- `on:`
   - Defines `when the worflow is triggered`
   - It listen for event `push`

- `jobs:`
   - Defines the jobs that the worflow will execute
   - A `workflow` can have one or multiple jobs

- `runs-on:`
   - Specifies the virtual machine(runner) env the job will use.
   - `ubuntu-latest`,`windows-latest`,`macos-latest`

- `steps:`
   - Defines the sequences of actions the job will execute
   - Steps run one after another inside the job.

- `uses:`
   - Tells Github to use a prebuilt action
   - Checkout action to clone the repo.

- `run:`
   - Executes commands directly on the runner

- `name:` (on a step)
   - Give the step a humand readable label in the Actions UI.

---

### Task 4: Add More Steps
Update `hello.yml` to also:
1. Print the current date and time
2. Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)
3. List the files in the repo
4. Print the runner's operating system

```bash
name: Hello Workflow

on: push

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Hello
        run: echo "Hello from GitHub Actions!"

      - name: Show Date
        run: date

      - name: Show Branch Name
        run: |
          echo "Branch: ${{ github.ref_name }}"

      - name: List Files
        run: ls -la

      - name: Runner OS
        run: echo "Running on $RUNNER_OS" 
    
```

---

### Task 5: Break It On Purpose
1. Add a step that runs a command that will **fail** (e.g., `exit 1` or a misspelled command)
2. Push and observe what happens in the Actions tab
3. Fix it and push again


- What does a failed pipeline look like? How do you read the error?

   - Failed pipline looks like:
      - Red ❌ in the Actions tab
      - Workflow status: Failed
      - Failed job highlighted in red
   - Read the error
      - Open the failed workflow in Actions
      - Click the failed job
      - Expand the red step
      - Scroll to the bottom
      - Look a few lines above exit code 1 — that’s the real error
---