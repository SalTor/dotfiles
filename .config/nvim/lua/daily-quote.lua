-- Daily Quote plugin for Neovim
-- This plugin provides a command to display daily inspirational quotes

---@diagnostic disable-next-line: undefined-global
local vim = vim

local M = {}

-- Collection of predetermined quotes
local quotes = {
  "Hello World! - The beginning of every programmer's journey.",
  "Code is poetry written in logic.",
  "The best error message is the one that never shows up.",
  "Simplicity is the ultimate sophistication. - Leonardo da Vinci",
  "First, solve the problem. Then, write the code. - John Johnson",
  "Code never lies, comments sometimes do. - Ron Jeffries",
  "The only way to learn a new programming language is by writing programs in it. - Dennis Ritchie",
  "Talk is cheap. Show me the code. - Linus Torvalds",
  "Programs must be written for people to read, and only incidentally for machines to execute. - Harold Abelson",
  "Any fool can write code that a computer can understand. Good programmers write code that humans can understand. - Martin Fowler",
  "Experience is the name everyone gives to their mistakes. - Oscar Wilde",
  "The best way to get a project done faster is to start sooner. - Jim Highsmith",
  "Debugging is twice as hard as writing the code in the first place. - Brian Kernighan",
  "Good code is its own best documentation. - Steve McConnell",
  "The function of good software is to make the complex appear to be simple. - Grady Booch"
}

-- Function to get today's quote based on day of year
local function get_daily_quote()
  -- Get the current day of the year (1-365/366)
  local day_of_year = tonumber(os.date("%j"))
  
  -- Use modulo to cycle through quotes
  local quote_index = (day_of_year % #quotes) + 1
  
  return quotes[quote_index]
end

-- Function to print daily quote
local function print_daily_quote()
  local quote = get_daily_quote()
  print("📝 Daily Quote: " .. quote)
end

-- Setup function to register the command
function M.setup()
  -- Create the main command :DailyQuote
  vim.api.nvim_create_user_command('DailyQuote', function()
    print_daily_quote()
  end, {
    desc = 'Display daily inspirational quote'
  })

  -- Create keymaps for daily quote access
  vim.keymap.set('n', '<leader>dq', print_daily_quote, {
    desc = 'Display Daily Quote',
    noremap = true,
    silent = true
  })
end

return M