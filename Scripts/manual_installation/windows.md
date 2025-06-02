

# 🧑‍💻 Day 1 Setup: Windows Users

Welcome to the workshop! 🎉 Over the next few days, you'll be learning how to write code, build encryption systems, and use a mesh network. But first — we need to set up your laptop!

This guide will help you install everything you need **step-by-step**. No prior coding experience needed — just follow along!

---

## 💡 What You’ll Be Installing

You’ll be installing:

* Git (used to download code from the internet)
* Python (a programming language)
* VS Code (a code editor)
* Some helper tools (like Jupyter)
* The actual files you’ll use in the workshop

---

## 🛠 Step 0: Check if You Have `winget`

`winget` is a tool that helps us install other tools. Let’s see if you have it:

1. Click the **Start Menu** and search for **Command Prompt**.
2. Open it.
3. Type this and press **Enter**:

   ```
   where winget
   ```

   * ✅ If you see something like `C:\Windows\System32\winget.exe`, you're good! Skip to Step 1.
   * ❌ If you get an error, follow the steps below.

### If `winget` is missing:

1. Go to this link:
   👉 [Microsoft App Installer](https://apps.microsoft.com/store/detail/app-installer/9NBLGGH4NNS1)
2. Click **Install**.
3. After installing, open Command Prompt again and type:

   ```
   winget --version
   ```

   If it shows something like `v1.x.x`, you're good to go!

---

## 🧰 Step 1: Install Git

Git helps you download and manage code.

### Check if you already have Git:

1. Open Command Prompt.
2. Type:

   ```
   git --version
   ```

   * ✅ If it shows a version number (like `git version 2.43.0`), skip to Step 2.
   * ❌ Otherwise, install Git:

### Install Git with winget:

```
winget install --id Git.Git -e --source winget
```

After it finishes, close Command Prompt, open it again, and run:

```
git --version
```

---

## 🐍 Step 2: Install Python

Python is the main programming language we’ll use.

### Check if Python is already installed:

1. Open Command Prompt.
2. Type:

   ```
   python --version
   ```

   or

   ```
   python3 --version
   ```

   * ✅ If you see a version **3.10 or higher**, skip to Step 3.
   * ❌ If not, install it:

### Install Python with winget:

```
winget install --accept-package-agreements --accept-source-agreements  Python.Python.3.12
```

Then check again with:

```
python --version
```

---

## 🧑‍🎨 Step 3: Install VS Code

VS Code is the app where you’ll write and run your code.

### Check if VS Code is already installed:

1. Open Command Prompt.
2. Type:

   ```
   code --version
   ```

   * ✅ If you see a version number like `1.89.1`, skip to Step 4.
   * ❌ If not, install it:

### Install VS Code with winget:

```
winget install --id Microsoft.VisualStudioCode --exact
```

Check again with:

```
code --version
```

---

## 📁 Step 4: Get the Workshop Files

Now you need to download the files you’ll be working on.

### Option A: If you know Git (or followed Step 1)

Open Command Prompt and type:

```
git clone https://github.com/YOUR-LINK-HERE.git
```

(Replace with the actual GitHub link provided by your instructor.)

### Option B: Manual Download

1. Go to the GitHub link your instructor gave you.
2. Click the green **Code** button → then click **Download ZIP**.
3. Find the `.zip` file in your **Downloads** folder and right-click → **Extract All**.

---

## 📂 Step 5: Open the Code in VS Code

Once the folder is ready:

1. Open **PowerShell** (search for it in the Start menu).
2. Type:

   ```powershell
   cd Documents
   cd [folder name you extracted]
   code .
   ```
3. This will open the project in VS Code.

---

## ✅ You’re Done!

If everything installed properly, you're all set! 🎉 You can now start working on the exercises.

If **something doesn’t work**, don’t panic — just ask an instructor for help. That’s what we’re here for.

---

Let me know if you'd like this turned into a printable checklist or want a version with screenshots!
