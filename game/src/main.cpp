#include "raylib.h"

int main() {
  InitWindow(800, 600, "Raylib Example");

  SetTargetFPS(60);

  while (!WindowShouldClose()) {
    BeginDrawing();
    ClearBackground(RAYWHITE);
    DrawText("Hello, Raylib!", 200, 200, 20, DARKGRAY);
    EndDrawing();
  }

  CloseWindow();

  return 0;
}
