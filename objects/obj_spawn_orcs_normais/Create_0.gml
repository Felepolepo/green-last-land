/*
30 minutos em frames (supondo 60 FPS):
30 minutos = 30 * 60 segundos = 1800 segundos
frames = 1800 * 60 = 108000 frames

Spawnar 3 orcs de uma vez a cada 108000 frames.
*/

spawn_interval = 9000;  // 30 minutos em frames (60 FPS)
spawn_timer = spawn_interval;
