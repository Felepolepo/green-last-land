// Herdando do pai
event_inherited();

// Create Event de obj_npc_greg

// Controle de diálogo
em_dialogo = false;
dialogo_etapa = 0;
dialogo_finalizado = false;

// Estado da missão
missao_ativa = false;
missao_concluida = false;
kill_slime = 0; // Contador de slimes mortos na missão

// Dados da missão
missao_nome = "Matar Slimes";
missao_tipo = "matar";
missao_objetivo = "obj_slime"; // Nome do objeto inimigo
missao_quantidade = 3;          // Quantidade necessária para concluir

// Recompensas da missão
missao_recompensa_xp = 100;
missao_recompensa_item = [Item_Armas.Arco, spr_items_armas]; // [índice do item, sprite do item]
missao_recompensa_quantidade = 1;

// Nome do NPC
npc_nome = "Greg";

// Diálogo da missão - array de strings para mostrar passo a passo
missao_falas = [
    "Oi, aventureiro!",
    "Você poderia me ajudar a matar 3 slimes?",
    "Volte aqui quando terminar."
];

