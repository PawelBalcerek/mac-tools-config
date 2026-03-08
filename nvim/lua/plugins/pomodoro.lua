return {
	"epwalsh/pomo.nvim",
	version = "*",
	lazy = true,
	cmd = { "TimerStart", "TimerStop", "TimerSession", "TimerPause", "TimerResume", "TimerHide", "TimerShow" },
	dependencies = {
		"rcarriga/nvim-notify",
	},
	keys = {
		{ "<leader>sps", "<cmd>TimerSession single_pomodoro_session<CR>", desc = "Single Pomodoro session" },
		{ "<leader>dps", "<cmd>TimerSession double_pomodoro_session<CR>", desc = "Double Pomodoro session" },
		{ "<leader>pss", "<cmd>TimerStop<CR>", desc = "Pomodoro session stop" },
		{ "<leader>ptp", "<cmd>TimerPause<CR>", desc = "Pomodoro timer pause" },
		{ "<leader>ptr", "<cmd>TimerResume<CR>", desc = "Pomodoro timer resume" },
		{ "<leader>pth", "<cmd>TimerHide<CR>", desc = "Pomodoro timer hide" },
		{ "<leader>pts", "<cmd>TimerShow<CR>", desc = "Pomodoro timer show" },
	},
	opts = {
		notifiers = {
			{ name = "Default" },
			{ name = "System" },
		},
		sessions = {
			single_pomodoro_session = {
				{ name = "Work", duration = "25m" },
				{ name = "Short Break", duration = "5m" },
			},
			double_pomodoro_session = {
				{ name = "Work", duration = "25m" },
				{ name = "Short Break", duration = "5m" },
				{ name = "Work", duration = "25m" },
				{ name = "Long Break", duration = "15m" },
			},
		},
	},
}
