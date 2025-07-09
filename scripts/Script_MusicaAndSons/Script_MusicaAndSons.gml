function Script_MusicaAndSons(musica_id) {
    if (musica_atual != musica_id) {
        // Só para se global.musica_id já existir e estiver tocando
        if (variable_global_exists("musica_id") && audio_is_playing(global.musica_id)) {
            audio_stop_sound(global.musica_id);
        }

        musica_atual = musica_id;
        global.musica_id = audio_play_sound(musica_atual, 1, true);
        audio_sound_gain(global.musica_id, global.vol_bgm, 0);
    }
}
