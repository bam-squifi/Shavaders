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

}


main :: proc() {
	using raylib

	InitWindow(1280, 960, "Shavaders v.0.01dev")

	screenWidth: i32 = GetScreenWidth()
	screenHeight: i32 = GetScreenHeight()
	player: ^entities.Player =  entities.InitPlayer(screenWidth, screenHeight)
	defer free(player)

	DisableCursor()
	SetTargetFPS(60)

	bullets: [dynamic]^Bullet
	defer delete(bullets)
	
	oldTime:= GetTime()
	newTime: f64
	
	for !WindowShouldClose() {
		BeginDrawing()
		ClearBackground(WHITE)


				
		DrawRectangle(player.position.x, player.position.y, player.size.x, player.size.y, RED)
		
		if IsKeyDown(.LEFT) || IsKeyDown(.A) {
			player.position.x -= player.speed
			} 
			if IsKeyDown(.RIGHT) || IsKeyDown(.D) {
				player.position.x += player.speed
			}
		
		
		if IsKeyPressed(.SPACE) {
			currentBullet_ptr := createBullet(player)
			append(&bullets, currentBullet_ptr)
			fmt.printf("Bullet size: %d", len(&bullets))
			DrawRectangle(currentBullet_ptr.x, currentBullet_ptr.y, 5, 10, GREEN)
		}		

		if len(bullets) > 0 {
			for bullet_ptr in bullets {
				bullet_ptr.y -= 10
				if bullet_ptr.y <= 0 {
					ordered_remove(&bullets, 0)
					defer free(bullet_ptr)
				} else {
					DrawRectangle(bullet_ptr.x, bullet_ptr.y, 5, 10, GREEN)
				}
			}
		}

		// We have our time function working nicely, just have to limit the shots to the time and not the isShot
		// Have fun tomorrow with this :D
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
	defer free(player)
	defer CloseWindow()
}