//Colisão com obj_parede
function ScriptDoSlime_Colisao() {
	// Colisão x
	if place_meeting(x + hveloc, y, obj_parede) {
		while (!place_meeting(x + sign(hveloc), y, obj_parede)) {
			x += sign(hveloc);
		}
		hveloc = 0;
	}
	// Move o personagem
	x += hveloc;

	// Colisão y
	if place_meeting(x, y + vveloc, obj_parede) {
		while (!place_meeting(x, y + sign(vveloc), obj_parede)) {
			y += sign(vveloc);
		}
		vveloc = 0;
	}
	// Move o personagem
	y += vveloc;
}
	
//Verificar se o Personagem ta perto
function ScriptSlimeChegar_Personagem(){
	//Para checar o personagem idependente do estado
	if distance_to_object(obj_personagem) <= dist_aggro{
		estado = ScriptDoSlime_Perseguindo;
	}
}
	
//Escolhe o estado de Perseguir, andar ou parar
function ScriptDoSlime_EscolherEstado() {
    ScriptSlimeChegar_Personagem(); // Verifica se deve perseguir o jogador
    
    prox_estado = choose(ScriptDoSlime_Andando, ScriptDoSlime_Parado); // Escolha aleatória

    if prox_estado == ScriptDoSlime_Andando {
        estado = ScriptDoSlime_Andando;
        dest_x = irandom_range(0, room_width);     // Escolhe novo destino aleatório
        dest_y = irandom_range(0, room_height);
    } else {
        estado = ScriptDoSlime_Parado;
    }
}
	
//Faz o Slime andar para um ponto do mapa
function ScriptDoSlime_Andando() {
    ScriptSlimeChegar_Personagem(); // Pode mudar para perseguição

    image_speed = 1;

    if distance_to_point(dest_x, dest_y) > veloc {
        var _dir = point_direction(x, y, dest_x, dest_y);
        hveloc = lengthdir_x(veloc, _dir);
        vveloc = lengthdir_y(veloc, _dir);

        ScriptDoSlime_Colisao(); // Move com checagem de colisão
    } else {
        // Chegou ao destino
        x = dest_x;
        y = dest_y;
    }
}
	
//Faz o Slime para
function ScriptDoSlime_Parado() {
    ScriptSlimeChegar_Personagem(); // Pode mudar para perseguição
    image_speed = 0.5; // Animação Diminui a velocidade
}

//Faz o Slime perseguir
function ScriptDoSlime_Perseguindo() {
    alarm[2] = 180; // Ativa a barra de vida por um tempo
    image_speed = 1.5;

    // Define destino como posição atual do jogador
    dest_x = obj_personagem.x;
    dest_y = obj_personagem.y;

    var _dir = point_direction(x, y, dest_x, dest_y);
    hveloc = lengthdir_x(veloc_perseg, _dir);
    vveloc = lengthdir_y(veloc_perseg, _dir);

    ScriptDoSlime_Colisao(); // Movimento com colisão

    // Sai do modo perseguição se o jogador estiver longe
    if distance_to_object(obj_personagem) >= dist_desaggro {
        estado = ScriptDoSlime_EscolherEstado;
        alarm[0] = irandom_range(120, 240); // Aguarda para escolher novo estado
    }
}

//Slime Leva Hit
function ScriptSlime_Hit() {
    alarm[2] = 180; // Ativa a barra de vida

    // Aplica "empurrão" com interpolação para suavizar
    empurrar_veloc = lerp(empurrar_veloc, 0, 0.05);

    hveloc = lengthdir_x(empurrar_veloc, empurrar_dir);
    vveloc = lengthdir_y(empurrar_veloc, empurrar_dir);

    ScriptDoSlime_Colisao(); // Aplica o movimento de empurrão com colisão
}

	