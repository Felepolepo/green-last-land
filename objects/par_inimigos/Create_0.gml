//Movimentação do personagem
randomize();

estado = -1;
prox_estado = 0;

hveloc = 0;
vveloc = 0;
veloc = 0.2;
veloc_perseg = 0.5; //Velocidade para perseguir

dest_x = 0;
dest_y = 0;

alarm[0] = 1;

//Perseguir
dist_aggro = 50; //Distancia para tar perto e perseguir
dist_desaggro = 100; //Distancia para de perseguir

sombra = -1;

//Combate
max_vida =5;
vida = max_vida;
empurrar_dir = 0;
empurrar_veloc = 0;
hit = false;