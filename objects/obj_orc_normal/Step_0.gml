//Do Parente Pai
event_inherited();

if (vida <= 0) {
    obj_personagem.xp += 30;

    // Cria o drop do OrcDente no local do orc
    var drop = instance_create_layer(x, y, "Instances", obj_item);
    drop.sprite_index = spr_items_inimigos;
    drop.image_index = Item_Inimigos.OrcDente;  // índice do enum OrcDente
    drop.quantidade = 1;
    drop.visible = true;
	
	 // Drop 2: Poção de Vida
    var drop2 = instance_create_layer(x, y, "Instances", obj_item);
    drop2.sprite_index = spr_items_pocoes;
    drop2.image_index = Item_Pocoes.PocaoVida;
    drop2.quantidade = 3;
    drop2.visible = true;

    instance_destroy();
}