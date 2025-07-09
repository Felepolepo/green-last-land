// obj_menu_pausa - Create Event
global.pausado = false;

visivel = false;
modo_opcoes = false;
modo_ajuda = false;

menu_principal = ["Continuar Jogo", "Salvar Jogo", "Carregar Jogo", "Ajuda","Configurações" , "Voltar pro Menu"];
menu_opcoes = ["Resolução: 1280x720","Modo Tela: Janela","Volume Música: 100%", "Volume Sons: 100%","Voltar"];
volume_bgm = 1;
volume_sfx = 1;

resolucoes = ["800x600", "1280x720", "1920x1080"];
res_index = 1;

modo_carregar_save = false;
modo_salvar_save = false;

saves_info = [];
save_slots = ["save_slot1.ini", "save_slot2.ini", "save_slot3.ini"];


escala = [];
for (var i = 0; i < array_length(menu_principal); i++) escala[i] = 1;
