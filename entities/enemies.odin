package entities

Enemy::struct {
    x: i32,
    y: i32,
    width: i32,
    height: i32,
    speed: i32,
    isActive: bool,
    direction: bool
}

InitEnemy::proc(screenWidth, screenHeight: i32, x, y: i32, width:= i32(50), height:=i32(50), speed:=i32(4)) -> ^Enemy {
    enemy:= new(Enemy)
    enemy.x = x
    enemy.y = y
    enemy.width = width
    enemy.height = height
    enemy.speed = speed
    enemy.isActive = true
    enemy.direction = true
    return enemy
}