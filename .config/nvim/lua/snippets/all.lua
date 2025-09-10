local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

return {
	s("(", { t("("), i(1, " "), t(")") }),
	s("{", { t("{"), i(1, " "), t("}") }),
	s("[", { t("["), i(1, " "), t("]") }),
	s("\"", { t("\""), i(1, " "), t("\"") }),
	s("'", { t("'"), i(1, " "), t("'") }),
	s("`", { t("`"), i(1, " "), t("`") }),
	s("tag", {
		t("<"), i(1, "name"), t(">"),
		i(2),
		t("</"),
		f(function(args) return args[1] end, { 1 }),
		t(">")
	}),
}
