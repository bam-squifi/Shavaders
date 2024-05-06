package game

import "core:fmt"
import "vendor:raylib"
import "entities"

Bullet :: struct {
	x: i32,
	y: i32,
	isVisible: bool,
}

createBullet::proc(player: ^entities.Player) -> ^Bullet {
	bullet := new(Bullet)
	bullet.x = player.position.x + player.size.x /2
	bullet.y = player.position.y - player.size.y / 2
	return bullet
}

drawBullet::proc(bullet_ptr: ^Bullet) {
	raylib.DrawRectangle(bullet_ptr.x, bullet_ptr.y, 5, 10, raylib.GREEN)
	bullet_ptr.isVisible = true
}

main :: proc() {
	using raylib

	InitWindow(1280, 960, "Shavaders v.0.01dev")
	defer CloseWindow()

	screenWidth: i32 = GetScreenWidth()
	screenHeight: i32 = GetScreenHeight()
	
	player: ^entities.Player =  entities.InitPlayer(screenWidth, screenHeight)
	defer free(player)

	enemy:= entities.InitEnemy(screenWidth, screenHeight, (screenWidth / 2) - 50, (screenHeight / 9))
	defer free(enemy)


	DisableCursor()
	SetTargetFPS(60)

	bullets: [dynamic]^Bullet
	defer delete(bullets)

	enemies: [dynamic]^entities.Enemy
	defer delete(enemies)

	enemyWidth : i32 = 75

	for i in 3..=7 {
		enemy:= entities.InitEnemy(screenWidth, screenHeight, enemyWidth * i32(i), (screenHeight / 9))
		append(&enemies, enemy)
	}
	
	oldTime:= GetTime()
	newTime: f64
	
	for !WindowShouldClose() {
		BeginDrawing()
		ClearBackground(WHITE)
				
		DrawRectangle(player.position.x, player.position.y, player.size.x, player.size.y, RED)

		// handle enemy creation and removal
		for enemy, index in enemies {
			if enemy.isActive {
				DrawRectangle(enemy.x, enemy.y, enemy.width, enemy.height, BLACK)
				
				// handles direction change
				{
					enemy.x += enemy.direction ? enemy.speed : enemy.speed * -1
					if enemy.x + enemy.width >= screenWidth * 8 / 9 ||
					enemy.x - enemy.width <= screenWidth / 9 {
						enemy.y += enemy.height * 2
						enemy.direction = !enemy.direction
					}
				}
			} else {
				unordered_remove(&enemies, index)
				defer free(enemy)
				// fmt.printf("Removing Enemy at index %d", index)
			}
		}
		

		if IsKeyDown(.LEFT) || IsKeyDown(.A) {
			player.position.x -= player.speed
			} 
		if IsKeyDown(.RIGHT) || IsKeyDown(.D) {
			player.position.x += player.speed
		}
		
		if IsKeyPressed(.SPACE) {
			currentBullet_ptr := createBullet(player)
			append(&bullets, currentBullet_ptr)
			drawBullet(currentBullet_ptr)
		}

		if len(bullets) > 0 {
			for bullet_ptr, index in bullets {
				
				bullet_ptr.y -= 10

				// remove bullets if off screen
				if bullet_ptr.y <= 0 || !bullet_ptr.isVisible {
					unordered_remove(&bullets, index)
					defer free(bullet_ptr)
					// fmt.printf("Removing bullet at index %d", index)
				} else {
					// check collision of bullet and enemy
					for enemy, index in enemies {
						if enemy.isActive
						{
							if bullet_ptr.x + 5 >= enemy.x && bullet_ptr.x <= enemy.x + enemy.width && 
							bullet_ptr.y + 10 >= enemy.y && bullet_ptr.y <= enemy.y + enemy.height
							{
								enemy.isActive = false
								bullet_ptr.isVisible = false
							}
						}
					}

					if bullet_ptr.isVisible { 
						drawBullet(bullet_ptr) 
					} 
				}
			}
		}

		

		// Timing function if we need it?
		if newTime - oldTime >= 0.5 {
			oldTime = GetTime()
		}

		if player.position.x < player.size.x {
			player.position.x = player.size.x
		}

		if player.position.x >= screenWidth - player.size.x * 2 {
			player.position.x = screenWidth - player.size.x * 2
		}

		newTime = GetTime()

		EndDrawing()
	}
}