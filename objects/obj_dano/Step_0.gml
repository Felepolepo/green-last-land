/// @description Movimento e desaparecimento do dano visual

yy -= 0.25;
alpha -= 0.04;

if (alpha <= 0) {
    instance_destroy();
}
