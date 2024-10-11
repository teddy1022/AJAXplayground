package com.systex.playground.service;

import com.systex.playground.model.GameRecord;
import com.systex.playground.model.GuessGame;
import com.systex.playground.model.Member;
import com.systex.playground.repository.GameRecordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class GuessgameService {

    @Autowired
    private GameRecordRepository gameRecordRepository;

    public String showGuessPage(HttpSession session, Model model) {
        GuessGame game = (GuessGame) session.getAttribute("guessGame");
        if (game == null) {
            game = new GuessGame(10, 3);
            session.setAttribute("guessGame", game);
            session.setAttribute("correctAnswer", game.getLuckyNumber());

        }
        model.addAttribute("remains", game.getRemains());
        return "guess";
    }
    
    public List<GameRecord> getGameRecordsByUser(Member user) {
        return gameRecordRepository.findByMember(user);
    }


    public String processGuessAndRecord(String guessNumberStr, HttpSession session, Model model) {
        GuessGame game = (GuessGame) session.getAttribute("guessGame");
        Member member = (Member) session.getAttribute("loggedInUser");

        if (game == null || member == null) {
            return "redirect:/guess?error=invalid";
        }

        try {
            int guessNumber = Integer.parseInt(guessNumberStr);
            boolean isCorrect = game.guess(guessNumber);
            int result = isCorrect ? 1 : 0;

            

            // 返回對應的結果頁面
            if (isCorrect) {
                session.removeAttribute("guessGame");
                session.removeAttribute("hint");
             // 記錄遊戲結果到資料庫
                GameRecord record = new GameRecord(member,  1, LocalDateTime.now(), result);
                gameRecordRepository.save(record);
                return "youWin";
            } else if (game.getRemains() <= 0) {
                session.removeAttribute("guessGame");
                session.removeAttribute("hint");
             // 記錄遊戲結果到資料庫
                GameRecord record = new GameRecord(member,  1, LocalDateTime.now(), result);
                gameRecordRepository.save(record);
                return "youLose";
            } else {
                String hint = game.getHint(guessNumber);
                session.setAttribute("hint", hint);
                model.addAttribute("remains", game.getRemains());
                return "guess";
            }
        } catch (NumberFormatException e) {
            return "redirect:/guess?error=invalid";
        }
    }
}
