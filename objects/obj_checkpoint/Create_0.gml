// Inherit the parent event
event_inherited();

ativo = true;

// Garante que o ID é único por instância e sala
var room_name = room_get_name(room);
var checkpoint_id = room_name + "_" + string(id);

// Verifica se este checkpoint estava ativo no save
if (ini_open("save_checkpoint.ini")) {
    var salvo = ini_read_real("Checkpoints", checkpoint_id, 0);
    ini_close();

    if (salvo == 1) {
        sprite_index = spr_fogueira_queimando; // mantém a fogueira acesa
        ativo = false; // impede salvar de novo
    }
}

