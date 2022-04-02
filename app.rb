# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'

pg_connection = PG.connect( host: 'localhost', user: 'role_sample', password: 'password', dbname: 'sinatra_memo' )

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  redirect to('/memos/')
end

# メモ一覧画面
get '/memos/' do
  @memos = []
  pg_connection.exec( "SELECT * FROM sinatra_memo_table" ) do |result|
    result.each do |row|
      @memos.push(row)
    end
  end
  @memos = @memos.sort_by { |result| result['id'] }.reverse
  erb :index
end

# メモ作成画面表示
get '/memos/new' do
  erb :new
end

# メモ作成
post '/memos/' do
  time = Time.now.strftime('memo_%Y%m%d%H%M%S')
  title = h(params[:title])
  body = h(params[:body])
  pg_connection.exec( "INSERT INTO sinatra_memo_table(id,title,body) VALUES('#{time}','#{title}','#{body}')" )
  
  redirect to('/memos/')
end

# メモ詳細画面
get '/memos/:id' do
  pg_connection.exec( "SELECT * FROM sinatra_memo_table WHERE id = '#{params[:id]}'" ) do |result|
    result.each do |row|
      @memo = row
    end
  end
  erb :show
end

# メモ変更画面表示
get '/memos/:id/edit' do
  pg_connection.exec( "SELECT * FROM sinatra_memo_table WHERE id = '#{params[:id]}'" ) do |result|
    result.each do |row|
      @memo = row
    end
  end
  erb :edit
end

# メモ変更
patch '/memos/:id' do
  title = h(params[:title])
  body = h(params[:body])
  pg_connection.exec( "UPDATE sinatra_memo_table SET title = '#{title}', body = '#{body}' WHERE id = '#{params[:id]}'" )
  redirect to('/memos/')
end

# メモ削除
delete '/memos/:id' do
  pg_connection.exec( "DELETE FROM sinatra_memo_table WHERE id = '#{params[:id]}'" )
  redirect to('/memos/')
end
