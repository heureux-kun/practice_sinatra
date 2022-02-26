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

# メモ詳細画面
get '/memos/:id' do
  file_url = "db/#{params['id']}.json"
  @memo = JSON.parse(File.open(file_url,"r").read)
  erb :show
end

# メモ変更画面表示
get '/memos/:id/edit' do
  file_url = "db/#{params['id']}.json"
  @memo = JSON.parse(File.open(file_url,"r").read)
  erb :edit
end

# メモ変更
patch '/memos/:id/edit' do
  file_url = "db/#{params['id']}.json"
  # メモの内容をローカル変数に入れる
  memo = {id: params[:id], title: params[:title], body: params[:body]}
  # ローカル変数の内容でファイルを上書きする
  File.open(file_url, "w") do |file|
    JSON.dump(memo, file)
  end
  redirect to('/memos/') 
end

# メモ削除
delete '/memos/:id' do
  file_url = "db/#{params['id']}.json"
  begin
    File.delete(file_url)
    redirect to('/memos/') 
  rescue
    p 'ファイルを削除できませんでした'
  end
end