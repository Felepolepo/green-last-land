// Inherit the parent event
event_inherited();

if (vida <= 0) {
    obj_personagem.xp += 90;

    // Cria o drop do OrcDente no local do orc
    var drop = instance_create_layer(x, y, "Instances", obj_item);
    drop.sprite_index = spr_items_inimigos;
    drop.image_index = Item_Inimigos.SlimePart;  // índice do enum OrcDente
    drop.quantidade = 1;
    drop.visible = true;

    instance_destroy();
}