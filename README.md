## memoアプリ起動方法

### sinatraのインストール（インストールされていない場合）
`bundle add sinatra --skip-install`

### プロジェクトディレクトリに移動
`cd (プロジェクトディレクトリ)`

### gemのインストール
`bundle install --path vendor/bundle`

### アプリを起動
`bundle exec ruby app.rb`

を実行した後、

`http://localhost:4567/にアクセス`