package com.systex.playground.controller;

import com.systex.playground.service.LotteryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class LotteryController {

    @Autowired
    private LotteryService lotteryService;

    @GetMapping("/lottery")
    public String showLotteryPage() {
        return "lottery";
    }

    @PostMapping("/lottery")
    public String generateLotteryNumbers(
            @RequestParam(value = "excludeNumbers", required = false) String excludeNumbersStr,
            @RequestParam(value = "loopCount", required = false) String loopCountStr,
            HttpSession session,
            Model model) {

        List<Integer> excludeNumbers = new ArrayList<>();
        StringBuilder errorMessage = new StringBuilder();

        // 使用 LotteryService 產生號碼
        List<List<Integer>> results = lotteryService.generateLotteryNumbers(excludeNumbersStr, loopCountStr, excludeNumbers, errorMessage);

        if (results == null) {
            model.addAttribute("error", errorMessage.toString());
            return "lottery";
        }

        session.setAttribute("lotteryResults", results);

        return "redirect:/lotteryResult?page=1";
    }

    @GetMapping("/lotteryResult")
    public String showLotteryResult(
            @RequestParam(value = "page", defaultValue = "1") int page,
            HttpSession session,
            Model model) {

        List<List<Integer>> results = (List<List<Integer>>) session.getAttribute("lotteryResults");
        if (results == null) {
            model.addAttribute("error", "No lottery results found. Please generate numbers first.");
            return "lottery";
        }

        // 每頁顯示的組數
        int pageSize = 8;
        int totalResults = results.size();
        int totalPages = (int) Math.ceil((double) totalResults / pageSize);

        // 頁碼校驗
        if (page < 1) {
            page = 1;
        } else if (page > totalPages) {
            page = totalPages;
        }

        // 計算頁碼開始和結束index
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalResults);

        // 獲取當前頁的結果
        List<List<Integer>> currentPageResults = results.subList(startIndex, endIndex);

        model.addAttribute("currentPageResults", currentPageResults);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "lotteryResult";
    }
} 