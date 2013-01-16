# JRuby Mahout Movies
This is a demo project for the [Jruby Mahout gem](https://github.com/vasinov/jruby_mahout). JRuby Mahout Movies is a website where users can vote for movies, receive recommendations based on their tastes and see similar movies.

This project is currently a work in progress. I am planning to release it and write an article in my blog by January 25, 2013.

## Setup
#### 1. Setup JRuby
#### 2. Run `bundle`
#### 3. Setup migrations:
```
rake db:create
rake db:migrate
```
#### 4. Download the [HetRec 2011 MovieLens dataset](http://www.grouplens.org/system/files/hetrec2011-movielens-2k.zip)
#### 5. Import data with a rake file:
```
jruby -S -J-Xmx1024m rake db:load_all_data["/path_to/hetrec2011-movielens-2k"]
```
#### 6. Start the server:
```
rails s
```