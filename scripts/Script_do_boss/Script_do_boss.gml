// Escolhe aleatoriamente um ataque do boss para executar
function scr_boss_escolher_ataque() {
    if alarm[0] <= 0 {
        // Escolhe aleatoriamente entre ataque1 e ataque2
        var _ataque = choose(scr_boss_ataque1, scr_boss_ataque2);
        estado = _ataque; // Define o novo estado do boss como o ataque escolhido
        alarm[0] = 240;   // Delay antes de poder escolher outro ataque (4 segundos)
    }
}

// Função: scr_boss_ataque1
// Dispara 5 rajadas de 8 projéteis em círculo com variação de ângulo
function scr_boss_ataque1() {
    var _dir;

    // Alterna a rotação do padrão de disparo entre execuções (0° ou 22.5°)
    if ataques mod 2 == 1 {
        _dir = 0;
    } else {
        _dir = 22.5;
    }

    // Executa apenas se ainda houver rajadas para disparar
    if ataques > 0 {
        if alarm[1] <= 0 {
            // Dispara 8 projéteis em círculo (360° / 8 = 45° entre cada um)
            repeat(8) {
                var _inst = instance_create_layer(x, y, "Instances", obj_boss_projetil);
                _inst.speed = 2;
                _inst.direction = _dir;
                _dir += 45;
            }

            ataques -= 1;    // Reduz o número de rajadas restantes
            alarm[1] = 30;   // Espera 0.5 segundos antes da próxima rajada
        }
    } else {
        // Quando acabar as rajadas, volta ao estado de escolher ataque
        estado = scr_boss_escolher_ataque;
        ataques = 5; // Reinicia o contador de rajadas
    }
}

// Função: scr_boss_ataque2
// Cria 6 áreas de ataque em posições aleatórias ao redor do boss
function scr_boss_ataque2() {
    repeat(6) {
        var _xx = irandom_range(x - 100, x + 100); // Posição aleatória no eixo X ao redor do boss
        var _yy = irandom_range(y - 100, y + 100); // Posição aleatória no eixo Y ao redor do boss
        instance_create_layer(_xx, _yy, "Instances", obj_boss_ataque_1); // Cria a área de ataque
    }

    estado = scr_boss_escolher_ataque; // Retorna ao estado de escolha de ataque
}
