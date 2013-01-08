require 'csv'

namespace :db do
  desc "Loads movies to db from GroupLens Movies dataset"
  task :load_genres, [:path]  => :environment  do |t, args|
    args.with_defaults(:path => ".")

    begin
      puts "Loading genres into DB..."
      genres = CSV.read(File.join(args.path, 'u.genre'), { col_sep: "|",
                                                          encoding: 'windows-1251:utf-8' })
      Genre.delete_all

      genres.each do |genre|
        Genre.create!({ :id => genre[1], :name => genre[0] }) if genre[1]
      end

      puts "#{Genre.count} genres added"
    rescue Exception => e
      puts e
    end
  end

  task :load_movies, [:path]  => :environment  do |t, args|
    args.with_defaults(:path => ".")

    begin
      puts "Loading movies into DB..."
      movies = CSV.read(File.join(args.path, 'u.item'), { col_sep: "|",
                                                          encoding: 'windows-1251:utf-8' })
      Movie.delete_all
      ActiveRecord::Base.connection.execute("TRUNCATE genres_movies")

      movies.each do |movie|
        new_movie = Movie.create!({ :id => movie[0],
                                   :title => movie[1],
                                   :release_date => movie[2],
                                   :imdb_url => movie[4]
        }) if movie[0]

        movie.each_with_index do |property, i|
          if i.between?(5, 23) and property != "0"
            new_movie.genres << Genre.find(i - 5)
            new_movie.save!
          end
        end
      end

      puts "#{Movie.count} movies added"
    rescue Exception => e
      puts e
    end
  end

  task :load_users, [:path]  => :environment  do |t, args|
    args.with_defaults(:path => ".")

    begin
      puts "Loading users into DB..."
      users = CSV.read(File.join(args.path, 'u.user'), { col_sep: "|",
                                                          encoding: 'windows-1251:utf-8' })
      User.delete_all

      users.each do |user|
        User.create!({ :id => user[0],
                      :age => user[1],
                      :email => "foo-#{user[0]}@bar.com",
                      :password => "foobar",
                      :gender => user[2],
                      :occupation => user[3],
                      :zip => user[4],
        }) if user[0]
      end

      puts "#{User.count} users added"
    rescue Exception => e
      puts e
    end
  end

  desc "Loads all data from GroupLens Movies dataset"
  task :load_all_data => [:load_genres, :load_movies, :load_users]
end