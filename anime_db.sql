DROP DATABASE Anime;
CREATE DATABASE IF NOT EXISTS Anime;
USE Anime;

CREATE TABLE `Anime` (
	-- id from MAL database
	`id` BIGINT UNSIGNED NOT NULL,
    `title` TEXT,
    `start_date` DATETIME,
    `end_date` DATETIME,
    `mean_score` FLOAT,
    `rank` INT UNSIGNED,
    `popularity` INT UNSIGNED,
    `num_list_users` INT UNSIGNED,
    `num_scoring_users` INT UNSIGNED,
    `nsfw` VARCHAR(255),
    `media_type` VARCHAR(255),
    `status` VARCHAR(255),
    `num_episodes` SMALLINT UNSIGNED,
    `season_year` SMALLINT UNSIGNED,
    `season` VARCHAR(255),
    `broadcast_day_of_week` VARCHAR(255),
    `broadcast_start_time` VARCHAR(255),
    `source` VARCHAR(255),
    `average_episode_duration` SMALLINT UNSIGNED,
    `rating` VARCHAR(255),
    `status_watching` MEDIUMINT UNSIGNED, 
    `status_completed`MEDIUMINT UNSIGNED,
    `status_on_hold` MEDIUMINT UNSIGNED,
    `status_dropped` MEDIUMINT UNSIGNED,
    `status_plan_to_watch` MEDIUMINT UNSIGNED,
    `status_num_list_users` MEDIUMINT UNSIGNED,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Studio`(
	-- id from MAL database
	`id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) UNIQUE,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Anime_Studio`(
	`anime_id` BIGINT UNSIGNED NOT NULL,
    `studio_id` BIGINT UNSIGNED NOT NULL,
    CONSTRAINT `Constraint_Anime_Studio_Anime_fk`
		FOREIGN KEY `anime_fk` (`anime_id`) 
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	CONSTRAINT `Constraint_Anime_Studio_Studio_fk`
		FOREIGN KEY `studio_fk` (`studio_id`)
        REFERENCES `Studio` (`id`)
        ON DELETE CASCADE,
	PRIMARY KEY (`anime_id`, `studio_id`)
);

CREATE TABLE `Genre`(
	-- id from MAL database
	`id` BIGINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) UNIQUE,
	PRIMARY KEY (`id`)
);

CREATE TABLE `Anime_Genre`(
	`anime_id` BIGINT UNSIGNED NOT NULL,
    `genre_id` BIGINT UNSIGNED NOT NULL,
	CONSTRAINT `Constraint_Anime_Genre_Anime_fk`
		FOREIGN KEY `anime_fk` (`anime_id`) 
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	CONSTRAINT `Constraint_Anime_Genre_Genre_fk`
		FOREIGN KEY `genre_fk` (`genre_id`)
        REFERENCES `Genre` (`id`)
        ON DELETE CASCADE,
	PRIMARY KEY (`anime_id`, `genre_id`)
);

CREATE TABLE `Related_Anime`(
	`anime_id` BIGINT UNSIGNED NOT NULL,
    `parent_anime_id` BIGINT UNSIGNED NOT NULL,
	-- 1 if prequel, 0 if side story or other
	`relation_prequel` BIT,
	CONSTRAINT `Constraint_Related_Anime_Anime_fk`
		FOREIGN KEY (`anime_id`) 
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	CONSTRAINT `Constraint_Related_Anime_Parent_Anime_fk`
		FOREIGN KEY (`parent_anime_id`)
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	PRIMARY KEY (`anime_id`, `parent_anime_id`)
);

CREATE TABLE `MAL_Anime_Recommendation`(
	`anime_id` BIGINT UNSIGNED NOT NULL,
    `recommended_anime_id` BIGINT UNSIGNED NOT NULL,
	`num_recommendations` INT UNSIGNED,
	CONSTRAINT `Constraint_MAL_Anime_Recommendation_Anime_fk`
		FOREIGN KEY (`anime_id`) 
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	CONSTRAINT `Constraint_MAL_Anime_Recommendation_Recommended_Anime_fk`
		FOREIGN KEY (`recommended_anime_id`)
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	PRIMARY KEY (`anime_id`, `recommended_anime_id`)
);

CREATE TABLE `User`(
	-- id NOT from MAL database. Would require additional requests and user_id is not needed.
	`id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`username` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `List_Entry`(
	`anime_id` BIGINT UNSIGNED NOT NULL,
    `user_id` BIGINT UNSIGNED NOT NULL,
    `status` VARCHAR(255),
    `score` FLOAT,
    `num_episodes_watched` INT UNSIGNED,
    `updated_at` DATETIME,
    `start_date` DATETIME,
    `finish_date` DATETIME,
	CONSTRAINT `Constraint_List_Entry_Anime_fk`
		FOREIGN KEY (`anime_id`) 
        REFERENCES `Anime` (`id`)
        ON DELETE CASCADE,
	CONSTRAINT `Constraint_List_Entry_User_fk`
		FOREIGN KEY (`user_id`)
        REFERENCES `User` (`id`)
        ON DELETE CASCADE,
	PRIMARY KEY (`anime_id`, `user_id`)
);

-- INSERT INTO Anime (id) VALUES (52034);
-- INSERT INTO User (id) VALUES (69);

-- SELECT * FROM List_Entry;

