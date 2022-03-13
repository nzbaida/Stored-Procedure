USE album;

DROP PROCEDURE IF EXISTS list_albums;
DELIMITER //
CREATE PROCEDURE list_albums ()
BEGIN
	SELECT * FROM album;
    SELECT * FROM track;
END //
DELIMITER ;

CALL list_albums();

DROP PROCEDURE IF EXISTS list_albums;
DELIMITER //
CREATE PROCEDURE list_albums (param VARCHAR(255))
	BEGIN 
		SELECT a.artist AS artist,
				a.title AS album,
				t.title AS track,
				t.track_number AS trackno,
				track_len(t.duration) AS length
			FROM track AS t
			JOIN album AS a
				ON a.id = t.album_id
			WHERE a.artist LIKE param
			ORDER BY artist, album, trackno
		;
	END //
DELIMITER ;

call list_albums('%hendrix%');

DROP PROCEDURE IF EXISTS total_duration;

DELIMITER //
CREATE PROCEDURE total_duration (param VARCHAR(255), OUT outp VARCHAR(255))
	BEGIN
		SELECT track_len(SUM(duration)) INTO outp
			FROM track
            WHERE album_id IN (SELECT id FROM album WHERE artist LIKE param)
		;
	END //
DELIMITER ;

CALL total_duration('%hendrix%', @dur);
SELECT @dur;

SHOW FUNCTION STATUS WHERE DEFINER LIKE 'admin%';
SHOW PROCEDURE STATUS WHERE DEFINER LIKE 'admin%';

DROP FUNCTION IF EXISTS track_len;
DROP PROCEDURE IF EXISTS total_duration;
	