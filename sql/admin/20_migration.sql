# SELECT player_id, MIN(created_at) AS min_created_at FROM visit_history WHERE tenant_id = ? AND competition_id = ? GROUP BY player_id
create index player_id_idx on visit_history(player_id);
create index tenant_id_competition_id_idx on visit_history(tenant_id, competition_id);
