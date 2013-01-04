CREATE TABLE movies_preferences (
  user_id BIGINT NOT NULL,
  item_id BIGINT NOT NULL,
  rating int NOT NULL,
  created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, item_id)
);

CREATE INDEX movies_preferences_user_id_index ON movies_preferences (user_id);
CREATE INDEX movies_preferences_item_id_index ON movies_preferences (item_id);