local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("cpp", {

    s("main", {
        t({
            "#include <iostream>",
            "#include <vector>",
            "#include <stack>",
            "#include <string>",
            "",
            "using namespace std;",
            "",
            "int main() {",
            "    "
        }),

        i(1),

        t({
            "",
            "    return 0;",
            "}"
        }),
    }),

    s("fori", {
        t("for (int i = 0; i < "),
        i(1, "n"),
        t("; i++) {"),
        t({"", "    "}),
        i(2),
        t({"", "}"}),
    }),

    s("cout", {
        t("cout << "),
        i(1),
        t(" << endl;"),
    }),

})
