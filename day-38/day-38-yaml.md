# YAML Practice 
---

# Task 1 – Key Value Pairs

Created a file `person.yaml` describing personal information.

```yaml
name: Sri Padma Chinta
role: DevOps Learner
experience_years: 1
learning: true
```

Verification:

```
cat person.yaml
```

Checks performed:

* File looks clean
* Only **spaces used for indentation**
* **No tabs used**

---

# Task 2 – Lists in YAML

Added lists for tools and hobbies.

```yaml
name: Sri Padma Chinta
role: DevOps Learner
experience_years: 1
learning: true

tools:
  - Docker
  - Kubernetes
  - Git
  - AWS
  - Linux

hobbies: [learning new technologies, reading, exploring cloud, problem solving]
```

Two ways to write lists in YAML:

### Dash format

```
- item1
- item2
- item3
```

### Inline format

```
[item1, item2, item3]
```

---

# Task 3 – Nested Objects

Created `server.yaml` with nested configuration.

```yaml
server:
  name: web-server
  ip: 192.168.1.10
  port: 8080

database:
  host: db-server
  name: appdb
  credentials:
    user: admin
    password: password123
```

Important rule:

YAML **does not allow tabs for indentation**.

If tabs are used, validation will fail with an error like:

```
Tabs are not allowed for indentation
```

---

# Task 4 – Multi-line Strings

Added startup script examples.

```yaml
startup_script_literal: |
  echo "Starting server"
  docker pull myapp:latest
  docker run -d -p 80:80 myapp

startup_script_folded: >
  This script initializes the application
  and prepares the environment
  before the server starts.
```

When to use them:

| Style | Use Case                                                   |                                        |
| ----- | ---------------------------------------------------------- | -------------------------------------- |
| `     | `                                                          | Preserve new lines (scripts, commands) |
| `>`   | Fold text into a single line (documentation, descriptions) |                                        |

---

# Task 5 – YAML Validation

Used **yamllint** to validate YAML files.

Install:

```
sudo apt install yamllint
```

Validate:

```
yamllint person.yaml
yamllint server.yaml
```

Example error when indentation is broken:

```
Implicit keys need to be on a single line
Implicit map keys need to be followed by map values
```

Fix indentation and validate again.

---

# Task 6 – Spot the Difference

Correct block:

```yaml
name: devops
tools:
  - docker
  - kubernetes
```

Broken block:

```yaml
name: devops
tools:
- docker
  - kubernetes
```

Problem:

`kubernetes` has **incorrect indentation**.

YAML is **very strict about spacing**, so indentation must be consistent.

---

# Key YAML Concepts Learned

* Key-value pairs
* Lists (two formats)
* Nested objects
* Multi-line strings
* YAML validation
* Importance of indentation

---

# Why YAML Matters in DevOps

YAML is widely used in:

* Kubernetes manifests
* Docker Compose
* GitHub Actions pipelines
* Ansible playbooks
* CI/CD configuration

Understanding YAML structure is essential for working in **DevOps and Cloud environments**.
