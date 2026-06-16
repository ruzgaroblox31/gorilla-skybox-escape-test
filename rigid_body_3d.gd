extends RigidBody3D

var xr_interface: XRInterface
@onready var sol_el = $"XROrigin3D/sol el"
@onready var sag_el = $"XROrigin3D/sağ el"
var sol_eski_pos = Vector3.ZERO
var sag_eski_pos = Vector3.ZERO
var guc_carpani = 3.5


func _physics_process(delta):
	var sol_hiz = sol_el.global_position - sol_eski_pos
	var sag_hiz = sag_el.global_position - sag_eski_pos
	if sol_el.global_position.y < 0.5 and sol_hiz.y < -0.01:
		apply_central_impulse(Vector3(0, -sol_hiz.y * guc_carpani / delta, 0))
		if sag_el.global_position.y < 0.5 and sag_hiz.y < -0.01:
			apply_central_impulse(Vector3(0, -sag_hiz.y * guc_carpani / delta, 0))
			sol_eski_pos = sol_el.global_position
			sag_eski_pos = sag_el.global_position
func _ready():
	lock_rotation = true
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		get_viewport().use_xr = true
