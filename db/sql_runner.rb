require('pg')
class SqlRunner

  def self.run( sql, values = [] )
    begin
      # db = PG.connect({ dbname: 'pill_tracker', host: 'localhost' })
      db = PG.connect( {dbname: 'dbkvufp0fm3q54',
      host: 'ec2-3-229-210-93.compute-1.amazonaws.com',
      port: 5432, user: 'krluevkwxhxrzd', password: '4a37d78256b6b47c53bcf66948e13a969c09fe96eccffdeedddfce0feaa25156'})
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
