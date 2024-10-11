package com.systex.playground.controller;

import com.systex.playground.model.GameRecord;
import com.systex.playground.model.Member;
import com.systex.playground.service.GuessgameService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;

@Controller
public class GameController {

    @Autowired
    private GuessgameService guessgameService;

    @GetMapping("/guess")
    public String showGuessPage(HttpSession session, Model model) {
        return guessgameService.showGuessPage(session, model);
    }

    @PostMapping("/guess")
    public String processGuess(@RequestParam("guessNumber") String guessNumberStr, HttpSession session, Model model) {
        return guessgameService.processGuessAndRecord(guessNumberStr, session, model);
    }
    
    @GetMapping("/guesshistory")
    public String showGuessHistory(HttpSession session, Model model) {
        Member loggedInUser = (Member) session.getAttribute("loggedInUser");
        if (loggedInUser != null) {
            List<GameRecord> gameRecords = guessgameService.getGameRecordsByUser(loggedInUser);
            model.addAttribute("gameRecords", gameRecords);
        }
        return "guessHistory";
    }

}