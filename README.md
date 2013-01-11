# Jruby Mahout Examples
This repo contains examples for [Jruby Mahout gem](https://github.com/vasinov/jruby_mahout).

## Example #1
Basic JRuby Mahout Example

## Example #2
Custom recommendation engine.

### Setup
#### 1. Download the dataset
#### 2. Import data with a rake file:
```
jruby -S -J-Xmx1024m rake db:load_preferences["/path_to/hetrec2011-movielens-2k"]
```