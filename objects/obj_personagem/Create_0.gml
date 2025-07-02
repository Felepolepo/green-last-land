//Estado 
estado = ScriptDoPersonagem_Andando;

#region Iniciar

event_inherited();
enum Armas {
    Espada = 0,
    Arco = 1,
    Altura = 2
}


// MOVIMENTAÇÃO
direita  = -1;
cima     = -1;
esquerda = -1;
baixo    = -1;
hveloc = 0;     // Velocidade horizontal
vveloc = 0;     // Velocidade vertical
veloc = 2;          // Velocidade base do personagem
veloc_dir = -1;     // Direção do movimento

// Direção geral (para animações e controle)
dir = 0;


// DASH
dash_dir = -1;
dash_veloc = 6;


// ==============================
// COMBATE / PROGRESSÃO
// Nível e experiência
level = 1;

xp = 0;
max_xp[1] = 100;
max_xp[2] = 120;
max_xp[3] = 150;
max_xp[4] = 200;
max_xp[5] = 300;

// Estamina por nível
max_estamina[1] = 100;
max_estamina[2] = 120;
max_estamina[3] = 130;
max_estamina[4] = 140;
max_estamina[5] = 150;
estamina = max_estamina[level]; // Estamina inicial conforme o nível

// Vida por nível
max_vida[1] = 20;
max_vida[2] = 25;
max_vida[3] = 30;
max_vida[4] = 35;
max_vida[5] = 40;
vida = max_vida[level]; // Vida inicial

// Dano por nível
dano[1] = 3;
dano[2] = 5;
dano[3] = 10;
dano[4] = 15;
dano[5] = 20;

// COMBATE / DANO
tomardano = true;       // Se o personagem pode tomar dano
empurrar_dir = 0;       // Direção em que será empurrado após levar dano
atacar = false;         // Controla a ativação da hitbox

dano_alfa = -1;         // Usado para efeito de piscar ao receber dano

arma = 0;
#endregion Iniciar