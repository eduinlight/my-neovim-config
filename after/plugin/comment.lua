require("Comment").setup()
local api = require("Comment.api")

K("n", "<A-c>", api.toggle.linewise.current)
K('v', '<A-c>', api.call('toggle.linewise', 'g@'), { expr = true })
