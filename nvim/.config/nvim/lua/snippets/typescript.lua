local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescript", {
  -- test.describe
  s("describe", fmt([[
    test.describe('{}', () => {{
      {}
    }});
  ]], { i(1, "description"), i(2, "// tests") })),

  -- test
  s("test", fmt([[
    test('{}', async ({{ {} }}) => {{
      {}
    }});
  ]], { i(1, "should do something"), i(2, "page"), i(3, "// test body") })),

  -- expect
  s("expect", fmt([[expect({}).to{}({});]], {
    i(1, "actual"),
    i(2, "Be"),
    i(3, "expected"),
  })),
})
