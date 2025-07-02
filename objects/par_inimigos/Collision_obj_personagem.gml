///@description Empurrar o personagem no dano
if other.tomardano == true{
	var _dir = point_direction(x, y, other.x, other.y);

	with (other){ //Faz parte do personagem
		empurrar_dir = _dir;
		estado = ScriptPersonagem_Hit;
		alarm[2] = 10;
		alarm[3] = 100;
		tomardano = false;
		vida -= 1;

	}
	var _inst = instance_create_layer(x,y, "instances", obj_dano);
	_inst.alvo = other;
	_inst.dano = 1;
}

