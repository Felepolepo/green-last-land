Script_menu_Pause(1); // ou outro valor padrão de velocidade
if (global.pausado) exit; // Ou: return;

script_execute(estado);
par_npc = instance_find(obj_npc_greg, 0); // pega a instância do NPC Greg

//para ele n ser desenhado por de baixo do background
depth = -y;

//Morrer quando acabar a vida
if vida <= 0{
    obj_personagem.xp += 10;
    instance_destroy();
}

