# Creating 5 users
5.times do |i|
  user = User.create!(
    email: "user#{i + 1}@example.com",
    name: "User #{i + 1}",
    bio: "This is the bio for User #{i + 1}.",
    photo: "https://example.com/user#{i + 1}.jpg"
  )

  # For each user, creating 3 posts
  3.times do |j|
    post = Post.create!(
      title: "Post #{j + 1} by User #{i + 1}",
      body: "This is the body of Post #{j + 1} by User #{i + 1}.",
      author: user
    )

    # For each post, creating 2 comments
    2.times do |k|
      Comment.create!(
        content: "Comment #{k + 1} on Post #{j + 1} by User #{i + 1}",
        user: user,
        post: post
      )
    end

    # For each post, creating 2 likes
    2.times do
      user_for_like = User.where.not(id: user.id).sample
      Like.create!(
        user: user_for_like,
        post: post
      )
    end
  end
end
