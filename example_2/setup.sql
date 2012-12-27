CREATE TABLE dating_preferences (
  user_id BIGINT NOT NULL,
  item_id BIGINT NOT NULL,
  rating int NOT NULL,
  PRIMARY KEY (user_id, item_id)
);

CREATE INDEX dating_preferences_user_id_index ON dating_preferences (user_id);
CREATE INDEX dating_preferences_item_id_index ON dating_preferences (item_id);