local ok, notify = pcall(require, "notify")

if not ok then
	return
end

notify.setup({
	background_colour = "#00000000",
	timeout = 2000,
	max_width = 20,
	fps = 60,
	stages = "fade_in_slide_out",
})
