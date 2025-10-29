# Monster Hub

**Monster Hub** — a user interface (UI) and modular framework for Roblox, designed to be used in development/private environments (Roblox Studio or local executors). The project aims to provide a **central hub** for UI components, demo modules, and developer utilities — **it does not encourage or include exploit instructions**.

---

## 📌 Short Introduction
Monster Hub focuses on:

- A modern sidebar UI (built with **OrionLib**).
- A modular tab system: **About**, **Supa Tech**, **Settings**.
- A module-friendly architecture so you can add per-game or per-feature modules easily.
- Supporting development, debugging, and local testing workflows.

> **Important:** Any feature that interferes with other players' experience, breaks rules, or performs exploits is strictly forbidden. This README describes the hub as a UI and modular framework only and contains no exploit code.

---

## 🔍 Key Features

- Sidebar UI with professional look (OrionLib integration).
- Buttons / Toggles / Dropdowns with English notifications.
- "Copy Discord" button for quick contact sharing.
- Theme selector (Dark / Light / Amethyst) — includes a small animation when opening the Settings tab.
- Config saving (SaveConfig) to persist user settings.
- Clean project layout: `src/ui.lua`, `src/modules/*`, `assets/*`.

---

## 🎮 Module Status (Overview)

> The modules below are **placeholders** for legal, debugging, or demo features. They do not contain exploit instructions.

- **TSB** — **ON** (active: development utilities / demo)
- **BloxFruits** — *Coming Soon* (placeholder)
- **Rivals** — *Coming Soon* (placeholder)
- Other game modules can be added later under `src/modules/`

---

## 🚀 Installation & Usage (for GitHub)

### Requirements

- Roblox Studio (recommended to use Play Solo for testing) or a local executor environment (for personal testing only).
- Internet connection if you load OrionLib via `loadstring` (or you may embed the Orion source directly).

### Quick Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/monster-hub.git
   ```
2. Open Roblox Studio and create a `LocalScript` inside `StarterGui` (for local testing).
3. Paste the contents of `src/ui.lua` into the `LocalScript`, or require the module if you use a modular layout.
4. Run Play Solo → the UI should appear.

> If you use a local executor, paste `src/ui.lua` into the executor and run it locally (for personal development/testing only).

---

## 🧭 Suggested Project Structure

```
/MonsterHub
  ├─ README.md
  ├─ src/
  │   ├─ ui.lua            # main UI script (Orion integration)
  │   ├─ modules/
  │   │   ├─ tsb.lua       # TSB module (dev utilities)
  │   │   ├─ bloxfruits.lua (placeholder)
  │   │   └─ rivals.lua (placeholder)
  ├─ assets/
  │   └─ icons/
  └─ LICENSE
```

---

## 🛡️ Ethics & Legal Notice

- **No exploits allowed.** All modules should be safe and intended for learning, debugging, UI features, or development.
- Users must comply with Roblox's Terms of Service and local laws.
- If a module is found to contain harmful code, remove it immediately and report the issue.

---

## 🤝 Contributing

We welcome PRs and issues, but please follow these rules:

- Do **not** submit exploit code, bypasses, or destructive tools.
- Describe the purpose of your module and how to test it.
- Include short documentation for new modules.

---

## 🧾 Changelog

- **v0.3** — Added notifications for toggles & copy actions; Settings animation.
- **v0.2** — Sidebar UI improvements; About / Supa Tech / Settings tabs completed.
- **v0.1** — Initial release: UI skeleton + placeholder modules.

---

## 📞 Contact

Discord: http://discord.gg/ubJ6FP6t2n

---

## 📜 License

Default: use the **MIT License** (or choose the license you prefer). Example snippet:

```
MIT License

Copyright (c) 2025 Monster Hub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

If you want, I can:
- Add a bilingual version (English + Vietnamese)
- Export the README as a downloadable file for your repo
- Generate safe example module templates under `src/modules/`
