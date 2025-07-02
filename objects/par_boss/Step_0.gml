script_execute(estado);

if vida <= 0{
	obj_personagem.xp += 100; // dar 100 de xp
	instance_destroy();
}
