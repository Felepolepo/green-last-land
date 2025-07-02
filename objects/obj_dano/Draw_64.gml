/// @description Desenha o texto de dano na GUI

if (dano <= 0) exit;

// Converte posição da sala para GUI
var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);

var _x = (xx - _cx) * escalax;
var _y = (yy - _cy) * escalay;

draw_set_font(fnt_dano);
draw_set_alpha(alpha);

// Chama o script de contorno
draw_text_color_outline(_x, _y - 40, string(dano), 4, 8, c_black, 50, 50);

draw_set_alpha(1); // Restaura alpha padrão
