spawn_timer -= 1;

if (spawn_timer <= 0) {
    spawn_timer = spawn_interval;

    // Spawnar 3 slimes (alguns podem ser grandes)
    for (var i = 0; i < 3; i++) {
        var spawn_x = irandom_range(bbox_left, bbox_right);
        var spawn_y = irandom_range(bbox_top, bbox_bottom);

        // Chance de 25% de ser um slime grande
        var chance = irandom(100);
        if (chance < 25) {
            instance_create_layer(spawn_x, spawn_y, "Instances", obj_slime_grande);
        } else {
            instance_create_layer(spawn_x, spawn_y, "Instances", obj_slime);
        }
    }
}
