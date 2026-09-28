vim.filetype.add({
    extension = {
        swift = "swift",
    },
})

local ok, luasnip = pcall(require, "luasnip")
if not ok then
    return
end

local snippet = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

luasnip.add_snippets("swift", {
    snippet("view", fmt([[
struct {}: View {{
    var body: some View {{
        {}
    }}
}}
]], {
        insert(1, "ContentView"),
        insert(2, "Text(\"Hello\")"),
    })),

    snippet("preview", fmt([[
#Preview {{
    {}
}}
]], {
        insert(1, "ContentView()"),
    })),

    snippet("state", fmt([[
@State private var {} = {}
]], {
        insert(1, "value"),
        insert(2, "false"),
    })),

    snippet("binding", fmt([[
@Binding var {}: {}
]], {
        insert(1, "value"),
        insert(2, "Bool"),
    })),

    snippet("obs", fmt([[
@Observable
final class {} {{
    {}
}}
]], {
        insert(1, "ViewModel"),
        insert(2, ""),
    })),

    snippet("nav", fmt([[
NavigationStack {{
    {}
        .navigationTitle("{}")
}}
]], {
        insert(1, "Text(\"Hello\")"),
        insert(2, "Title"),
    })),

    snippet("list", fmt([[
List({}) {{ {} in
    {}
}}
]], {
        insert(1, "items"),
        insert(2, "item"),
        insert(3, "Text(item.title)"),
    })),

    snippet("button", fmt([[
Button("{}") {{
    {}
}}
]], {
        insert(1, "Action"),
        insert(2, ""),
    })),

    snippet("task", fmt([[
.task {{
    await {}
}}
]], {
        insert(1, "load()"),
    })),

    snippet("main", {
        text({ "@main", "struct " }),
        insert(1, "AppName"),
        text({ ": App {", "    var body: some Scene {", "        WindowGroup {", "            " }),
        insert(2, "ContentView()"),
        text({ "", "        }", "    }", "}" }),
    }),
})
