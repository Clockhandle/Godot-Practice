extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var exp_manager: Node
@export var upgrade_scene: PackedScene
var current_upgrades = {}


func _ready() -> void:
	exp_manager.level_up.connect(on_level_up)
	


func on_level_up(level: int):
	var choosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if (choosen_upgrade == null):
		return
	
	apply_upgrade(choosen_upgrade)
	var upgrade_instance = upgrade_scene.instantiate()
	add_child(upgrade_instance)
	upgrade_instance.set_ability_upgrades([choosen_upgrade] as Array[AbilityUpgrade])


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if(!has_upgrade):
		current_upgrades[upgrade.id] = {
			"resources": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	
	print(current_upgrades)
