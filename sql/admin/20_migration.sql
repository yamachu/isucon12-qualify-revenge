# SELECT player_id, MIN(created_at) AS min_created_at FROM visit_history WHERE tenant_id = ? AND competition_id = ? GROUP BY player_id
create index player_id_idx on visit_history(player_id);
create index tenant_id_competition_id_idx on visit_history(tenant_id, competition_id);

# dont use visit_history
DROP TABLE IF EXISTS `min_visit_history`;
CREATE TABLE `min_visit_history` (
  `player_id` VARCHAR(255) NOT NULL,
  `tenant_id` BIGINT UNSIGNED NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL,
  `created_at` BIGINT NOT NULL,
  INDEX `tenant_id_competition_id_idx` (`tenant_id`, `competition_id`),
  UNIQUE `player_id_tenant_id_competition_id_idx` (`tenant_id`, `competition_id`, `player_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

INSERT IGNORE INTO min_visit_history(player_id, tenant_id, competition_id, created_at)
    select player_id, tenant_id, competition_id, MIN(created_at) AS min_created_at FROM visit_history group by player_id, tenant_id, competition_id;

DROP TABLE IF EXISTS `billing_report`;
CREATE TABLE `billing_report` (
  `tenant_id` BIGINT UNSIGNED NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL,
  `competition_title` TEXT,
  `player_count` BIGINT UNSIGNED NOT NULL,
  `visitor_count` BIGINT UNSIGNED NOT NULL,
  `billing_player_yen` BIGINT UNSIGNED NOT NULL,
  `billing_visitor_yen` BIGINT UNSIGNED NOT NULL,
  `billing_yen` BIGINT UNSIGNED NOT NULL,
  UNIQUE `tenant_id_competition_id_idx` (`tenant_id`, `competition_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;

DROP TABLE IF EXISTS `ranking`;
CREATE TABLE `ranking` (
  `tenant_id` BIGINT UNSIGNED NOT NULL,
  `competition_id` VARCHAR(255) NOT NULL,
  `player_id` VARCHAR(255) NOT NULL,
  `player_display_name` TEXT,
  `ranking` BIGINT UNSIGNED NOT NULL,
  `score` BIGINT UNSIGNED NOT NULL,
  INDEX `tenant_id_competition_id_idx` (`tenant_id`, `competition_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8mb4;
