function Script_menu_Pause(){
/// pausar_objeto(padrao_image_speed)
if (global.pausado) {
    image_speed = 0;
    exit;
} else {
    image_speed = argument0;
}

}