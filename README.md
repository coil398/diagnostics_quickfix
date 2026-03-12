# diagnostics_quickfix.nvim

Automatically synchronize current-buffer diagnostics into Neovim quickfix.

## Features

- Syncs on `DiagnosticChanged` and `BufEnter`
- Tracks diagnostics only for the current buffer
- Normalizes multiline diagnostic text into a single quickfix line
- Opens quickfix when diagnostics exist
- Closes quickfix when diagnostics are empty
- Ignores quickfix buffers to avoid recursive updates

## Requirements

- Neovim 0.9+

## Install (lazy.nvim)

```lua
{
  "coil398/diagnostics_quickfix",
}
```

## Configuration

Optional global setting:

```lua
vim.g.diagnostics_quickfix_max_items = 5
```

Default is `5`.

## Notes

- The plugin writes to the quickfix list (`setqflist`) on every sync event.
- If you want all diagnostics instead of a capped list, set a large value for
  `vim.g.diagnostics_quickfix_max_items`.
