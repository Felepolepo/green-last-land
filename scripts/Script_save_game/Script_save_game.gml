function scr_salvar_jogo(save_file) {

	ini_open(save_file);

	// === SALVAR DADOS DO JOGADOR ===
	if (!instance_exists(obj_personagem)) {
		instance_create_layer(0, 0, "Instances", obj_personagem);
	}
	with (obj_personagem) {
		ini_write_real("player", "x", x);
		ini_write_real("player", "y", y);
		ini_write_real("player", "vida", vida);
		ini_write_real("player", "estamina", estamina);
		ini_write_real("player", "level", level);
		ini_write_real("player", "xp", xp);
		ini_write_real("player", "arma", arma);
	}
	ini_write_string("player", "room", room_get_name(room));

	// === SALVAR INVENTÁRIO ===
	for (var i = 0; i < obj_inventario.total_slots; i++) {
		var secao = "inventario" + string(i);
		var item = obj_inventario.grid_items[# Infos.Item, i];
		var qtd = obj_inventario.grid_items[# Infos.Quantidade, i];
		var spr = obj_inventario.grid_items[# Infos.Sprite, i];

		ini_write_real(secao, "item", item);
		ini_write_real(secao, "quantidade", qtd);
		ini_write_string(secao, "sprite", (spr != -1) ? sprite_get_name(spr) : "-1");
	}

	// === META INFORMAÇÕES ===
	var total_itens = 0;
	for (var i = 0; i < obj_inventario.total_slots; i++) {
		var qtd = obj_inventario.grid_items[# Infos.Quantidade, i];
		if (qtd != -1) total_itens += qtd;
	}
	ini_write_real("meta", "total_itens", total_itens);
	ini_write_string("meta", "data_hora", date_time_string(date_current_datetime()));

	ini_close();
	show_debug_message("Jogo salvo com sucesso.");
}

function scr_carregar_jogo(slot_filename) {
	if (!file_exists(slot_filename)) {
		show_debug_message("Arquivo de save não encontrado.");
		exit;
	}

	ini_open(slot_filename);

	var room_salva = ini_read_string("player", "room", "Home");

	if (room_get_name(room) != room_salva) {
		global.load_pending = true;
		global.load_room = room_salva;
		ini_close();
		room_goto(asset_get_index(room_salva));
		exit;
	}

	// Garante que o personagem exista
	if (!instance_exists(obj_personagem)) {
		instance_create_layer(0, 0, "Instances", obj_personagem);
	}

	// === CARREGAR DADOS DO JOGADOR ===
	with (obj_personagem) {
		x        = ini_read_real("player", "x", 100);
		y        = ini_read_real("player", "y", 100);
		vida     = ini_read_real("player", "vida", 20);
		estamina = ini_read_real("player", "estamina", 100);
		level    = ini_read_real("player", "level", 1);
		xp       = ini_read_real("player", "xp", 0);
		arma     = ini_read_real("player", "arma", 0);
		estado   = ini_read_real("player", "estado", ScriptDoPersonagem_Andando);
	}

	// === CARREGAR INVENTÁRIO ===
	for (var i = 0; i < obj_inventario.total_slots; i++) {
		var secao = "inventario" + string(i);
		obj_inventario.grid_items[# Infos.Item, i]       = ini_read_real(secao, "item", -1);
		obj_inventario.grid_items[# Infos.Quantidade, i] = ini_read_real(secao, "quantidade", 0);

		var spr_nome = ini_read_string(secao, "sprite", "-1");
		if (spr_nome != "-1" && asset_get_index(spr_nome) != -1) {
			obj_inventario.grid_items[# Infos.Sprite, i] = asset_get_index(spr_nome);
		} else {
			obj_inventario.grid_items[# Infos.Sprite, i] = -1;
		}
	}

	ini_close();
	show_debug_message("Jogo carregado com sucesso.");
}

function scr_carregar_infos_saves() {
	saves_info = [];

	for (var i = 0; i < array_length(save_slots); i++) {
		var save_file = save_slots[i];
		var nome = "Slot " + string(i + 1);

		if (file_exists(save_file)) {
			ini_open(save_file);

			var data = ini_read_string("meta", "data_hora", "??/??/????");
			var lvl = ini_read_real("player", "level", -1);
			var total_itens = ini_read_real("meta", "total_itens", 0);

			array_push(saves_info, nome + " - Nível " + string(lvl) + " - Itens: " + string(total_itens) + " - " + data);
			ini_close();
		} else {
			array_push(saves_info, nome + " (vazio)");
		}
	}
}
	