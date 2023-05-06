class_name Rifle
extends Weapon


func shoot():
	if try_spend_ammo(1):
		rebound()
		add_child()
	
