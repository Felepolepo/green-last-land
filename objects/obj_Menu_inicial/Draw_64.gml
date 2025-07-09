var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();
var _hstr = string_height("I");

draw_set_font(fnt_menu_inicial_Titulo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_wgui / 2, _hgui * 0.15, "Green Last Land");

draw_set_font(fnt_menu_inicial);

// Atualiza o array escala[] de forma segura
var total_max_itens = max(array_length(menu_principal), array_length(menu_opcoes));
for (var i = 0; i < total_max_itens; i++) {
    if (array_length(escala) <= i) escala[i] = 1;
}

// =================== MENU PRINCIPAL ou OPÇÕES ===================
if (!modo_carregar_save) {
    var lista_menu = modo_opcoes ? menu_opcoes : menu_principal;
    var espacamento = _hstr * 2;
    var y_base = _hgui / 2 - (array_length(lista_menu) * espacamento) / 2;

    for (var i = 0; i < array_length(lista_menu); i++) {
        var texto = lista_menu[i];
        var _wstr = string_width(texto);
        var _x = _wgui / 2;
        var _y = y_base + espacamento * i;

        var x1 = _x - _wstr / 2;
        var y1 = _y - _hstr / 2;
        var x2 = _x + _wstr / 2;
        var y2 = _y + _hstr / 2;

        if (point_in_rectangle(_mx, _my, x1, y1, x2, y2)) {
            escala[i] = lerp(escala[i], 1.4, 0.15);

            if (mouse_check_button_pressed(mb_left)) {
                if (!modo_opcoes) {
                    switch (texto) {
                        case "Jogar":
                            room_goto(CasaP);
							
                            break;

                        case "Carregar save":
                            scr_carregar_infos_saves();
                            modo_carregar_save = true;
                            break;

                        case "Opções":
                            modo_opcoes = true;
                            break;

                        case "Sair":
                            game_end();
                            break;
                    }
                } else {
                    switch (i) {
                        case 0: // Resolução
                            res_index = (res_index + 1) mod array_length(resolucoes);
                            var res = resolucoes[res_index];
                            var w = real(string_copy(res, 1, string_pos("x", res) - 1));
                            var h = real(string_copy(res, string_pos("x", res) + 1, 10));
                            window_set_size(w, h);
                            display_set_gui_size(w, h);
                            menu_opcoes[0] = "Resolução: " + res;
                            break;

                        case 1: // Modo Tela
                            var full = !window_get_fullscreen();
                            window_set_fullscreen(full);
                            menu_opcoes[1] = "Modo Tela: " + (full ? "Tela Cheia" : "Janela");
                            break;

                        case 2: // Volume Música
                            global.vol_bgm -= 0.1;
                            if (global.vol_bgm < 0) global.vol_bgm = 1;
                            menu_opcoes[2] = "Volume Música: " + string(round(global.vol_bgm * 100)) + "%";
                            if (variable_global_exists("musica_id")) {
                                audio_sound_gain(global.musica_id, global.vol_bgm, 0);
                            }
                            break;

                        case 3: // Volume Sons
                            global.vol_sfx -= 0.1;
                            if (global.vol_sfx < 0) global.vol_sfx = 1;
                            menu_opcoes[3] = "Volume Sons: " + string(round(global.vol_sfx * 100)) + "%";
                            break;

                        case 4: // Voltar
                            modo_opcoes = false;
                            break;
                    }
                }
            }
        } else {
            escala[i] = lerp(escala[i], 1, 0.15);
        }

        draw_text_transformed(_x, _y, texto, escala[i], escala[i], 0);
    }
}

// =================== MENU CARREGAR SAVE ===================
if (modo_carregar_save) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_wgui / 2, 60, "Selecione um slot de save");

    var espacamento = _hstr * 2;
    var y_base = _hgui / 2 - (array_length(saves_info) * espacamento) / 2;

    for (var i = 0; i < array_length(saves_info); i++) {
        var texto = saves_info[i];
        var _x = _wgui / 2;
        var _y = y_base + espacamento * i;

        var _wstr = string_width(texto);
        var x1 = _x - _wstr / 2;
        var y1 = _y - _hstr / 2;
        var x2 = _x + _wstr / 2;
        var y2 = _y + _hstr / 2;

        if (point_in_rectangle(_mx, _my, x1, y1, x2, y2)) {
            draw_set_colour(c_yellow);
            if (mouse_check_button_pressed(mb_left)) {
                global.save_slot = save_slots[i];
                ini_open(global.save_slot);
                global.load_room = ini_read_string("player", "room", "Home");
                ini_close();
                global.load_pending = true;
                room_goto(asset_get_index(global.load_room));
            }
        } else {
            draw_set_colour(c_white);
        }

        draw_text(_x, _y, texto);
    }

    // Botão Voltar
    draw_set_colour(c_white);
    var voltar_y = _hgui - 40;
    draw_text(_wgui / 2, voltar_y, "< Voltar");

    if (point_in_rectangle(_mx, _my, _wgui / 2 - 100, voltar_y - 20, _wgui / 2 + 100, voltar_y + 20)) {
        if (mouse_check_button_pressed(mb_left)) {
            modo_carregar_save = false;
        }
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
