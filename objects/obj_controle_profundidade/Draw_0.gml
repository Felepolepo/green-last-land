var _grid = global.grid_profundidade;
var _num = instance_number(par_objetos);

ds_grid_resize(_grid, 2, _num); //mudando o grid para o tamanho de numerode objetos

var i = 0;
with(par_objetos){
	_grid[#0, i] = id; //coluna 1 do grid o Id do obj
	_grid[#1, i] = y; // o Y do obj
	i++;
}

ds_grid_sort(_grid, 1, true);// pra colocar no grid o menor y em baixo

for (var i = 0; i< ds_grid_height(_grid); i++){
	var _inst = _grid[#0 ,i];
	with(_inst){
		draw_self();
		event_perform(ev_draw, 0) //forçar a executar o evento desenhar dele(obj)
	}
}