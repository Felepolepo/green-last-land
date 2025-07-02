//Quando tiver contato com o slime dara dano
//o other eu uso para em colisões e interações entre instâncias
//nesse caso é o inimigo 
other.vida -= obj_personagem.dano[obj_personagem.level];

var _dir = point_direction(obj_personagem.x ,obj_personagem.y, other.x, other.y);
other.empurrar_dir = _dir; //pegar posição do slime
other.empurrar_veloc = 6; // define os frames para empurrar
other.estado = ScriptSlime_Hit;

other.alarm[1] = 5;
other.hit = true; //quando o alarme voltar o slime pode levar dano

var _inst = instance_create_layer(x,y, "instances", obj_dano);
_inst.alvo = other;
_inst.dano = obj_personagem.dano[obj_personagem.level];
