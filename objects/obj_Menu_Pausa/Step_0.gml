// obj_menu_pausa - Step Event

if (keyboard_check_pressed(vk_escape)) {
    visivel = !visivel;
    modo_opcoes = false;
    modo_ajuda = false;
    global.pausado = visivel; // Pausa manual
}

