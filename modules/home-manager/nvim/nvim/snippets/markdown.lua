local ts = require("vim.treesitter")
local ls = require("luasnip")

local function get_node_at_cursor()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col - 1

  local parser = ts.get_parser(buf, "latex")
  if not parser then
    return
  end
  local root_tree = parser:parse()[1]
  local root = root_tree and root_tree:root()

  if not root then
    return
  end

  return root:named_descendant_for_range(row, col, row, col)
end

local function in_mathzone()
  local node = get_node_at_cursor()
  while node do
    if node:type() == "text_mode" then
      return false
    elseif node:type() == "inline" then
      return true
    end
    node = node:parent()
  end
  return false
end

local parse_snippet = ls.extend_decorator.apply(ls.parser.parse_snippet, {
  wordTrig = true,
}) --[[@as function]]

return {
  s("!lec", { f(function()
    return os.date("%Y-%m-%d")
  end) }),
  parse_snippet({ trig = "_" }, "_{$1}$0"),
  parse_snippet({ trig = "^" }, "^{$1}$0"),
  parse_snippet({ trig = ".t" }, "^\\top"),
  parse_snippet({ trig = ".bb" }, "\\mathbb{$1}$0"),
  parse_snippet({ trig = ".frac" }, "\\frac{$1}{$2}$0"),
  parse_snippet({ trig = ".n" }, "\\lnot "),
  parse_snippet({ trig = ".a" }, "\\land "),
  parse_snippet({ trig = ".o" }, "\\lor "),
  parse_snippet({ trig = ".>" }, "\\implies "),
  parse_snippet(
    { trig = "math" },
    [[$$
$1
$$
$0]]
  ),
  parse_snippet(
    { trig = "bmatrix" },
    [[\\begin{bmatrix}
$1
\\end{bmatrix}
$0]]
  ),
  parse_snippet(
    { trig = "cases" },
    [[\\begin{cases}
$1
\\end{cases}
$0]]
  ),
  parse_snippet(
    { trig = ".b" },
    [[\\begin{$1}
$2
\\end{$1}
$0]]
  ),
  parse_snippet(
    { trig = ".tt" },
    [[\begin{array}{ c c c | c | c | c | c }
A & B & C & $1 \\
0 & 0 & 0 & 1 \\
0 & 0 & 1 & 1 \\
0 & 1 & 0 & 1 \\
0 & 1 & 1 & 1 \\
1 & 0 & 0 & 1 \\
1 & 0 & 1 & 1 \\
1 & 1 & 0 & 1 \\
1 & 1 & 1 & 1 \\
\end{array}
$0]]
  ),
}
