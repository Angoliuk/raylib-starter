#include "game/utils.hpp"
#include "raylib.h"
#include <cstdlib>
#include <ctime>
#include <filesystem>
#include <iostream>
#include <string>
#include <vector>

struct Card {
  std::string name;
  Texture2D texture;
};

enum RoundResult {
  UNKNOWN,
  TIE,
  PLAYER_ONE,
  PLAYER_TWO
};

const char* gameResultToString(RoundResult result) {
  switch (result) {
  case RoundResult::TIE:
    return "It's a tie!";
  case RoundResult::PLAYER_ONE:
    return "You win!";
  case RoundResult::PLAYER_TWO:
    return "AI wins!";
  default:
    return "Unknown Result";
  }
}

class Player {
public:
  std::vector<Card> availableCards = {
    {"Rock", LoadTexture("assets/rock.png")},
    {"Paper", LoadTexture("assets/paper.png")},
    {"Scissors", LoadTexture("assets/scissors.png")},
    {"Rock", LoadTexture("assets/rock.png")},
    {"Paper", LoadTexture("assets/paper.png")}};

private:
  ~Player() {
    for (const auto& card : availableCards) {
      UnloadTexture(card.texture);
    }
  };
};

class AI {
public:
  std::vector<Card> availableCards = {
    {"Rock", LoadTexture("assets/rock.png")},
    {"Paper", LoadTexture("assets/paper.png")},
    {"Scissors", LoadTexture("assets/scissors.png")},
    {"Rock", LoadTexture("assets/rock.png")},
    {"Paper", LoadTexture("assets/paper.png")}};

  Card getAIChoice() {
    int randomIndex = rand() % availableCards.size();
    return availableCards[randomIndex];
  }

private:
  ~AI() {
    for (const auto& card : availableCards) {
      UnloadTexture(card.texture);
    }
  };
};

class Game {
public:
  const int roundsTotal = 3;
  int roundsPlayed = 0;
  RoundResult roundResult;
  RoundResult finalResult;
  bool roundEnded = false;
  int playerScore = 0;
  int aiScore = 0;
  Card playerCard;
  Card aiCard;

  RoundResult determineRoundWinner(const Card& playerCard, const Card& aiCard) {
    if (playerCard.name == aiCard.name)
      return RoundResult::TIE;
    if ((playerCard.name == "Rock" && aiCard.name == "Scissors") ||
        (playerCard.name == "Scissors" && aiCard.name == "Paper") ||
        (playerCard.name == "Paper" && aiCard.name == "Rock")) {
      return RoundResult::PLAYER_ONE;
    }
    return RoundResult::PLAYER_TWO;
  }
};

void removePlayerCard(std::vector<Card>& cards, const Card& chosenCard) {
  for (auto it = cards.begin(); it != cards.end(); ++it) {
    if (it->name == chosenCard.name) {
      cards.erase(it);
      return;
    }
  }
}

bool isMouseOverText(int x, int y, int width, int height) {
  Vector2 mousePosition = GetMousePosition();
  return (mousePosition.x >= x && mousePosition.x <= x + width &&
          mousePosition.y >= y && mousePosition.y <= y + height);
}

bool isMouseOverTexture(int x, int y, int width, int height) {
  Vector2 mousePosition = GetMousePosition();
  return (mousePosition.x >= x && mousePosition.x <= x + width &&
          mousePosition.y >= y && mousePosition.y <= y + height);
}

int main() {
  InitWindow(800, 600, "Rock Paper Scissors with Cards");
  SetTargetFPS(30);
  srand(static_cast<unsigned>(time(0)));

  auto player = new Player();
  auto ai = new AI();
  auto game = new Game();

  while (!WindowShouldClose()) {
    if (!game->roundEnded) {
      for (int i = 0; i < player->availableCards.size(); i++) {

        Rectangle destRec = {static_cast<float>(20) + i * 150, 20, 100, 100};
        DrawTexturePro(player->availableCards[i].texture, {0, 0, static_cast<float>(player->availableCards[i].texture.width), static_cast<float>(player->availableCards[i].texture.height)}, destRec, {0, 0}, 0.0f, WHITE);

        if (isMouseOverTexture(destRec.x, destRec.y, destRec.width, destRec.height) && IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {
          game->playerCard = player->availableCards[i];
          removePlayerCard(player->availableCards, game->playerCard);
          game->aiCard = ai->getAIChoice();
          game->roundResult = game->determineRoundWinner(game->playerCard, game->aiCard);

          if (game->roundResult == RoundResult::PLAYER_ONE) {
            game->playerScore++;
          } else if (game->roundResult == RoundResult::PLAYER_TWO) {
            game->aiScore++;
          }

          game->roundsPlayed++;
          game->roundEnded = true;
          break;
        }
      }
    } else {

      if (game->roundsPlayed < game->roundsTotal) {
        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {
          game->roundEnded = false;
          game->roundResult = RoundResult::UNKNOWN;
        }
      } else {

        if (game->playerScore > game->aiScore) {
          game->finalResult = RoundResult::PLAYER_ONE;
        } else if (game->aiScore > game->playerScore) {
          game->finalResult = RoundResult::PLAYER_TWO;
        } else {
          game->finalResult = RoundResult::TIE;
        }

        if (IsMouseButtonPressed(MOUSE_LEFT_BUTTON)) {

          player = new Player();
          ai = new AI();
          game = new Game();
        }
      }
    }

    BeginDrawing();
    ClearBackground(RAYWHITE);

    for (int i = 0; i < player->availableCards.size(); i++) {
      Rectangle sourceRec = {0, 0, static_cast<float>(player->availableCards[i].texture.width), static_cast<float>(player->availableCards[i].texture.height)};
      Rectangle destRec = {static_cast<float>(20) + i * 150, 20, 100, 100};
      DrawTexturePro(player->availableCards[i].texture, sourceRec, destRec, {0, 0}, 0.0f, WHITE);
    }

    if (game->roundEnded) {
      DrawText(gameResultToString(game->roundResult), 20, 150, 40, BLACK);

      Rectangle playerSourceRec = {0, 0, static_cast<float>(game->playerCard.texture.width), static_cast<float>(game->playerCard.texture.height)};
      Rectangle playerDestRec = {20, 250, 100, 100};
      DrawTexturePro(game->playerCard.texture, playerSourceRec, playerDestRec, {0, 0}, 0.0f, WHITE);

      Rectangle aiSourceRec = {0, 0, static_cast<float>(game->aiCard.texture.width), static_cast<float>(game->aiCard.texture.height)};
      Rectangle aiDestRec = {220, 250, 100, 100};
      DrawTexturePro(game->aiCard.texture, aiSourceRec, aiDestRec, {0, 0}, 0.0f, WHITE);
    }

    if (game->roundsPlayed >= game->roundsTotal) {
      DrawText(gameResultToString(game->finalResult), 20, 350, 40, BLACK);
    }

    EndDrawing();
  }

  CloseWindow();
  return 0;
}
