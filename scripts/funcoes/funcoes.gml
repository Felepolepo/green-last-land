function fim_da_animacao(){
	// Pega o sprite e o índice atual da imagem (quadro)
	var _sprite = sprite_index;
	var _image = image_index;
	
	if(argument_count > 0) _sprite = argument[0];
	if(argument_count > 1) _image = argument[1];
	
	// Determina o tipo de velocidade (frames por segundo ou multiplicador)
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index)*image_speed; 
	if(_type == spritespeed_framespersecond)
	    _spd = _spd/room_speed;
	if(argument_count > 2) _spd = argument[2];
	return _image + _spd >= sprite_get_number(_sprite);
	
}
	
function draw_text_color_outline(_x, _y, _texto, _dist, _qtd, _cor_borda, _largura, _espaco) {
    var _cor_original = draw_get_color(); // Salva a cor atual de desenho
    draw_set_color(_cor_borda);          // Define a cor da borda

    // Desenha o texto várias vezes em volta, criando a borda
    for (var i = 0; i < 360; i += 360 / _qtd) {
        var dx = round(lengthdir_x(_dist, i)); // deslocamento X circular
        var dy = round(lengthdir_y(_dist, i)); // deslocamento Y circular
        draw_text_ext(_x + dx, _y + dy, _texto, _largura, _espaco);
    }

    // Restaura a cor original e desenha o texto "real"
    draw_set_color(_cor_original);
    draw_text_ext(_x, _y, _texto, _largura, _espaco);
}

function ds_grid_add_item() {
	
    var _grid = obj_inventario.grid_items;     // Referência à grid de inventário
    var _checagem = 0;                         // Começa verificando o primeiro slot
    
    // Procura o primeiro slot vazio (onde item == -1)
    while (_checagem < obj_inventario.total_slots && _grid[# Infos.Item, _checagem] != -1) {
        _checagem++;
    }
    // Se encontrou um slot disponível
    if (_checagem < obj_inventario.total_slots)/*Verifica se tem Slot*/ {
        _grid[# Infos.Item, _checagem] = argument0;
        _grid[# Infos.Quantidade, _checagem] = argument1;
        _grid[# Infos.Sprite, _checagem] = argument2;
    } else {
        // Nenhum espaço disponível
        show_debug_message("Inventário cheio! Não foi possível adicionar o item.");
    }
}
