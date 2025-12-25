package com.example.Qlykhachsan.Repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.Qlykhachsan.Model.Rooms;

@Repository
public interface RoomRepository extends JpaRepository<Rooms, Integer> {
	Page<Rooms> findBystatusroom(String statusroom, Pageable pageable);

	@Query(value = "SELECT TOP 4 * FROM room r " + "WHERE r.price_room BETWEEN :minPrice AND :maxPrice "
			+ "AND r.room_id != :currentId " + "AND r.status_room = N'Trống' ", nativeQuery = true)
	List<Rooms> findRelatedRooms(@Param("minPrice") double minPrice, @Param("maxPrice") double maxPrice,
			@Param("currentId") int currentId);

	@Query(value = "SELECT * FROM room r WHERE r.type_room LIKE N'%' + :keyword + N'%' OR r.description LIKE N'%' + :keyword + N'%'", nativeQuery = true)
	List<Rooms> searchRooms(@Param("keyword") String keyword);
}
