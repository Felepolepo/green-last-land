// Tamanho da câmera (view)
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

// Tamanho da room atual
var room_w = room_width;
var room_h = room_height;

// Alvo desejado (jogador no centro)
var target_x = obj_personagem.x - cam_w / 2;
var target_y = obj_personagem.y - cam_h / 2;

// Limitar para não sair da room
target_x = clamp(target_x, 0, room_w - cam_w);
target_y = clamp(target_y, 0, room_h - cam_h);

// Suavidade com lerp
/*
A função lerp(a, b, t) no GameMaker (e em várias outras engines) faz interpolação linear entre dois valores.
*/
x = lerp(x, target_x, 0.05);
y = lerp(y, target_y, 0.05);

// Aplicar posição à câmera real
camera_set_view_pos(view_camera[0], x, y);
