if (instance_exists(target)) {
    var box_width = 80;
    var box_height = 20;
    var padding = 8;

    var draw_x = target.x - box_width div 2;
    var draw_y = target.y - 30;

    // Caixa de fundo
    draw_set_color(c_black);
    draw_rectangle(draw_x, draw_y, draw_x + box_width, draw_y + box_height, false);

    if (current_line < array_length(dialogue)) {
        var txt = dialogue[current_line];

        draw_set_color(c_white);

        // Tamanhos possíveis da fonte (de maior para menor)
        var fonts = [fnt_dialogo];
        var chosen_font = fonts[0];

        // Tenta escolher a maior fonte que cabe na caixa
        for (var i = 0; i < array_length(fonts); i++) {
            var f = fonts[i];
            draw_set_font(f);  // define a fonte para medir
            var text_height = string_height_ext(txt, -1, box_width - 2 * padding);

            if (text_height <= box_height - 2 * padding) {
                chosen_font = f;
                break;
            }
        }

        draw_set_font(chosen_font);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);

        draw_text_ext(draw_x + padding, draw_y + padding, txt, -1, box_width - 2 * padding);
    }
}
