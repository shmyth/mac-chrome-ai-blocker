#!/bin/bash

# ==============================================================================
# Script Name: chrome-ai-purifier.sh
# Description: Physically disable Chrome's built-in AI features and purge local LLM files (macOS specific)
# ==============================================================================

echo "--- Initiating Chrome AI Purge Operation ---"

# 1. Check if the Gemini Nano model file (weights.bin) exists
# Note: weights.bin is the core weight file of the ~4GB local LLM silently downloaded by Chrome in the background.
MODEL_FILE=$(find ~/Library/Application\ Support/Google/Chrome/ -name "weights.bin" 2>/dev/null)

if [ -n "$MODEL_FILE" ]; then
    echo "[!] Local AI model file detected: $MODEL_FILE"
    echo "[*] Executing physical purge, deleting model storage directory to free up space..."
    # Note: Completely remove the folder storing the local large language model.
    rm -rf ~/Library/Application\ Support/Google/Chrome/*/*/OptGuideOnDeviceModel/
    echo "[+] Model directory forcefully purged."
else
    echo "[+] No weights.bin model file found in the system. Your drive is clean."
fi

# 2. Inject Enterprise-Level Management Policies (Disable Cloud and On-Device GenAI features)
echo "[*] Injecting underlying management policies to sever all AI probes..."

# Note: Disable Gemini's ability to execute actions directly on web pages (e.g., auto-filling, clicking buttons).
defaults write com.google.Chrome GeminiActOnWebSettings -int 2

# Note: Disable Chrome from uploading current page content (e.g., text, screenshots) to Cloud AI as context.
defaults write com.google.Chrome SearchContentSharingSettings -int 2

# Note: Disable the "Help me write" AI writing assistant in context menus.
defaults write com.google.Chrome HelpMeWriteSettings -int 2

# Note: Disable the "Help me read" AI summarization and extraction feature.
defaults write com.google.Chrome HelpMeReadSettings -int 2

# Note: Disable AI-generated custom browser themes and wallpapers via prompts.
defaults write com.google.Chrome CreateThemesSettings -int 2

# Note: Disable semantic AI history search (prevents AI from building vector indexes of your browsing history).
defaults write com.google.Chrome HistorySearchSettings -int 2

# Note: Disable AI-driven tab categorization and automatic grouping.
defaults write com.google.Chrome TabOrganizerSettings -int 2

# Note: Disable AI tab comparison (used for comparing products or info across different pages).
defaults write com.google.Chrome TabCompareSettings -int 2

# Note: Disable AI error analysis and coding assistance in F12 Developer Tools.
defaults write com.google.Chrome DevToolsGenAiSettings -int 2

# Note: Disable Cloud AI prediction and takeover of web form autofill.
defaults write com.google.Chrome AutofillPredictionSettings -int 2

# Note: Physically sever the background silent download channel for the local foundational model (Gemini Nano) (1=Disable).
defaults write com.google.Chrome GenAILocalFoundationalModelSettings -int 1

# Note: Completely hide all Gemini sidebars and interactive UI elements in the browser (1=Disable).
defaults write com.google.Chrome GeminiSettings -int 1

# Note: Strip the "AI search mode" entry from the address bar (Omnibox) (1=Disable).
defaults write com.google.Chrome AIModeSettings -int 1

# Note: Disable the AI-driven automated password change suggestion feature (1=Disable).
defaults write com.google.Chrome AutomatedPasswordChangeSettings -int 1

echo "[+] Policy injection complete. All AI channels forcefully locked to Disabled state."

# 3. Force restart the browser to apply policies
echo "[*] Restarting Google Chrome to apply configurations..."
killall "Google Chrome" 2>/dev/null

echo "--- Operation complete. Your Chrome has been restored to a pure state. ---"
