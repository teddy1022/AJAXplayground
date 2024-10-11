# 專案概覽

- 這個專案是一個基於 Spring Boot 框架開發的網頁應用程式，包含猜數字遊戲、樂透號碼生成的功能，旨在提供用戶有趣的互動體驗。
- 默認有一個帳號為“Ted”，密碼為“000000”，該帳號默認有8次Guess Game的遊玩記錄

## 主要功能

### 1. 使用者註冊和登入
- 支援標準註冊和登入頁面，也可切換為 AJAX 方式實現的登入功能，提升用戶體驗。
- 使用 Filter 進行登入攔截，保護需要驗證的頁面。

### 2. 猜數字遊戲
- 用戶可以參與猜數字遊戲，每局有固定的猜測次數限制。
- 遊戲結束後，會將結果記錄到資料庫中，每個用戶都可以查詢自己的遊戲歷史。
- 遊戲記錄包含每次遊玩的時間、結果（贏或輸），並顯示在歷史頁面中。

### 3. 樂透號碼生成
- 用戶可以生成樂透號碼，支援排除特定數字的功能。
- 生成結果以分頁形式顯示，每頁顯示最多 8 組樂透號碼，並有頁面導航功能。
- 可透過輸入框直接跳轉到特定頁數，增強使用者操作的靈活性。

## 技術詳述

### 1. 所使用技術
- **後端框架**：Spring Boot
- **數據庫**：H2 Database，簡易的內嵌式資料庫
- **前端框架**：Bootstrap，用於頁面樣式的設計
- **依賴管理**：Maven

### 2. 安全性
- 使用 Spring Filter 進行會話管理與頁面攔截，未登入的用戶無法訪問保護的資源。

### 3. 模組架構
- **控制層（Controller）**：負責處理頁面的跳轉和用戶請求，包括註冊、登入、遊戲頁面和歷史頁面。
- **服務層（Service）**：包含核心業務邏輯，例如猜數字遊戲邏輯和樂透號碼生成邏輯。
- **資料訪問層（Repository）**：負責與 H2 Database 進行交互，保存和查詢用戶和遊戲記錄。

## 當前進展
- 完成了基本的功能，包括註冊、登入、遊戲邏輯、遊戲記錄存儲等。
- 增加用戶登出確認彈窗的改善，避免意外登出。
- 增強猜數字遊戲，猜數了會公佈正確結果，另外增加了歷史頁面的展示效果，贏的遊戲結果以淺綠色背景顯示，輸的則為淺紅色。


