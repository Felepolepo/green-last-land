// ScriptPersonagem_Colisao
function ScriptPersonagem_Colisao() {
    // Colisão no eixo X
    if place_meeting(x + hveloc, y, obj_parede) {
        while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
            x += sign(hveloc);
        }
        hveloc = 0;
    }
    x += hveloc;

    // Colisão no eixo Y
    if place_meeting(x, y + vveloc, obj_parede) {
        while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
            y += sign(vveloc);
        }
        vveloc = 0;
    }
    y += vveloc;
}

// ScriptDoPersonagem_Andando
function ScriptDoPersonagem_Andando() {
    // Leitura de teclas
    direita = keyboard_check(ord("D"));
    esquerda = keyboard_check(ord("A"));
    cima = keyboard_check(ord("W"));
    baixo = keyboard_check(ord("S"));

    // Define vetores de direção
    hveloc = direita - esquerda;
    vveloc = baixo - cima;

    // Direção do movimento
    veloc_dir = point_direction(x, y, x + hveloc, y + vveloc);
    veloc = (hveloc != 0 || vveloc != 0) ? 2 : 0;

    // Converte direção para vetores
    hveloc = lengthdir_x(veloc, veloc_dir);
    vveloc = lengthdir_y(veloc, veloc_dir);

    // Aplica movimentação com colisão
    ScriptPersonagem_Colisao();

    // Define direção visual com base no mouse
    dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45) / 90);
    var spr_base = (hveloc == 0 && vveloc == 0) ? "parado" : "correndo";

    switch (dir) {
        case 0: sprite_index = asset_get_index("spr_personagem_" + spr_base + "_direita"); break;
        case 1: sprite_index = asset_get_index("spr_personagem_" + spr_base + "_cima"); break;
        case 2: sprite_index = asset_get_index("spr_personagem_" + spr_base + "_esquerda"); break;
        case 3: sprite_index = asset_get_index("spr_personagem_" + spr_base + "_baixo"); break;
        default: sprite_index = asset_get_index("spr_personagem_" + spr_base + "_direita");
    }

    // ===== DASH =====
    if estamina >= 10 {
        if mouse_check_button(mb_right) {
            estamina -= 10;
            alarm[1] = 180;
            alarm[0] = 8;
            dash_dir = point_direction(x, y, mouse_x, mouse_y);
            estado = ScriptDoPersonagem_Dash;
        }
    }

    // ===== ATAQUE =====
    if mouse_check_button_pressed(mb_left) {
        if arma == Armas.Espada {
            image_index = 0;
            switch (dir) {
                case 0: default: sprite_index = spr_personagem_atacando_direita; break;
                case 1: sprite_index = spr_personagem_atacando_cima; break;
                case 2: sprite_index = spr_personagem_atacando_esquerda; break;
                case 3: sprite_index = spr_personagem_atacando_baixo; break;
            }
            estado = ScriptDoPersonagem_Atacando;
        } else if arma == Armas.Arco {
            image_index = 0;
            estado = scr_personagem_arco;
        }
    }
}

// ScriptDoPersonagem_Dash
function ScriptDoPersonagem_Dash() {
    tomardano = false; // Invulnerável durante o dash

    hveloc = lengthdir_x(dash_veloc, dash_dir);
    vveloc = lengthdir_y(dash_veloc, dash_dir);

    ScriptPersonagem_Colisao();

    var _inst = instance_create_layer(x, y, "Instances", obj_dash);
    _inst.sprite_index = sprite_index;
}

// riptDoPersonagem_Atacando
function ScriptDoPersonagem_Atacando() {
    if image_index >= 1 {
        if !atacar {
            switch (dir) {
                case 0: default: instance_create_layer(x + 10, y, "Instances", obj_personagem_hitbox); break;
                case 1: instance_create_layer(x, y - 10, "Instances", obj_personagem_hitbox); break;
                case 2: instance_create_layer(x - 10, y, "Instances", obj_personagem_hitbox); break;
                case 3: instance_create_layer(x, y + 10, "Instances", obj_personagem_hitbox); break;
            }
            atacar = true;
        }
    }

    if fim_da_animacao() {
        estado = ScriptDoPersonagem_Andando;
        atacar = false;
    }
}

// ScriptPersonagem_Hit
function ScriptPersonagem_Hit() {
    if alarm[2] > 0 {
        hveloc = lengthdir_x(3, empurrar_dir);
        vveloc = lengthdir_y(3, empurrar_dir);
        ScriptDoSlime_Colisao(); // (Se preferir, use ScriptPersonagem_Colisao aqui)
    } else {
        estado = ScriptDoPersonagem_Andando;
    }
}

// scr_personagem_arco
function scr_personagem_arco() {
    dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45) / 90);

    switch (dir) {
        case 0: default: sprite_index = spr_personagem_arco_direita; break;
        case 1: sprite_index = spr_personagem_arco_cima; break;
        case 2: sprite_index = spr_personagem_arco_esquerda; break;
        case 3: sprite_index = spr_personagem_arco_baixo; break;
    }

    if fim_da_animacao() {
        image_index = 4; // Travar no frame de disparo
    }

    if mouse_check_button_released(mb_left) {
        if image_index >= 4 {
            var _dir = point_direction(x, y, mouse_x, mouse_y);
            var _xx = lengthdir_x(5, _dir);
            var _yy = lengthdir_y(5, _dir);

            var _inst = instance_create_layer(x + _xx, y + _yy, "instances", obj_flecha);
            _inst.direction = _dir;
            _inst.image_angle = _dir;
            _inst.speed = 10;

            empurrar_dir = point_direction(mouse_x, mouse_y, x, y);
            alarm[2] = 5;
            estado = ScriptPersonagem_Hit;
        } else {
            estado = ScriptDoPersonagem_Andando;
        }
    }
}
