task sample_data: :environment do
  p "Creating sample data"
  if Rails.env.development?
    FollowRequest.destroy_all
    User.destroy_all
    Photo.destroy_all
    Comment.destroy_all
    Like.destroy_all
  end

  names = Array.new
  names << "alice"
  names << "bob"
  12.times do
    names << Faker::Name.first_name
  end
  names.each do |name|
    u = User.create(
      email: "#{name}@example.com",
      username: name.downcase,
      password: "password",
      private: [true, false].sample
    )
  end
  p "#{User.count} users have been created."

  users = User.all
  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        FollowRequest.create(
          recipient: second_user,
          sender: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
      if rand < 0.75
        FollowRequest.create(
          recipient: first_user,
          sender: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end
  p "#{FollowRequest.count} follow requests have been created"

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
      )
    
      user.followers.each do |follower|
        if rand < 0.8
          photo.fans << follower
        end
        if rand < 0.5
          photo.comments.create(
            author: follower,
            body: Faker::Quote.jack_handey
          )
        end
      end
    end
  end
  p "#{Photo.count} photos have been created "
  p "#{Comment.count} comments have been created"
  p "#{Like.count} likes have been created"
end
