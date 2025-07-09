if keyboard_check_pressed(ord("Y")){
	inventario = !inventario;
}
// === ATALHOS DE USO RÁPIDO (Z, X, C) ===
var tecla_usar_key = [ord("Z"), ord("X"), ord("C")];
var base_slots = slots_h * slots_v;

for (var i = 0; i < array_length(tecla_usar_key); i++) {
    var _tecla = tecla_usar_key[i];
    var _extra_index = base_slots + i;

    if keyboard_check_pressed(_tecla) {
        var item = grid_items[# Infos.Item, _extra_index];
        var sprite = grid_items[# Infos.Sprite, _extra_index];

        // Só continua se for uma poção conhecida
        var item_usado = false;

        if instance_exists(obj_personagem) && item != -1 && sprite == spr_items_pocoes {
            with (obj_personagem) {
                // Poção de Vida
                if item == Item_Pocoes.PocaoVida {
                    vida += 10;
                    vida = clamp(vida, 0, max_vida[level]);
                    item_usado = true;
                }
                // Poção de Energia
                else if item == Item_Pocoes.PocaoEnergia {
                    estamina += 15;
                    estamina = clamp(estamina, 0, max_estamina[level]);
                    item_usado = true;
                }
                // Poção de XP
                else if item == Item_Pocoes.PocaoXP {
                    xp += 30;
                    item_usado = true;
                }
            }
        }

        // Só consome se foi realmente usado
        if item_usado {
            grid_items[# Infos.Quantidade, _extra_index] -= 1;

            if grid_items[# Infos.Quantidade, _extra_index] <= 0 {
                grid_items[# Infos.Item, _extra_index] = -1;
                grid_items[# Infos.Quantidade, _extra_index] = -1;
                grid_items[# Infos.Sprite, _extra_index] = -1;
            }
        }
    }
}


