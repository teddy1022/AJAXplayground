package com.systex.playground.service;

import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class LotteryService {

    public List<List<Integer>> generateLotteryNumbers(String excludeNumbersStr, String loopCountStr, List<Integer> excludeNumbers, StringBuilder errorMessage) {
        int loopCount = validateInputs(excludeNumbersStr, loopCountStr, excludeNumbers, errorMessage);
        if (loopCount == -1) {
            return null;
        }

        List<List<Integer>> results = new ArrayList<>();
        for (int i = 0; i < loopCount; i++) {
            Set<Integer> lotteryNumbers = generateLotteryNumbers(excludeNumbers);
            results.add(new ArrayList<>(lotteryNumbers));
        }
        return results;
    }

    private int validateInputs(String excludeNumbersStr, String loopCountStr, List<Integer> excludeNumbers, StringBuilder errorMessage) {
        int loopCount = 1;
        boolean hasError = false;

        try {
            loopCount = Integer.parseInt(loopCountStr);
            if (loopCount <= 0 || loopCount > 500) {
                hasError = true;
                errorMessage.append("Loop Count must be a positive integer between 1 and 500.<br>");
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessage.append("Loop Count must be a valid integer between 1 and 500.<br>");
        }

        if (excludeNumbersStr != null && !excludeNumbersStr.trim().isEmpty()) {
            String[] numbers = excludeNumbersStr.trim().split("\\s+");
            for (String numStr : numbers) {
                try {
                    int num = Integer.parseInt(numStr);
                    if (num < 1 || num > 49) {
                        hasError = true;
                        errorMessage.append("Excluded numbers must be between 1 and 49.<br>");
                        break;
                    }
                    excludeNumbers.add(num);
                } catch (NumberFormatException e) {
                    hasError = true;
                    errorMessage.append("Excluded numbers must be valid integers separated by spaces.<br>");
                    break;
                }
            }
        }

        return hasError ? -1 : loopCount;
    }

    private Set<Integer> generateLotteryNumbers(List<Integer> excludeNumbers) {
        Set<Integer> lotteryNumbers = new TreeSet<>();
        Random random = new Random();

        while (lotteryNumbers.size() < 6) {
            int number = random.nextInt(49) + 1;
            if (!excludeNumbers.contains(number)) {
                lotteryNumbers.add(number);
            }
        }

        return lotteryNumbers;
    }
}