// obj_menu_pausa - Draw GUI Event

if (!visivel && !modo_carregar_save && !modo_salvar_save) exit;

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _wgui = display_get_gui_width();
var _hgui = display_get_gui_height();
var _hstr = string_height("I");

draw_set_font(fnt_menu_inicial_Titulo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_wgui / 2, _hgui * 0.15, "Menu de Pausa");

draw_set_font(fnt_menu_inicial);

// ================= MENU PRINCIPAL =================
if (!modo_carregar_save && !modo_salvar_save) {
    var lista_menu;

    if (modo_opcoes) {
        lista_menu = menu_opcoes;
    } else if (modo_ajuda) {
        lista_menu = [
            "W A S D para se Movimentar",
            "Y para abrir o inventario",
            "Botão esquerdo Para atacar",
            "Botão direito para dar Dash",
            "Q & E para mudar de arma",
            "ESC para voltar"
        ];
    } else {
        lista_menu = menu_principal;
    }

    var espacamento = _hstr * 2;
    var y_base = _hgui / 2 - (array_length(lista_menu) * espacamento) / 2;

    for (var i = 0; i < array_length(lista_menu); i++) {
        if (array_length(escala) <= i) escala[i] = 1;

        var texto = lista_menu[i];
        var _x = _wgui / 2;
        var _y = y_base + espacamento * i;

        var _wstr = string_width(texto);
        var x1 = _x - _wstr / 2;
        var y1 = _y - _hstr / 2;
        var x2 = _x + _wstr / 2;
        var y2 = _y + _hstr / 2;

        if (point_in_rectangle(_mx, _my, x1, y1, x2, y2)) {
            escala[i] = lerp(escala[i], 1.4, 0.15);

            if (mouse_check_button_pressed(mb_left)) {
                if (modo_opcoes) {
                    switch (i) {
                        case 0:
                            res_index = (res_index + 1) mod array_length(resolucoes);
                            var res = resolucoes[res_index];
                            var w = real(string_copy(res, 1, string_pos("x", res) - 1));
                            var h = real(string_copy(res, string_pos("x", res) + 1, 10));
                            window_set_size(w, h);
                            display_set_gui_size(w, h);
                            menu_opcoes[0] = "Resolução: " + res;
                            break;

                        case 1:
                            var full = !window_get_fullscreen();
                            window_set_fullscreen(full);
                            menu_opcoes[1] = "Modo Tela: " + (full ? "Tela Cheia" : "Janela");
                            break;

                        case 2:
                            volume_bgm -= 0.1;
                            if (volume_bgm < 0) volume_bgm = 1.0;
                            global.vol_bgm = volume_bgm;
                            menu_opcoes[2] = "Volume Música: " + string(round(volume_bgm * 100)) + "%";
                            if (variable_global_exists("musica_id")) {
                                audio_sound_gain(global.musica_id, global.vol_bgm, 0);
                            }
                            break;

                        case 3:
                            volume_sfx -= 0.1;
                            if (volume_sfx < 0) volume_sfx = 1;
                            global.vol_sfx = volume_sfx;
                            menu_opcoes[3] = "Volume Sons: " + string(round(volume_sfx * 100)) + "%";
                            break;

                        case 4:
                            modo_opcoes = false;
                            break;
                    }
                } else if (modo_ajuda) {
                    modo_ajuda = false;
                } else {
                    switch (texto) {
                        case "Continuar Jogo":
                            visivel = false;
                            global.pausado = false;
                            break;

                        case "Salvar Jogo":
                            scr_carregar_infos_saves();
                            modo_salvar_save = true;
                            break;

                        case "Carregar Jogo":
                            scr_carregar_infos_saves();
                            modo_carregar_save = true;
                            break;

                        case "Ajuda":
                            modo_ajuda = true;
                            break;

                        case "Configurações":
                            modo_opcoes = true;
                            break;

                        case "Voltar pro Menu":
                            room_goto(rmincial);
                            game_restart();
                            instance_destroy();
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

// ================= MENU DE CARREGAMENTO DE SAVE =================
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
                global.pausado = false;
                visivel = false;
                modo_carregar_save = false;
                scr_carregar_jogo(global.save_slot);
            }
        } else {
            draw_set_colour(c_white);
        }

        draw_text(_x, _y, texto);
    }

    draw_set_colour(c_white);
    var voltar_y = _hgui - 40;
    draw_text(_wgui / 2, voltar_y, "Voltar");

    if (point_in_rectangle(_mx, _my, _wgui / 2 - 100, voltar_y - 20, _wgui / 2 + 100, voltar_y + 20)) {
        if (mouse_check_button_pressed(mb_left)) {
            modo_carregar_save = false;
        }
    }
}

// ================= MENU DE ESCOLHA DE SLOT PARA SALVAR =================
if (modo_salvar_save) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(_wgui / 2, 60, "Escolha um slot para salvar");

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
            draw_set_colour(c_lime);
            if (mouse_check_button_pressed(mb_left)) {
                global.save_slot = save_slots[i];
                scr_salvar_jogo(global.save_slot);
                modo_salvar_save = false;
                visivel = false;
                global.pausado = false;
            }
        } else {
            draw_set_colour(c_white);
        }

        draw_text(_x, _y, texto);
    }

    draw_set_colour(c_white);
    var voltar_y = _hgui - 80;
    draw_text(_wgui / 2, voltar_y, "Voltar");

    if (point_in_rectangle(_mx, _my, _wgui / 2 - 100, voltar_y - 20, _wgui / 2 + 100, voltar_y + 20)) {
        if (mouse_check_button_pressed(mb_left)) {
            modo_salvar_save = false;
        }
    }
}
