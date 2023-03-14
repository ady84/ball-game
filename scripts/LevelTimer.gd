extends Label

var elapsed = 0

# COUNTS THE SECONDS
func _process(delta):
	elapsed += delta
	text = "%s sec" % stepify(elapsed, 0.1)
