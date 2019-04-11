# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.create(id: 10, username: 'testing', email: 'test@test.com', created_at: '2019-04-04 02:45:29.311840', updated_at: '2019-04-05 02:26:11.261509', password_digest: '$2a$10$G9rb4n5/fDaXOV9H5RNawuJlZbPRUq9ekFOobkhoSZTch8Avba6um', admin: true)
articles = Article.create(id: 10, title: 'test article', description: 'test description', created_at: '2019-04-04 02:45:29.311840', updated_at: '2019-04-05 02:26:11.261509', user_id: 10)
comments = Comment.create(context: 'test context', created_at: '2019-04-04 02:45:29.311840', updated_at: '2019-04-05 02:26:11.261509', user_id: 10, article_id: 10)
tags = Tag.create(id: 10, name: "Office", created_at: '2019-04-04 02:45:29.311840', updated_at: '2019-04-05 02:26:11.261509')
article_tags = ArticleTag.create(article_id: 10, tag_id: 10)