

if hit {
    gpu_set_fog(true, c_white, 0, 0);
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}

// Vida
if alarm[2] >= 0 {
    var _sprw = sprite_get_width(spr_inimigo_hud_vida);
    draw_sprite_ext(spr_inimigo_hud_vida, 0, x - _sprw / 2, y - 8, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_inimigo_barra_vida, 0, x - _sprw / 2, y - 8, vida / max_vida, 1, 0, c_white, 1);
}
