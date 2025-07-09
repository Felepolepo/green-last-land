Script_menu_Pause(1); // ou outro valor padrão de velocidade
if (global.pausado) exit; // Ou: return;

script_execute(estado);

if vida <= 0 {
    // Drop 1: Poção de XP
    var drop1 = instance_create_layer(x, y, "Instances", obj_item);
    drop1.sprite_index = spr_items_pocoes;
    drop1.image_index = Item_Pocoes.PocaoXP;
    drop1.quantidade = 3;
    drop1.visible = true;

    // Drop 2: Poção de Vida
    var drop2 = instance_create_layer(x, y, "Instances", obj_item);
    drop2.sprite_index = spr_items_pocoes;
    drop2.image_index = Item_Pocoes.PocaoVida;
    drop2.quantidade = 3;
    drop2.visible = true;

    // Destruir o inimigo
    instance_destroy();
}

