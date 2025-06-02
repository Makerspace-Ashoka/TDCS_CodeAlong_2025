
# 🍏 Day 1 Setup: macOS Users

Welcome to the workshop! 🎉 Over the next few days, you’ll learn how to write code, build encryption systems, and use a mesh network. But first, we need to get your laptop ready.

This guide will walk you through all the setup steps — one by one. No coding experience needed. You’ve got this!

---

## 💡 What You’ll Be Installing

You’ll be installing:

* Git (used to download code from the internet)
* Python (a programming language) - Installed  via uv
* VS Code (a code editor)
* The actual files you’ll use in the workshop

---

## 🛠 Step 0: Install Homebrew

Homebrew is a tool that helps you install other tools.

### ✅ Check if Homebrew is installed

1. Open **Spotlight** (`Cmd + Space`), type **Terminal**, and press **Enter**.
2. In Terminal, type:

   ```bash
   brew --version
   ```

   * If you see something like `Homebrew 4.x.x`, great! Move on to Step 1.
   * If you get an error like `command not found`, install it with the steps below.

### 🧪 Install Homebrew

1. In Terminal, copy and paste this command and press **Enter**:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. It might ask for your **Mac password** — type it in (you won’t see anything as you type, that’s okay).
3. Once it finishes, you **MUST do the following**:

---

### 🔧 Add Homebrew to Your PATH (very important!)

After installing, Terminal might show you something like this:

```
Add Homebrew to your PATH by running:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

👆 **Copy and paste those two lines one at a time** into Terminal and press **Enter** after each.

---

### 🔁 Restart Terminal

Once you’ve done that:

1. **Close Terminal**
2. Open it again (using `Cmd + Space` → type `Terminal`)
3. Type:

   ```bash
   brew --version
   ```

   If you see the version number now — awesome, you're done with Homebrew!

---

## 🧰 Step 1: Install Git

Git helps you download and manage code.

### Check if it’s installed:

```bash
git --version
```

* ✅ If you see something like `git version 2.x.x`, you’re good!
* ❌ Otherwise, install it:

```bash
brew install git
```

---

## 🐍 Step 2: Install Python 

Python is the programming language you’ll use in the workshop. We're using `uv` to manage Python versions.

### Check your version:

```bash
uv --version
```

* ✅ If it’s **0.6 or higher**, you’re good.
* ❌ If not:

```bash
brew install uv
```

Then check again:

```bash
uv --version
```

---

## 🧑‍🎨 Step 3: Install VS Code

VS Code is where you’ll write and run your code.

### Check if it’s installed:

```bash
code --version
```

* ✅ If it shows a version, skip to Step 4.
* ❌ If not:

```bash
brew install --cask visual-studio-code
```

---

## 📁 Step 4: Get the Workshop Files

###  A: Use Git

```bash
cd ~/Desktop && git clone https://github.com/Makerspace-Ashoka/TDCS_CodeAlong_2025.git
```




## 📂 Step 5: Open the Files in VS Code

1. In Terminal, go to your project folder:

   ```bash
   cd ~/Desktop/TDCS_CodeAlong_2025/Notebooks
   uv sync
   code .
   ```
2. This opens your project in VS Code.

---

## ✅ You’re Done!

That’s it — your laptop is ready for the workshop! 🎉

If something doesn’t work, don’t worry. Just ask your instructor — they’re happy to help!

---

