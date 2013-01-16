# This still persists for some reason:
# https://github.com/jruby/activerecord-jdbc-adapter/issues/159

module ActiveRecord::ConnectionAdapters
  class JdbcAdapter < AbstractAdapter
    def explain(query, *binds)
      ActiveRecord::Base.connection.execute("EXPLAIN #{query}", 'EXPLAIN', binds)
    end
  end
end