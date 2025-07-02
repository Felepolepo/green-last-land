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

function ScriptSlimeChegar_Personagem(){
	//Para checar o personagem idependente do estado
	if distance_to_object(obj_personagem) <= dist_aggro{
		estado = ScriptDoSlime_Perseguindo;
	}
}

function ScriptDoSlime_EscolherEstado() {
	ScriptSlimeChegar_Personagem();
	
	prox_estado = choose(ScriptDoSlime_Andando, ScriptDoSlime_Parado);
	
	if prox_estado == ScriptDoSlime_Andando{
		estado = ScriptDoSlime_Andando;
		dest_x = irandom_range(0, room_width);
		dest_y = irandom_range(0, room_height);
	} else if prox_estado == ScriptDoSlime_Parado {
		estado = ScriptDoSlime_Parado;
	}
}

function ScriptDoSlime_Andando() {
	ScriptSlimeChegar_Personagem();
	
	image_speed = 1;
	
	if distance_to_point(dest_x, dest_y) > veloc{
		var _dir = point_direction(x, y, dest_x, dest_y);
		hveloc = lengthdir_x(veloc, _dir);
		vveloc = lengthdir_y(veloc, _dir);
		
		ScriptDoSlime_Colisao();
	} else {
		x = dest_x;
		y = dest_y;
	}
}

function ScriptDoSlime_Parado() {
	ScriptSlimeChegar_Personagem();
	image_speed = 0.5;
}

function ScriptDoSlime_Perseguindo() {
	alarm[2] = 180; //Mostra barra de vida
	image_speed = 1.5;
	
	//Ir na direção do personagem
	dest_x = obj_personagem.x;
	dest_y = obj_personagem.y;
	
	var _dir = point_direction(x, y, dest_x, dest_y);
	hveloc = lengthdir_x(veloc_perseg, _dir);
	vveloc = lengthdir_y(veloc_perseg, _dir);
	
	ScriptDoSlime_Colisao();
	
	//Para Parar de seguir
	if distance_to_object(obj_personagem) >= dist_desaggro{
		estado = ScriptDoSlime_EscolherEstado;
		alarm[0] = irandom_range(120, 240);
	}
}
	
 function ScriptSlime_Hit(){
	 alarm[2] = 180;//Mostra barra de vida
	 
	empurrar_veloc = lerp(empurrar_veloc,0,0.05);
	 
	hveloc = lengthdir_x(empurrar_veloc, empurrar_dir);
	vveloc = lengthdir_y(empurrar_veloc, empurrar_dir);
	
	ScriptDoSlime_Colisao();
 }
	