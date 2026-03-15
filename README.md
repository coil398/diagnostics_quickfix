# diagnostics_quickfix.nvim

現在バッファの LSP diagnostics を quickfix に自動同期する Neovim プラグインです。

## 機能

- `DiagnosticChanged` と `BufEnter` で quickfix を更新
- 現在バッファの diagnostics のみを対象に同期
- 複数行の diagnostic メッセージを 1 行に正規化
- diagnostics があるときは quickfix を開く
- diagnostics が空のときは quickfix を閉じる
- quickfix バッファ自身は更新対象から除外

## 要件

- Neovim 0.9 以上

## インストール（lazy.nvim）

```lua
{
  "coil398/diagnostics_quickfix",
}
```

## 設定

デフォルトはすべての diagnostics を表示します。任意で表示件数の上限を設定できます。

```lua
vim.g.diagnostics_quickfix_max_items = 5
```

## 補足

- 同期イベントごとに `setqflist` で quickfix リストを更新します。
