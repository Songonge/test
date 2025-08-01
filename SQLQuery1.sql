SELECT *
FROM [dbo].[spotify_history]
;

SELECT * INTO spotify_streams
FROM [dbo].[spotify_history]
;

SELECT *
FROM [dbo].spotify_streams
;

SELECT 
	track_url,
	ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, ms_played, track_name, 
	artist_name, album_name, reason_start, reason_end, shuffle, skipped ORDER BY track_url
	) AS row_num
FROM [dbo].spotify_streams
;

SELECT 
	track_url FROM (
		SELECT
			track_url,
			ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform, 
			ms_played, track_name, artist_name, album_name, reason_start, 
			reason_end, shuffle, skipped ORDER BY track_url
			) AS row_num
		FROM spotify_streams
	) track
WHERE row_num > 1
;

SELECT 
	row_num 
from(
	SELECT 
		track_url, 
		ROW_NUMBER() OVER (PARTITION BY track_url, ts, platform,
		ms_played, track_name, artist_name, album_name, 
		reason_start, reason_end, shuffle, skipped ORDER BY track_url
		) AS row_num 
	FROM [dbo].spotify_streams
	) dup_rows
where row_num >1;
