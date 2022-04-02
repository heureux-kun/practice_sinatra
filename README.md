# practice_sinatra
## memoアプリ起動方法

### sinatraのインストール（インストールされていない場合）
`bundle add sinatra --skip-install`

### プロジェクトディレクトリに移動
`cd (プロジェクトディレクトリ)`

### gemのインストール
`bundle install --path vendor/bundle`

### データベース（postgres）への接続
`psql -U postgres`
### データベースの作成
`postgres=# CREATE DATABASE sinatra_memo`
### 作成したデータベースへの接続
`postgres=# psql -U sinatra_memo`
### テーブルの作成
`sinatra_memo=# CREATE TABLE sinatra_memo_table ( id text, title text, body text);`
### テーブルへの接続ユーザーの作成
`sinatra_memo=#  CREATE USER role_sample WITH LOGIN PASSWORD 'password'`
#### 作成したユーザーにSuperuserの権限付与
`ALTER USER role_sample WITH SUPERUSER;`

### アプリを起動
`bundle exec ruby app.rb`

を実行した後、

`http://localhost:4567/にアクセス`