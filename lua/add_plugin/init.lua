local M = {}

---@param plugin_name string
---@param config AddPlugin.Config
function M.add_plugin(plugin_name, config)
  local file_path = string.format("%s/%s.lua", config.plugin_root_path, plugin_name)

  local current_file = io.open(file_path, "r")
  if current_file then
    io.close(current_file)
    print("File already exists!")
    return
  end

  local f, err = io.open(file_path, "w")
  if not f then
    print("Failed to open file: " .. err)
    return
  end

  f:write(config.content)
  f:close()

  print("File created: " .. file_path)

  vim.api.nvim_command("edit " .. file_path)
end

---@param config AddPlugin.Config
local function setup_commands(config)
  vim.api.nvim_create_user_command(
    "AddPlugin",
    function(opts)
      M.add_plugin(opts.args, config)
    end,
    { nargs = 1 }
  )
end

---@return string
local function get_plugin_root_path()
  local myvimrc_path = vim.fn.getenv("MYVIMRC")
  local nvim_root_path = myvimrc_path:match("(.*[/\\])"):gsub("[/\\]init.vim$", ""):gsub("[/\\]init.lua$", "")
  local plugin_root_path = string.format("%s/lua/plugins", nvim_root_path)
  return plugin_root_path
end

---@return AddPlugin.Config
local function get_default_config()
  local content = [[
local M = {}

return M
]]

  ---@type AddPlugin.Config
  local config = {
    open_on_create = false,
    plugin_root_path = get_plugin_root_path(),
    content = content,
  }
  return config
end

---@param user_config AddPlugin.UserConfig
---@return AddPlugin.Config
local function merge_default_config(user_config)
  local default_config = get_default_config()

  local config = {}
  for k, v in pairs(default_config) do
    config[k] = v
  end

  for k, v in pairs(user_config or {}) do
    config[k] = v
  end

  return config
end

---@param user_config AddPlugin.UserConfig
function M.setup(user_config)
  local config = merge_default_config(user_config)
  setup_commands(config)
end

return M
