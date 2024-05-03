package main

import "core:fmt"
import "vendor:raylib"

main :: proc() {
	fmt.printf("hellope")

	using raylib

	InitWindow(1280, 960, "Shavaders v.0.01dev")
	
	DisableCursor()

	myVector2D::struct {x, y: i32}

	Player :: struct {
		position: myVector2D,
		size: myVector2D,
		speed: i32,
		lives: i32,
	}

	playerWidth: i32 = 50
	playerHeight: i32 = 20
	playerSpeed: i32 = 10
	playerLives: i32 = 3

	player := Player {
		position = myVector2D{GetScreenWidth()/2, GetScreenHeight() * 8.0 / 9},
		size 	 = myVector2D{playerWidth, playerHeight},
		speed 	 = playerSpeed,
		lives 	 = playerLives,
	}

	SetTargetFPS(60)

	for !WindowShouldClose() {
		BeginDrawing()
		ClearBackground(WHITE)

		screenWidth: i32 = GetScreenWidth()

		DrawRectangle(player.position.x, player.position.y, player.size.x, player.size.y, RED)

		if IsKeyDown(.LEFT) || IsKeyDown(.A) {
			player.position.x -= player.speed
		} 
		if IsKeyDown(.RIGHT) || IsKeyDown(.D) {
			player.position.x += player.speed
		}

		if player.position.x < player.size.x {
			player.position.x = player.size.x
		}

		if player.position.x >= screenWidth - player.size.x * 2 {
			player.position.x = screenWidth - player.size.x * 2
		}

		EndDrawing()
	}
	defer CloseWindow()
}