require 'sinatra'
require 'sinatra/reloader'
require "json"


get '/' do
  redirect to('/memos/') 
end

# メモ一覧画面
get '/memos/' do
  @memos = Dir.glob('db/*.json').map do |file|
    JSON.parse(File.open(file,"r").read)
  end
  @memos = @memos.sort_by{ |file| file['id']}.reverse
  erb :index
end

# メモ作成画面表示
get '/memos/new' do
  erb :new
end

# メモ作成
post '/memos/' do
  # メモの内容をローカル変数に入れる
  time = Time.now.strftime("memo_%Y%m%d%H%M%S")
  memo = {id: time, title: params[:title], body: params[:body]}
  # ローカル変数の内容をファイルを新規作成して入れる
  File.open("db/#{time}.json", "w") do |file|
    JSON.dump(memo, file)
  end
  redirect to('/memos/') 
end

# メモ変更画面
get '/memos/:id/edit' do
  file_url = "db/#{params['id']}.json"
  @memo = JSON.parse(File.open(file_url,"r").read)
  erb :edit
end

# メモ変更）
post '/memos/:id/' do
  erb :show
end

# メモ詳細画面
get '/memos/:id' do
  file_url = "db/#{params['id']}.json"
  @memo = JSON.parse(File.open(file_url,"r").read)
  erb :show
end

# メモを削除した後の一覧画面
post '/memos/' do
  erb :index
end