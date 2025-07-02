function ScriptNPC_IniciarConversa(_npc) {
    with (_npc) {
        if (missao_estado == 0) {
            show_message_async("Olá, eu sou " + npc_nome + ".\nTenho uma missão: " + missao_nome + "\nVocê aceita? (Y/N)");
        } else if (missao_estado == 1) {
            show_message_async("Missão em andamento!\nObjetivo: " + string(missao_quantidade) + "x " + missao_objetivo);
        } else if (missao_estado == 2) {
            ScriptNPC_EntregarMissao(id);
        }
    }
}
function ScriptNPC_AtualizarMissao(_inimigo_nome) {
    // Procura todos NPCs com missão ativa
    with (par_npc) {
        if (missao_estado == 1 && missao_tipo == "matar" && missao_objetivo == _inimigo_nome) {
            missao_quantidade -= 1;
            if (missao_quantidade <= 0) {
                missao_estado = 2;
            }
        }
    }
}
function ScriptNPC_EntregarMissao(_npc) {
    with (_npc) {
        show_message_async("Parabéns! Você concluiu a missão: " + missao_nome);
        
        // XP
        obj_personagem.xp += missao_recompensa_xp;

        // Item (usa sprite + índice do enum)
        if (missao_recompensa_item != -1 && is_array(missao_recompensa_item)) {
            var _item = missao_recompensa_item[0];   // índice no enum
            var _sprite = missao_recompensa_item[1]; // sprite
            ds_grid_add_item(_item, missao_recompensa_quantidade, _sprite);
        }

        missao_estado = -1; // missão entregue
    }
}

	// Aceitar/Recusar missão com Y/N
if keyboard_check_pressed(ord("Y")) {
    with (par_npc) {
        if (pode_falar && missao_estado == 0) {
            missao_estado = 1;
            show_message_async("Missão aceita: " + missao_nome);
        }
    }
}

if keyboard_check_pressed(ord("N")) {
    with (par_npc) {
        if (pode_falar && missao_estado == 0) {
            show_message_async("Talvez outra hora então.");
        }
    }
}
