extends RichTextLabel
@onready var popup_text : RichTextLabel = $"."
@onready var timer : Timer = $Timer
var was_text_shown : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(timer.time_left)
	if timer.time_left <= 230 and was_text_shown == 0:
		popup_text.visible = !popup_text.visible
		popup_text.add_text("Wave 1: N-E")
		was_text_shown += 1
	if timer.time_left <= 200 and was_text_shown == 1:
		popup_text.clear()
		popup_text.add_text("Wave 2: S-W")
		was_text_shown += 1
	if timer.time_left <= 190 and was_text_shown == 2:
		popup_text.clear()
		popup_text.add_text("Wave 3: N-N-W")
		was_text_shown += 1
	if timer.time_left <= 160 and was_text_shown == 3:
		popup_text.clear()
		popup_text.add_text("Wave 4: S-E")
		was_text_shown += 1
	if timer.time_left <= 130 and was_text_shown == 4:
		popup_text.clear()
		popup_text.add_text("Wave 5: N-W")
		was_text_shown += 1
	if timer.time_left <= 100 and was_text_shown == 5:
		popup_text.clear()
		popup_text.add_text("Wave 6: W-N-W")
		was_text_shown += 1
