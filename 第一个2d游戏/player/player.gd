extends Area2D

signal hit

@export var speed = 400 # 玩家移动速度 使用 export 关键字，这样我们就可以在“检查器”中设置其值。
var screen_size # 屏幕尺寸

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# 使用 Input.is_action_pressed() 来检测是否按下了键, 
	# 如果按下会返回 true, 否则返回 false
	
	# 设置一个二维q全0速度
	var velocity = Vector2.ZERO
	
	# 判断键位，如果按下W/A/S/D时，处理
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	print(velocity.length())
	
	if velocity.length() > 0:
		# 当按键按下时
		velocity = velocity.normalized() * speed
		
		print(velocity.x)
		print(velocity.y)
		
		# 检查玩家是否正在移动，以便在 AnimatedSprite2D 上调用 play() 或 stop() 
		# 使用这种方式，在玩家没有按下时，不会绘制
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	
	# 更新位置
	position += velocity * delta
	# 防止人物出屏幕
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
