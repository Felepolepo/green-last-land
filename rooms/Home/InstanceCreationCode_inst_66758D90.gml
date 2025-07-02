var dist_abrir = 38;
var dist = point_distance(x, y, obj_personagem.x, obj_personagem.y);

if (dist <= dist_abrir) {
    // Personagem perto - anima porta abrindo do frame 1 até o 4
    if (image_index < 4) {
        image_speed = 1; // anima pra frente
    } else {
        image_speed = 0;   // trava no frame 4 (aberta)
        image_index = 4;

        // Trocar para a room "CasaP" e posicionar personagem
        obj_personagem.x = 295;
        obj_personagem.y = 209;
        room_goto(CasaP); // ou o nome correto da sua room
    }
} else {
    // Personagem longe - anima porta fechando do frame 4 até o 1
    if (image_index > 0) {
        image_speed = -1; // anima pra trás
    } else {
        image_speed = 0;    // trava no frame 1 (fechada)
        image_index = 0;
    }
}


