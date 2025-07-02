var _dano = 4;
var _dir = point_direction(x,y, other.x,other.y);

other.empurrar_dir = _dir;
other.empurrar_veloc = 6;
other.hit = true;
other.alarm[1] = 5;
other.estado = ScriptSlime_Hit;
other.vida -= _dano;

instance_destroy();