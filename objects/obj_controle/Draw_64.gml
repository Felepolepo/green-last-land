/// @description os Hud no visor da sala

//Como Funciona draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, colour, alpha);

if (room != rmincial ) {
	var _escala = 3;
	var _guia = display_get_gui_height(); //altura da GUI (interface gráfica da tela).
	var _spra = sprite_get_height(spr_hud_vida) * _escala; //altura total do sprite do HUD multiplicada pela escala.
	var _huda = _guia - _spra; //Y-base para desenhar as barras no canto inferior da tela.

	var _vida = obj_personagem.vida;
	var _maxvida = obj_personagem.max_vida[obj_personagem.level];
	var _estamina = obj_personagem.estamina;
	var _maxestamina = obj_personagem.max_estamina[obj_personagem.level];
	var _xp = obj_personagem.xp;
	var _max = obj_personagem.max_xp[obj_personagem.level];
	var _level = obj_personagem.level;

	var _esc = 2; // Escala da barra de XP
	var _sw = sprite_get_width(spr_hud_exp) * _esc;
	var _sh = sprite_get_height(spr_hud_exp) * _esc;
	var _x = (display_get_gui_width() - _sw) * 0.5;
	var _y = display_get_gui_height() - _sh - 10;

	// ---------------------- BARRAS ------------------------

	// Vida
	draw_sprite_ext(spr_hud_barra_vida, 0, 0, _huda, (_vida/_maxvida)*_escala, _escala, 0, c_white, 1);

	// Estamina
	draw_sprite_ext(spr_hud_barra_estamina, 0, 0, _huda + 24, (_estamina/_maxestamina)*_escala, _escala, 0, c_white, 1);

	// HUD (fundo)
	draw_sprite_ext(spr_hud_vida, 0, 0, _huda, _escala, _escala, 0, c_white, 1);

	// XP
	draw_sprite_ext(spr_hud_exp_barra, 0, _x + 9, _y + 7, (_xp / _max) * _esc, _esc, 0, c_white, 1);
	draw_sprite_ext(spr_hud_exp, 0, _x, _y, _esc, _esc, 0, c_white, 1);

	// ---------------------- TEXTOS ------------------------

	draw_set_font(fnt_dano); // Use a fonte que preferir
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	// Texto da Vida
	draw_text(90, _huda + 8, string(_vida) + " / " + string(_maxvida));

	// Texto da Estamina
	draw_text(100, _huda + 8 + 24, string(_estamina) + " / " + string(_maxestamina));

	// Texto do Level em cima da barra de XP
	draw_text(_x + _sw / 2, _y - 10, "Nível: " + string(_level));

	// ---------------------- BOSS ------------------------

	var _gl = display_get_gui_width();

	if (instance_exists(par_boss)) {
	    var _boss = instance_find(par_boss, 0);
    
	    if variable_instance_exists(_boss, "vida") && variable_instance_exists(_boss, "vida_max") && variable_instance_exists(_boss, "nome") {
	        var _sprw = sprite_get_width(spr_boss_hud) * _escala;
	        var _x = _gl / 2 - _sprw / 2;
	        var _y = 100;
        
	        draw_sprite_ext(spr_boss_hud, 0, _x, _y, _escala, _escala, 0, c_white, 1);
	        draw_sprite_ext(spr_boss_vida, 0, _x + 6, _y, (_boss.vida / _boss.vida_max) * _escala, _escala, 0, c_white, 1);
        
	        draw_set_halign(fa_center);
	        draw_set_valign(fa_top);
	        draw_text(_gl / 2, _y + sprite_get_height(spr_boss_hud) * _escala + 5, string(_boss.nome));
	    }
	}
}
