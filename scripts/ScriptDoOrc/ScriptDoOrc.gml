// ta a movimentação, perseguição, ataque, reação a dano e troca de sprites do orc aqui

// Função de colisão com paredes
function ScriptDoOrc_Colisao() {
    // Movimentos propostos
    var mov_x = hveloc;
    var mov_y = vveloc;

    // Checa colisão horizontal
    if place_meeting(x + mov_x, y, obj_parede) {
        // Move até encostar na parede sem colidir
        while (!place_meeting(x + sign(mov_x), y, obj_parede)) {
            x += sign(mov_x);
        }
        mov_x = 0; // Cancela movimento
    }

    // Checa colisão vertical
    if place_meeting(x, y + mov_y, obj_parede) {
        // Move até encostar na parede sem colidir
        while (!place_meeting(x, y + sign(mov_y), obj_parede)) {
            y += sign(mov_y);
        }
        mov_y = 0; // Cancela movimento
    }

    // Aplica movimento restante
    x += mov_x;
    y += mov_y;
}

// Checa se o personagem está próximo o suficiente para aggro
function ScriptOrc_ChecarPersonagem() {
    if distance_to_object(obj_personagem) <= dist_aggro {
        estado = ScriptDoOrc_Perseguindo;
    }
}

// Escolhe aleatoriamente se o orc vai andar ou ficar parado
function ScriptDoOrc_EscolherEstado() {
    ScriptOrc_ChecarPersonagem(); // Pode iniciar perseguição se o jogador estiver perto

    prox_estado = choose(ScriptDoOrc_Andando, ScriptDoOrc_Parado);

    if prox_estado == ScriptDoOrc_Andando {
        estado = ScriptDoOrc_Andando;
        // Define um destino aleatório no cenário
        dest_x = irandom_range(0, room_width);
        dest_y = irandom_range(0, room_height);
    } else {
        estado = ScriptDoOrc_Parado;
    }
}

// Movimento aleatório para um ponto do cenário
function ScriptDoOrc_Andando() {
    ScriptOrc_ChecarPersonagem(); // Pode iniciar perseguição se necessário
    image_speed = 1;

    if distance_to_point(dest_x, dest_y) > veloc {
        // Move na direção do ponto aleatório
        var _dir = point_direction(x, y, dest_x, dest_y);
        hveloc = lengthdir_x(veloc, _dir);
        vveloc = lengthdir_y(veloc, _dir);

        ScriptDoOrc_Colisao(); // Evita atravessar paredes
        ScriptDoOrc_DefinirSprite(hveloc, vveloc, "walk");
    } else {
        // Chegou ao destino, define próximo estado depois de um tempo
        estado = ScriptDoOrc_EscolherEstado;
        alarm[0] = irandom_range(120, 240); // Espera 2 a 4 segundos
    }
}

// Fica parado, mantendo a última direção da sprite
function ScriptDoOrc_Parado() {
    ScriptOrc_ChecarPersonagem(); // Pode iniciar perseguição
    hveloc = 0;
    vveloc = 0;
    image_speed = 0.5;

    // Mostra sprite de idle com a última direção usada
    ScriptDoOrc_DefinirSprite(hveloc_ant, vveloc_ant, "idle");
}

// Persegue o personagem
function ScriptDoOrc_Perseguindo() {
    alarm[2] = 180; // Reinicia tempo para desaggro se não ver o jogador
    image_speed = 1.5;

    // Define o personagem como alvo
    dest_x = obj_personagem.x;
    dest_y = obj_personagem.y;

    // Move em direção ao personagem
    var _dir = point_direction(x, y, dest_x, dest_y);
    hveloc = lengthdir_x(veloc_perseg, _dir);
    vveloc = lengthdir_y(veloc_perseg, _dir);

    ScriptDoOrc_Colisao(); // Evita atravessar paredes
    ScriptDoOrc_DefinirSprite(hveloc, vveloc, "walk");

    // Começa ataque se estiver perto
    if distance_to_object(obj_personagem) < 10 {
        estado = ScriptDoOrc_Atacando;
    }
    // Desaggro se o personagem fugir
    else if distance_to_object(obj_personagem) >= dist_desaggro {
        estado = ScriptDoOrc_EscolherEstado;
        alarm[0] = irandom_range(120, 240);
    }
}

// Ataca o personagem se estiver próximo
function ScriptDoOrc_Atacando() {
    hveloc = 0;
    vveloc = 0;

    // Define sprite de ataque com base na direção anterior
    if sprite_index != asset_get_index("orc1_attack_" + 
        ((abs(hveloc_ant) > abs(vveloc_ant)) ? 
        ((hveloc_ant > 0) ? "direita" : "esquerda") : 
        ((vveloc_ant > 0) ? "baixo" : "cima"))) {

        ScriptDoOrc_DefinirSprite(hveloc_ant, vveloc_ant, "attack");
        image_index = 0;
        image_speed = 0.5;
    }

    // Aplica dano somente no frame 4 da animação
    if floor(image_index) == 4 && !orc_ja_bateu {
        if place_meeting(x, y, obj_personagem) {
            with (obj_personagem) {
                if tomardano {
                    empurrar_dir = point_direction(other.x, other.y, x, y);
                    estado = ScriptPersonagem_Hit;
                    alarm[2] = 10;
                    alarm[3] = 30;
                    tomardano = false;
                    vida -= 15;
                }

                // Cria efeito de dano visual
                var _inst = instance_create_layer(x, y, "instances", obj_dano);
                _inst.alvo = id;
                _inst.dano = 15;
            }

            orc_ja_bateu = true; // Garante que o ataque só cause dano uma vez
        }
    }

    // Final da animação de ataque
    if image_index >= image_number - 1 {
        image_speed = 0;
        orc_ja_bateu = false;
        estado = ScriptDoOrc_Perseguindo;
    }
}

// Reação ao tomar dano: empurrado para trás
function ScriptDoOrc_Hit() {
    alarm[2] = 180; // Mantém o orc em modo alerta por 3 segundos
    empurrar_veloc = lerp(empurrar_veloc, 0, 0.05); // Reduz o impulso aos poucos

    // Move o orc na direção contrária ao ataque
    hveloc = lengthdir_x(empurrar_veloc, empurrar_dir);
    vveloc = lengthdir_y(empurrar_veloc, empurrar_dir);

    ScriptDoOrc_Colisao(); // Impede atravessar paredes
}

// Define a sprite do orc com base na direção e tipo de animação
function ScriptDoOrc_DefinirSprite(hv, vv, tipo_anim) {
    var dir = "baixo";

    if abs(hv) > abs(vv) {
        dir = (hv > 0) ? "direita" : "esquerda";
    } else {
        dir = (vv > 0) ? "baixo" : "cima";
    }

    var nome_sprite = "orc1_" + tipo_anim + "_" + dir;
    var spr_index = asset_get_index(nome_sprite);

    if (spr_index != -1) {
        sprite_index = spr_index;
    }

    // Salva a última direção válida
    hveloc_ant = hv;
    vveloc_ant = vv;
}
