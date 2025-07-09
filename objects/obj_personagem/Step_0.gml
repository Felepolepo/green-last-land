//Script do Menu
Script_menu_Pause(1); // ou outro valor padrão de velocidade
if (global.pausado) exit; // Ou: return;
//Script propio
script_execute(estado);

depth = -y;

if alarm[1] <= 0{
	estamina += 1;
}

if (vida <= 0) {
    show_debug_message("Você morreu. Recarregando checkpoint...");
    
    if (!global.load_pending) {
        global.load_slot = "save_checkpoint.ini"; // mesmo nome usado no checkpoint
        global.load_pending = true;
        room_goto(room); // reinicia a sala atual
    }

    exit;
}

estamina = clamp(estamina, 0, max_estamina[level]); //clamp da um minimo e um maximo


if (xp >= max_xp[level]) {
    xp -= max_xp[level]; // não desperdiça XP
    level += 1;
    
    // Protege contra níveis maiores que o tamanho dos arrays
    if (level < array_length(max_vida)) {
        vida = max_vida[level];
        estamina = max_estamina[level];
    } else {
        // Se passar do último nível, mantém no máximo possível
        level = array_length(max_vida) - 1;
        vida = max_vida[level];
        estamina = max_estamina[level];
        xp = 0; // zera xp para impedir loop infinito de up
    }
}


if (keyboard_check_pressed(ord("E"))) {
    arma += 1;
}

if (keyboard_check_pressed(ord("Q"))) {
    arma -= 1;
}

if (arma >= Armas.Altura) {
    arma = 0;
} else if (arma < 0) {
    arma = Armas.Altura - 1;
}

if instance_exists(obj_item) and obj_inventario.inventario == false {
	var _inst = instance_nearest(x, y, obj_item);
	if distance_to_point(_inst.x, _inst.y) <= 20{
		if keyboard_check_pressed(ord("F")){
			ds_grid_add_item(_inst.image_index, _inst.quantidade, _inst.sprite_index);
			
			instance_destroy(_inst);
		}
	}
}
