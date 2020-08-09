require 'net/http'
require 'uri'
require 'json'
require 'sqlite3'

URL = 'https://tetsudo.rti-giken.jp/free/delay.json'
uri = URI.parse(URL)

response = Net::HTTP.get_response(uri)

unless response.code == '200' 
  puts 'Failed to get JSON'
  exit
end

result = JSON.parse(response.body)

db = SQLite3::Database.new 'delayInfo.db'
db.execute('DELETE FROM infoTable')

result.each do |data|
  if data["name"] == ""
    next
  end
  sql = <<-SQL
  INSERT INTO infoTable(name,company,lastupdate_gmt) VALUES
  (?,?,?);
  SQL
  db.execute(sql,data["name"],data["company"],data["lastupdate_gmt"].to_i)
end

puts 'success'
