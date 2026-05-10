# mac-chrome-ai-blocker
macOS injection script to hard-disable Chrome's built-in AI module

---

# 🚀 One-Line Execution

The most elegant and "geeky" way to secure your browser. No need to download files manually. Just open your macOS **Terminal**, paste the following command, and hit Enter to execute the purge directly in memory:

```bash
curl -fsSL [https://raw.githubusercontent.com/shmyth/mac-chrome-ai-blocker/refs/heads/main/chrome-ai-purifier.sh](https://raw.githubusercontent.com/shmyth/mac-chrome-ai-blocker/refs/heads/main/chrome-ai-purifier.sh) | bash
```


# 🛡️ Transparency Note:

Never trust a black box. Before piping any script to bash, it is highly recommended to open the raw URL above in your browser to inspect the code. This script is fully open-source with detailed comments for every command, ensuring you maintain 100% granular control over your system.

---

### Why -int 2 instead of -int 1?
Many scripts online mistakenly use -int 1 for cloud features. According to the official Chrome Enterprise Policy API, 1 means ALLOWED_WITHOUT_LOGGING (the AI still runs and processes your data, Google just promises not to use it for model training). To completely and physically block the AI features from running at all, you must use -int 2 (DISABLED).
