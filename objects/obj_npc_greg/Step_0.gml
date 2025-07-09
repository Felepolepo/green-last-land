var player = instance_nearest(x, y, obj_personagem);
if (instance_exists(player) && distance_to_object(player) < 20 && keyboard_check_pressed(ord("F"))) {
    if (!instance_exists(obj_dialogue_box)) {
        var bal = instance_create_layer(x, y - 40, "Instances", obj_dialogue_box);
        bal.target = id; // o NPC será o alvo (dono) do balão
    }
}
