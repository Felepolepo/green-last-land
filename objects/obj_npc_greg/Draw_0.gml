// Inherit the parent event
event_inherited();

// obj_npc - Evento Draw GUI

if (pode_falar && !em_dialogo) {
    draw_text(x, y - 16, "[F] Falar");
}

if (em_dialogo) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_dano); // Use a fonte que preferir

    var fala = missao_falas[dialogo_etapa];
    draw_text(32, 400, fala);

    if (dialogo_finalizado) {
        draw_text(32, 440, "Aceitar missão? [Y] Sim / [N] Não");
    }
}
draw_self();
