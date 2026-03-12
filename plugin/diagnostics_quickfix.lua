if vim.g.vscode then
  return
end

local severity_map = {
  [vim.diagnostic.severity.ERROR] = "E",
  [vim.diagnostic.severity.WARN] = "W",
  [vim.diagnostic.severity.INFO] = "I",
  [vim.diagnostic.severity.HINT] = "H",
}

local function sanitize_message(message)
  return (message or "")
    :gsub("\r", " ")
    :gsub("\n", " ")
    :gsub("%s+", " ")
    :gsub("^%s*(.-)%s*$", "%1")
end

local function update_diagnostics_quickfix(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  if vim.bo[bufnr].buftype == "quickfix" then
    return
  end

  if bufnr ~= vim.api.nvim_get_current_buf() then
    return
  end

  local diagnostics = vim.diagnostic.get(bufnr)
  local max_items = vim.g.diagnostics_quickfix_max_items or 5
  local items = {}

  for i = 1, math.min(#diagnostics, max_items) do
    local diag = diagnostics[i]
    table.insert(items, {
      bufnr = bufnr,
      lnum = (diag.lnum or 0) + 1,
      col = (diag.col or 0) + 1,
      text = sanitize_message(diag.message),
      type = severity_map[diag.severity] or "E",
    })
  end

  vim.fn.setqflist({}, "r", { title = "Diagnostics", items = items })

  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end

    if bufnr ~= vim.api.nvim_get_current_buf() then
      return
    end

    if #items > 0 then
      local qf_exists = false
      for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
          qf_exists = true
          break
        end
      end
      if not qf_exists then
        pcall(vim.cmd, "botright copen " .. tostring(#items))
        pcall(vim.cmd, "wincmd p")
      end
    else
      pcall(vim.cmd, "cclose")
    end
  end)
end

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("DiagnosticsQuickfix", { clear = true }),
  callback = function(ev)
    update_diagnostics_quickfix(ev.buf)
  end,
})
