Script_menu_Pause(1); // ou outro valor padrão de velocidade
if (global.pausado) exit; // Ou: return;

if fim_da_animacao(){
	var _dir=0;	
	
	repeat(4){
		var _inst = instance_create_layer(x,y,"Instances",obj_boss_projetil);
		_inst.speed = 3;
		_inst.direction = _dir;
		
		_dir += 90;
		Script_menu_Pause(1); // ou outro valor padrão de velocidade
		if (global.pausado) exit; // Ou: return;
	}
	instance_destroy();
}