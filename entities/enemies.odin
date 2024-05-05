package entities

Enemy::struct {
    x: i32,
    y: i32,
    width: i32,
    height: i32,
    speed: int,
    isActive: bool,
}

InitEnemy::proc(screenWidth, screenHeight: i32, x, y: i32, width:= i32(50), height:=i32(50), speed:=25) -> ^Enemy {
    enemy:= new(Enemy)
    enemy.x = x
    enemy.y = y
    enemy.width = width
    enemy.height = height
    enemy.speed = speed
    enemy.isActive = true
    return enemy
}