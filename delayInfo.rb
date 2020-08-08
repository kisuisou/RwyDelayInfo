require 'net/http'
require 'uri'
require 'json'
require 'sqlite3'

URL = 'https://tetsudo.rti-giken.jp/free/delay.json'
uri = URI.parse(URL)

json = Net::HTTP.get(uri)
result = JSON.parse(json)

db = SQLite3::Database.new 'delayInfo.db'
db.execute('DELETE FROM infoTable')

result.each do |data|
  if data[:name] == ""
    next
  end
  sql = <<-SQL
  INSERT INTO infoTable(name,company,lastupdate_gmt) VALUES
  (?,?,?);
  SQL
  db.execute(sql,data["name"],data["company"],data["lastupdate_gmt"].to_i)
end
puts 'success'
