### アプリケーション名
　**F-Tag**
 
### アプリケーションの概要
　**このアプリケーションは何かに挑戦したり努力している若者の手助けをすることを目的とした、投稿共有サービス  
　です。**   
　1. ユーザーが現在挑戦や努力している事に関して投稿します。  
　2. 投稿に共感したユーザーはタッグを組み、タッグコメントとよばれるコメント欄でコミュニケーションを取り合  
　　います。  
　これにより一人では頑張りきれないと感じる事も、他のユーザーの励ましやアドバイスなどによって乗り越えられ  
　るようサポートします。
 
### 工夫した点
- Ajaxを利用することでページ切り替えなどのユーザーのストレスを軽減してユーザビリティを向上させ、加えてサーバーの負荷を軽減させました。  
- モバイルファーストを意識したレスポンシブWebデザインで設計しました。

### デモ
　[サイトはこちらから](https://rails-f-tag.herokuapp.com/)
 
### アプリケーションで使っている技術
- インフラ: heroku  
- データベース: PostgresSQL  
- 開発環境: Docker  
- 言語: Ruby on Rails 5.2.4.2, JavaScript 
- 画像ストレージ: AWS S3  

### アプリケーションの機能
- 認証機能: devise  
- 投稿のCRUD機能: Ajax  
- ユーザーのプロフィール編集機能: Ajax  
- 画像投稿機能: Active Storage, Ajax
- 投稿検索機能: ransack  
- ページネーション機能: kaminari  
- 投稿へのコメント機能（投稿をいいねしたユーザーのみ可能）: Ajax  
- ユーザー同士のフォロー機能: Ajax  
- 投稿へのいいね機能（アプリケーション内ではタッグ機能としている）: Ajax  
