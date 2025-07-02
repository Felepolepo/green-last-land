other.vida -= obj_personagem.dano[obj_personagem.level];
other.alarm[1] = 5;
other.hit = true; //quando o alarme voltar o slime pode levar dano

var _inst = instance_create_layer(x,y, "instances", obj_dano);
_inst.alvo = other;
_inst.dano = obj_personagem.dano[obj_personagem.level];