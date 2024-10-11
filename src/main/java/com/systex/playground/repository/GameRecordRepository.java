package com.systex.playground.repository;

import com.systex.playground.model.GameRecord;
import com.systex.playground.model.Member;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface GameRecordRepository extends JpaRepository<GameRecord, Long> {
	List<GameRecord> findByMember(Member member);
}
