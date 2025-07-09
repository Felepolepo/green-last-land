
if (global.load_pending) {
    show_debug_message("Room Start detectado - carregando jogo...");
	global.load_pending = false;
	scr_carregar_jogo(global.save_slot);
}

