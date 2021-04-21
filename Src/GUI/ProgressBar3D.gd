extends Spatial


func show_progress_bar():
	$Billboard.show()
	
func hide_progress_bar():
	$Billboard.hide()

func set_progress(current, max_progress):
	$Viewport/ProgressBar.set_max(max_progress)
	$Viewport/ProgressBar.set_value(current)
