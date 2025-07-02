if distance_to_object(obj_personagem) < 32 {
    pode_falar = true;
    draw_text(x, y - 32, "Pressione F para falar");
    
    if (keyboard_check_pressed(ord("F"))) {
        ScriptNPC_IniciarConversa(id);
    }
} else {
    pode_falar = false;
}
