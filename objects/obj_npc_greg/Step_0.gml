// Herda o evento pai
event_inherited();

// Variável para checar proximidade do personagem
pode_falar = (distance_to_object(obj_personagem) <= 48);

// Abrir diálogo ao apertar F, se perto, não estiver em diálogo e missão não ativa
if (pode_falar && keyboard_check_pressed(ord("F")) && !em_dialogo && !missao_ativa) {
    em_dialogo = true;
    dialogo_etapa = 0;
    dialogo_finalizado = false;
}

// Controle do diálogo
if (em_dialogo) {
    // Avançar diálogo com Enter ou Z
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("Z"))) {
        if (!dialogo_finalizado) {
            if (dialogo_etapa < array_length(missao_falas) - 1) {
                dialogo_etapa++;
            } else {
                dialogo_finalizado = true;
            }
        }
    }

    // Após diálogo, aceitar ou recusar missão com Y ou N
    if (dialogo_finalizado) {
        if (keyboard_check_pressed(ord("Y"))) {
            missao_ativa = true;
            em_dialogo = false;
            dialogo_finalizado = false;
            show_debug_message("Missão aceita!");
            kill_slime = 0; // Resetar contador
        } else if (keyboard_check_pressed(ord("N"))) {
            em_dialogo = false;
            dialogo_finalizado = false;
            show_debug_message("Missão recusada.");
        }
    }
}

// Verifica se missão está ativa e foi concluída (kill_slime >= missao_quantidade)
if (missao_ativa && !missao_concluida && kill_slime >= missao_quantidade) {
    missao_concluida = true;
    missao_ativa = false;

    // Dar XP ao personagem
    obj_personagem.xp += missao_recompensa_xp;

    // Dar item usando sua função de inventário
    ds_grid_add_item(missao_recompensa_item[0], missao_recompensa_quantidade, missao_recompensa_item[1]);

    show_debug_message("Missão concluída! Ganhou " + string(missao_recompensa_xp) + " XP.");

    if (missao_recompensa_item[0] != -1) {
        show_debug_message("Item recebido.");
    }
}
