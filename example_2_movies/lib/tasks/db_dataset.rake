require 'csv'
require 'date'

namespace :db do
  desc "Loads genres to db from the GroupLens Movies dataset"
  task :load_genres, [:path]  => :environment  do |t, args|
    args.with_defaults(:path => ".")

    begin
      puts "Loading genres into DB..."
      genres = CSV.read(File.join(args.path, 'movie_genres.dat'), { col_sep: "\t",
                                                          encoding: 'windows-1251:utf-8' })
      genres.shift
      Genre.delete_all

      genres.each do |movie_genre|
        genre = Genre.find_or_initialize_by_name(movie_genre[1])
        genre.save!

        movie = Movie.find(movie_genre[0].to_i)
        movie.genres << genre
        movie.save!
      end

      puts "#{Genre.count} genres added"
    rescue Exception => e
      puts e
    end
  end

  desc "Loads movies to db from the GroupLens Movies dataset"
  task :load_movies, [:path]  => :environment  do |t, args|
    args.with_defaults(:path => ".")

    begin
      puts "Loading movies into DB..."
      movies = CSV.read(File.join(args.path, 'movies.dat'), { col_sep: "\t",
                                                          encoding: 'windows-1251:utf-8' })

      movies.shift
      Movie.delete_all
      ActiveRecord::Base.connection.execute("TRUNCATE genres_movies")

      movies.each do |movie|
       Movie.create!({ :id => movie[0],
                                   :title => movie[1],
                                   :release_date => movie[5],
                                   :rt_id => movie[6],
                                   :rt_poster => movie[20]
        }) if movie[0]

        #movie.each_with_index do |property, i|
        #  if i.between?(5, 23) and property != "0"
        #    new_movie.genres << Genre.find(i - 5)
        #    new_movie.save!
        #  end
        #end
      end

      puts "#{Movie.count} movies added"
    rescue Exception => e
      puts e
    end
  end

  desc "Loads preferences to db from the GroupLens Movies dataset"
  task :load_preferences, [:path]  => :environment  do |t, args|
    args.with_defaults(:path => ".")

    begin
      puts "Loading preferences into DB..."
      preferences = CSV.read(File.join(args.path, 'user_ratedmovies.dat'),
                             { col_sep: "\t", encoding: 'utf-8' })

      preferences.shift
      Preference.delete_all

      preferences.each_with_index do |preference, i|
        # e.g. DateTime.parse("2011-05-19 10:30:14")
        created_at = DateTime.parse("#{preference[5]}-#{preference[4]}-#{preference[3]} #{preference[6]}:#{preference[7]}:#{preference[8]}")

        ActiveRecord::Base.connection.execute(
            "INSERT INTO preferences VALUES (#{i + 1},
                                             #{preference[0]},
                                             #{preference[1]},
                                             #{preference[2]},
                                             '#{created_at}',
                                             '#{created_at}')"
        )
      end

      ActiveRecord::Base.connection.execute("ALTER SEQUENCE preferences_id_seq RESTART WITH #{Preference.count + 1}")

      puts "#{Preference.count} preferences added"
    rescue Exception => e
      puts e
    end
  end

  desc "Loads all data from the GroupLens Movies dataset"
  task :load_all_data, [:path] => :environment do |t, args|
    args.with_defaults(:path => ".")

    Rake::Task['db:load_movies'].invoke(args.path)
    Rake::Task['db:load_genres'].invoke(args.path)
    Rake::Task['db:load_preferences'].invoke(args.path)
  end
end