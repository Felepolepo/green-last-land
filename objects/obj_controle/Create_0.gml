if (!variable_global_exists("load_pending")) global.load_pending = false;
if (!variable_global_exists("load_slot")) global.load_slot = "save_checkpoint.ini"; // ou outro nome
if (!variable_global_exists("save_slot")) global.save_slot = "save_checkpoint.ini"; // para autosave padrão

global.checkpoint_room = "";
global.checkpoint_x = 0;
global.checkpoint_y = 0;
global.checkpoint_id = -1;
