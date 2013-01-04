# Jruby Mahout Examples
This repo contains examples for [Jruby Mahout gem](https://github.com/vasinov/jruby_mahout).

## Example #1
Basic JRuby Mahout Example

## Example #2
Custom recommendation engine.

### Setup
#### 1. Run `setup.sql` in psql:
```
\i setup.sql
```

#### 2. Copy the contents of `ratings.dat` to `dating_preferences`:
```
\COPY movies_preferences FROM '/path_to_file/u.data' (DELIMITER '	');
```

This will take up to 30 minutes.