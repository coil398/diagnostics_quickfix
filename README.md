# diagnostics_quickfix.nvim

現在バッファの LSP diagnostics を quickfix に自動同期する Neovim プラグインです。

## 機能

- `DiagnosticChanged` と `BufEnter` で quickfix を更新
- 現在バッファの diagnostics のみを対象に同期
- 複数行の diagnostic メッセージを 1 行に正規化
- diagnostics があるときは quickfix を開く
- diagnostics が空のときは quickfix を閉じる
- quickfix バッファ自身は更新対象から除外
- デバウンスによる高頻度更新の抑制
- severity（ERROR → WARN → INFO → HINT）順でソート

## 要件

- Neovim 0.9 以上

## インストール（lazy.nvim）

```lua
{
  "coil398/diagnostics_quickfix",
}
```

## 設定

すべての設定は任意です。デフォルト値のまま動作します。

```lua
-- 表示件数の上限（デフォルト: 無制限）
vim.g.diagnostics_quickfix_max_items = 5

-- quickfix ウィンドウの最大高さ（デフォルト: 10）
vim.g.diagnostics_quickfix_max_height = 10

-- 更新のデバウンス間隔（ミリ秒、デフォルト: 100）
vim.g.diagnostics_quickfix_debounce_ms = 100

-- severity 順でソートするか（デフォルト: true）
vim.g.diagnostics_quickfix_sort_by_severity = true
```

## 補足

- 同期イベントごとに `setqflist` で quickfix リストを更新します。
