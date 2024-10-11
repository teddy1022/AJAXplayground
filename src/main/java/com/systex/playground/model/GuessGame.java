package com.systex.playground.model;

import java.time.LocalDateTime;

public class GuessGame {
    private int remains;
    private int luckyNumber;
    private int totalAttempts; // 總猜測次數
    private LocalDateTime startTime; // 遊戲開始時間
    private boolean gameOver; // 標誌遊戲是否已經結束
    private boolean win; // 標誌用戶是否猜中

    public GuessGame(int range, int remains) {
        this.remains = remains;
        this.luckyNumber = (int) (Math.random() * range) + 1;
        this.totalAttempts = 0;
        this.startTime = LocalDateTime.now();
        this.gameOver = false;
        this.win = false;
    }
    

    public boolean guess(int number) {
        if (remains > 0 && !gameOver) {
            totalAttempts++;
            remains--;

            if (number == luckyNumber) {
                win = true;
                gameOver = true;
                return true;
            }

            if (remains == 0) {
                gameOver = true; // 當次數用盡，遊戲結束
            }
        }
        return false;
    }

    public int getRemains() {
        return remains;
    }

    public String getHint(int number) {
        if (number > luckyNumber) {
            return "Too high! Try a smaller number.";
        } else if (number < luckyNumber) {
            return "Too low! Try a larger number.";
        } else {
            return "Correct!";
        }
    }

    public int getTotalAttempts() {
        return totalAttempts;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public boolean isGameOver() {
        return gameOver;
    }

    public boolean isWin() {
        return win;
    }

	public int getLuckyNumber() {
		// TODO Auto-generated method stub
		return this.luckyNumber;
	}
}
