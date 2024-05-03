package main

import "core:fmt"
import "vendor:raylib"

main :: proc() {
	fmt.printf("hellope")

	using raylib

	InitWindow(1280, 960, "Shavaders v.0.01dev")
	
	DisableCursor()

	for !WindowShouldClose() {
		BeginDrawing()
		ClearBackground(WHITE)
		EndDrawing()
	}
	defer CloseWindow()
}