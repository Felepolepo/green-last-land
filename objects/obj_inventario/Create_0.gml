inventario = false;
escala = 3;

comeco_x = 15 * escala;
comeco_y = 24 * escala;

slots_h = 8;
slots_v = 3;

total_slots = slots_h * slots_v;
tamanho_slot = 16 * escala;
buffer = 1 * escala; // espaço entre os itens

inventario_l = sprite_get_width(spr_inventario) * escala;
inventario_a = sprite_get_height(spr_inventario) * escala;

item_selecionado = -1;
pos_selecionada = -1;

// ==== ENUMS ====
enum Item_Armas {
    Espada,
    Arco,
    Cajado,
    Altura
}

enum Item_Inimigos {
    SlimePart,
    OrcCapacete,
    OrcDente,
    Altura
}

enum Item_Pocoes {
    PocaoVida,
    PocaoEnergia,
    PocaoXP,
    Altura
}

enum Infos {
    Item,
    Quantidade,
    Sprite,
    Altura
}

// ==== INVENTÁRIO GRID ====
grid_items = ds_grid_create(Infos.Altura, total_slots);
ds_grid_set_region(grid_items, 0, 0, Infos.Altura - 1, total_slots - 1, -1);

// ==== ITENS DE TESTE ====
ds_grid_add_item(Item_Armas.Arco, 1, spr_items_armas);
ds_grid_add_item(Item_Pocoes.PocaoVida, 3, spr_items_pocoes);
ds_grid_add_item(Item_Armas.Arco, 1, spr_items_armas);
ds_grid_add_item(Item_Armas.Arco, 1, spr_items_armas);

// ==== SLOTS EXTRAS ====
extra_slots = [
    [170 * escala, 30 * escala],
    [195 * escala, 45 * escala],
    [172 * escala, 57 * escala]
];

var extras_qtd = array_length(extra_slots);
total_slots += extras_qtd;
ds_grid_resize(grid_items, Infos.Altura, total_slots);

// Inicializa os slots extras como vazios (-1)
for (var i = slots_h * slots_v; i < total_slots; i++) {
    grid_items[# Infos.Item, i] = -1;
    grid_items[# Infos.Quantidade, i] = -1;
    grid_items[# Infos.Sprite, i] = -1;
}
