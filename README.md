
<div align="center">
  <h1>🧠 YSP TDCS Repository</h1>
  <p>👋 Welcome to YSP 2025!</p>
  <p>This guide will help you install the tools you'll need for class exercises over the next seven days.</p>
</div>

---
## 🗓️ Day 2: June 4th, 2025

For Day 2, we will be updating the already cloned repository and moving forward with the python exercises.

### 🔧 What to Do
1. Open your terminal or command prompt.
3. Copy the following command based on your operating system:

    If you are using Windows 🪟:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -Command "& { iwr -useb 'https://raw.githubusercontent.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/refs/heads/main/Scripts/win/script_notebook.ps1' | iex }"
   ```

   Or if you are using macOS 🍏:
   ```bash
   bash -c "cd $(mktemp -d) && curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/refs/heads/main/Scripts/macos/script_notebook.sh -o run.sh && curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/refs/heads/main/Scripts/macos/Brewfile -o Brewfile && bash run.sh && cd -"
    ```
4. Paste the command and hit **Enter**.
5. Wait for the process to complete. This will update your local repository with the latest changes.
6. Once done, you can start working on the Python exercises. 


---

## 📅 Day 1: June 3rd, 2025

This setup guide will walk you through installing essential applications. If you get stuck, don’t hesitate to reach out to your instructors.

### 🔧 What to Do

1. Identify your computer’s operating system (Windows or macOS).
2. Follow the corresponding steps below.
3. If something doesn’t work, try a manual installation using the [checklist](https://github.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/blob/init_setup_edition_2/Scripts/checklist.md).

---

## 🪟 Windows Setup

Follow these steps carefully:

### 1. Copy the Setup Code

Click the **copy icon** on the top right corner of the code block below:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "& { iwr -useb 'https://raw.githubusercontent.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/refs/heads/main/Scripts/win/script_notebook.ps1' | iex }"
```

### 2. Open PowerShell

* Press the **Windows** key and type `powershell`.
* Hit **Enter**.

### 3. Run the Script

* Paste the copied code into PowerShell using **Ctrl+V**.
* Press **Enter**.

If a terminal window opens and Visual Studio Code launches at any point — you're all set! 🎉
Let your instructor know you're done.

#### Alternatively, you can follow the manual setup process: [Click Here](https://github.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/blob/main/Scripts/manual_installation/windows.md).
---

## 🍏 macOS Setup

Follow these instructions step by step:

> 💡 **Tip:** Click the **copy icon** to easily copy each code snippet.

### 1. Copy the Setup Code

```bash
bash -c "cd $(mktemp -d) && curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/refs/heads/main/Scripts/macos/script_notebook.sh -o run.sh && curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/refs/heads/main/Scripts/macos/Brewfile -o Brewfile && bash run.sh && cd -"
```

### 2. Open Terminal

* Press **Cmd + Space**.
* Type `terminal`, then press **Enter**.


### 2. Paste & Run the YSP Install Script
* Paste the copied code into Terminal using **Cmd + V**.
* Press **Enter**.
* You may be prompted to enter your password multiple times. Type it in (you won’t see it) and press **Enter**.


If Visual Studio Code opens — success! 🎉
Let your instructor know you’re done.

#### Alternatively, you can follow the manual setup process: [Click Here](https://github.com/Makerspace-Ashoka/TDCS_CodeAlong_2025/blob/main/Scripts/manual_installation/macOS.md).

---

## ❓ Need Help?


Don’t worry! Ask your instructor or come by during office hours — they’ve got you.
---

Let me know if you’d like this in a different format (e.g., PDF or printed handout style).
