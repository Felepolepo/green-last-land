global.load_pending = false;
global.load_room = "";

if (!variable_global_exists("vol_bgm")) global.vol_bgm = 1;
if (!variable_global_exists("vol_sfx")) global.vol_sfx = 1;


menu_principal = ["Jogar","Carregar save" , "Opções", "Sair"];
menu_opcoes = ["Resolução: 1280x720", "Modo Tela: Janela", "Volume Música: 100%","Volume Sons: 100%", "Voltar"];

escala = [];
modo_opcoes = false;

resolucoes = ["800x600", "1280x720", "1920x1080"];
res_index = 1;

modo_carregar_save = false;
saves_info = [];
save_slots = ["save_slot1.ini", "save_slot2.ini", "save_slot3.ini"];


for (var i = 0; i < array_length(menu_principal); i++) escala[i] = 1;
