import 'dart:io';

bool gameEnded = false;
bool isXTurn = true;
int turns = 0;

List<String> board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

// مجموعة مربعات الفوز
List<List<int>> winGroups = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
];

void main() {
  while (true) {
    resetGame();
    playGame();
    print("do you want to play again? (Yes / No)");
    String? again = stdin.readLineSync();
    if (again != 'yes') {
      break;
    }
  }
}

//لاعادة اللعبة لحالتها الاصلية قبل اللعب
void resetGame() {
  board = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  gameEnded = false;
  isXTurn = true;
  turns = 0;
}

//لاظهار بورد اللعبة
void showBoard() {
  print("\n ${board[0]} | ${board[1]} | ${board[2]}");
  print("---+---+---");
  print(" ${board[3]} | ${board[4]} | ${board[5]}");
  print("---+---+---");
  print(" ${board[6]} | ${board[7]} | ${board[8]}\n");
}

//للتحقق بعد كل حركة من اللاعبين ان كان اللاعب فاز
bool isWinner(String player) {
  for (var group in winGroups) {
    if (board[group[0]] == player &&
        board[group[1]] == player &&
        board[group[2]] == player) {
      return true;
    }
  }
  return false;
}

//فنكشن اللعبة
void playGame() {
  while (!gameEnded) {
    showBoard();
    String currentPlayer = isXTurn ? 'X' : 'O';
    print("Player $currentPlayer turn ,  choose a number from 1 to 9:");
    String? input = stdin.readLineSync();

    if (input == null) {
      print("invaliad try again ");
      continue;
    }
    //للتحقق من صحة المدخل الذي ادخله اللاعب
    int? index = int.tryParse(input);
    if (index == null ||
        index < 1 ||
        index > 9 ||
        board[index - 1] == 'X' ||
        board[index - 1] == 'O') {
      print("Invaliad , try anoter number ");
      continue;
    }

    //لوضع رمز اللاعب في المربع الذي اختاره ثم زيادة كاونتر اللعبة
    board[index - 1] = currentPlayer;
    turns++;

    if (isWinner(currentPlayer)) {
      showBoard();
      print("the winner is $currentPlayer!");
      gameEnded = true;
    } else if (turns == 9) {
      showBoard();
      print("The game ended in a draw");
      gameEnded = true;
    } else {
      isXTurn = !isXTurn;
    }
  }
}
