randomize();

estado = -1;
prox_estado = 0;
orc_pode_atacar = true;
orc_ja_bateu = false;

hveloc = 0;
vveloc = 0;
hveloc_ant = 0;
vveloc_ant = 0;
veloc = 0.2;
veloc_perseg = 0.5;

dest_x = 0;
dest_y = 0;

dist_aggro = 50;
dist_desaggro = 100;

// Valores padrões para serem sobrescritos no filho
vida_default = 40;
dano_default = 8;
sprite_base_default = "orc1";

// Usa as variáveis padrões inicialmente
vida = vida_default;
max_vida = vida_default;
dano = dano_default;
sprite_base = sprite_base_default;

// Última direção do orc — pode ser "cima", "baixo", "esquerda" ou "direita"
ultima_direcao = "baixo";  // valor inicial (exemplo)


empurrar_dir = 0;
empurrar_veloc = 0;
hit = false;

alarm[0] = 1;
