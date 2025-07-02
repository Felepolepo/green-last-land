if (obj_personagem.y < y + sprite_height / 2) {
    draw_set_alpha(0.5); // Transparente
} else {
    draw_set_alpha(1); // Normal
}

draw_self(); // Desenha a árvore com o alpha escolhido
draw_set_alpha(1); // Resetar alpha pra não afetar outros objetos
