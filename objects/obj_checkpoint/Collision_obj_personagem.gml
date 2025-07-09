if (ativo) {
    ativo = false;

    // Salva o jogo
    global.save_slot = "save_checkpoint.ini";
    scr_salvar_jogo(global.save_slot);

    // Salva visualmente qual fogueira está acesa
    if (ini_open(global.save_slot)) {
        ini_section_delete("Checkpoints"); // limpa outros checkpoints se quiser só um ativo
        var room_name = room_get_name(room);
        var checkpoint_id = room_name + "_" + string(id); // ID único por sala + instancia
        ini_write_real("Checkpoints", checkpoint_id, 1);
        ini_close();
    }

    show_debug_message("Checkpoint salvo.");
    alarm[0] = room_speed; // 1 segundo para acender
}
