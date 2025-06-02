
<div align="center">
  <h1>🧠 YSP TDCS Repository</h1>
  <p>👋 Welcome to YSP 2025!</p>
  <p>This guide will help you install the tools you'll need for class exercises over the next seven days.</p>
</div>

---

## 📅 Day 1: June 3rd, 2025

This setup guide will walk you through installing essential applications. If you get stuck, don’t hesitate to reach out to your instructors.

### 🔧 What to Do

1. Identify your computer’s operating system (Windows or macOS).
2. Follow the corresponding steps below.
3. If something doesn’t work, try a manual installation using the [checklist](https://github.com/Makerspace-Ashoka/YSP_TDCS_2025/blob/init_setup_edition_2/Scripts/checklist.md).

---

## 🪟 Windows Setup

Follow these steps carefully:

### 1. Copy the Setup Code

Click the **copy icon** on the top right corner of the code block below:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { iwr -useb 'https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/refs/heads/init_setup_edition_2/Scripts/win/script_notebook.ps1' | iex }"
```

### 2. Open PowerShell

* Press the **Windows** key and type `powershell`.
* Hit **Enter**.

### 3. Run the Script

* Paste the copied code into PowerShell using **Ctrl+V**.
* Press **Enter**.

If a terminal window opens and Visual Studio Code launches at any point — you're all set! 🎉
Let your instructor know you're done.

---

## 🍏 macOS Setup

Follow these instructions step by step:

> 💡 **Tip:** Click the **copy icon** to easily copy each code snippet.

### 1. Open Terminal

* Press **Cmd + Space**.
* Type `terminal`, then press **Enter**.

### 2. Install Xcode Command Line Tools

```bash
xcode-select --install
```

### 3. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 4. Restart Terminal

* Close the Terminal window.
* Reopen it to apply changes.

### 5. Run the YSP Install Script

```bash
bash -c "cd $(mktemp -d) && curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/refs/heads/mac-script-daily/Scripts/macos/script_notebook.sh -o run.sh && curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/refs/heads/mac-script-daily/Scripts/macos/Brewfile -o Brewfile && bash run.sh && cd -"
```

If Visual Studio Code opens — success! 🎉
Let your instructor know you’re done.

---

## ❓ Need Help?

Don’t worry! Ask your instructor or come by during office hours — they’ve got you.

---

Let me know if you’d like this in a different format (e.g., PDF or printed handout style).
