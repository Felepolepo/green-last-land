if (!global.pausado) {
    spawn_timer -= 1;

    if (spawn_timer <= 0) {
        spawn_timer = spawn_interval;

        // Spawnar 3 orcs de uma vez
        for (var i = 0; i < 3; i++) {
            var spawn_x = irandom_range(bbox_left, bbox_right);
            var spawn_y = irandom_range(bbox_top, bbox_bottom);

            instance_create_layer(spawn_x, spawn_y, "Instances", obj_orc_normal);
        }
    }
}
