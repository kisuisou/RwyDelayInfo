require 'sqlite3'

def returnInfo
db=SQLite3::Database.new 'delayInfo.db'
info = db.execute('SELECT * FROM infoTable')
return info
end
