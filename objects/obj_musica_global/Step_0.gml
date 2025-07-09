var musica_desejada;

// Prioridade da música por contexto
if (room == RoomCorrompido) {
    musica_desejada = Musica_BiomaCorrompido;
}
else if (instance_exists(obj_boss_brocolis)) {
    musica_desejada = Musica_Boss_Brocolis;
}
else {
    musica_desejada = Musica_Padrao;
}

// Toca a música se for diferente da atual
Script_MusicaAndSons(musica_desejada);
