package com.systex.playground.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class GameRecord {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "member_id", nullable = false)
    private Member member;

    private int count; // 遊戲記錄，本專案目前尚未用到，未來可以進行其他功能的擴展
    private LocalDateTime time; // 遊玩時間
    private int result; // 遊戲結果 (1 表示猜對, 0 表示猜錯)

    public GameRecord() {
    }

    public GameRecord(Member member, int count, LocalDateTime time, int result) {
        this.member = member;
        this.count = count;
        this.time = time;
        this.result = result;
    }

    // Getters and setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
    

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }
}
