/// @description Inicializa o dano visual

// Ajuste de escala para conversão de posição da sala para GUI
var _cl = camera_get_view_width(view_camera[0]);
var _ca = camera_get_view_height(view_camera[0]);

escalax = display_get_gui_width() / _cl;
escalay = display_get_gui_height() / _ca;

// Dados do dano
dano = -1;
alvo = noone;

// Alpha e posição inicial
alpha = 1;

if (instance_exists(alvo)) {
    xx = alvo.x;
    yy = alvo.y;
} else {
    xx = x;
    yy = y;
}
