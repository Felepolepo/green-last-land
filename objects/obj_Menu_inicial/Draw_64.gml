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
        if (array_length(escala) <= i) escala[i] = 1;
        escala[i] = lerp(escala[i], 1.4, 0.15);

        if (mouse_check_button_pressed(mb_left)) {
            if (!modo_opcoes) {
                switch (texto) {
                    case "Jogar": room_goto(Home); break;
                    case "Opções": modo_opcoes = true; break;
                    case "Sair": game_end(); break;
					 
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
                        if (window_get_fullscreen()) {
                            window_set_fullscreen(false);
                            menu_opcoes[1] = "Modo Tela: Janela";
                        } else {
                            window_set_fullscreen(true);
                            menu_opcoes[1] = "Modo Tela: Tela Cheia";
                        }
                        break;

                    case 2: // Voltar
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

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
