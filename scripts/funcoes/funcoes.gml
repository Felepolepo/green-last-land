function fim_da_animacao(){
	var _sprite = sprite_index;
	var _image = image_index;
	if(argument_count > 0) _sprite = argument[0];
	if(argument_count > 1) _image = argument[1];
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index)*image_speed;
	if(_type == spritespeed_framespersecond)
	    _spd = _spd/room_speed;
	if(argument_count > 2) _spd = argument[2];
	return _image + _spd >= sprite_get_number(_sprite);
	

	//Dono do codigo: PixellatedPope e Minty Python
}
	
function draw_text_color_outline(_x, _y, _texto, _dist, _qtd, _cor_borda, _largura, _espaco) {
    var _cor_original = draw_get_color();
    draw_set_color(_cor_borda);

    for (var i = 0; i < 360; i += 360 / _qtd) {
        var dx = round(lengthdir_x(_dist, i));
        var dy = round(lengthdir_y(_dist, i));
        draw_text_ext(_x + dx, _y + dy, _texto, _largura, _espaco);
    }

    draw_set_color(_cor_original);
    draw_text_ext(_x, _y, _texto, _largura, _espaco);
}

function ds_grid_add_item() {
    /// @arg Item
    /// @arg Quantidade
    /// @arg Sprite
    
    var _grid = obj_inventario.grid_items;
    var _checagem = 0;
    
    // Enquanto o slot não estiver vazio e não passou do total de slots
    while (_checagem < obj_inventario.total_slots && _grid[# Infos.Item, _checagem] != -1) {
        _checagem++;
    }
    
    // Se ainda tem espaço no inventário
    if (_checagem < obj_inventario.total_slots) {
        _grid[# Infos.Item, _checagem] = argument0;
        _grid[# Infos.Quantidade, _checagem] = argument1;
        _grid[# Infos.Sprite, _checagem] = argument2;
    } else {
        // Inventário cheio, pode adicionar uma mensagem ou ignorar
        show_debug_message("Inventário cheio! Não foi possível adicionar o item.");
    }
}
