# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#


def seed_img(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/#{file_name}.jpg"))
end

User.create!(email: 'user1@gmail.com', password: 'password', username: 'username1')
User.create!(email: 'user2@gmail.com', password: 'password', username: 'username2')
Group.create!(created_by: 1, group_name: 'Mario', group_image: seed_img('wow'))
UserGroup.create!(user_id: 1, group_id: 1)
Group.create!(created_by: 2, group_name: 'Mario2', group_image: seed_img('wow'))
UserGroup.create!(user_id: 2, group_id: 2)
Announcement.create!(title: 'Sprzedam opla', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 Proin nibh augue, suscipit a, scelerisque sed, lacinia in, mi. Cras vel lorem. Etiam pellentesque aliquet tellus.
 Phasellus pharetra nulla ac diam. Quisque semper justo at risus. Donec venenatis, turpis vel hendrerit interdum,
 dui ligula ultricies purus, sed posuere libero dui id orci. Nam congue, pede vitae dapibus aliquet,
 elit magna vulputate arcu, vel tempus metus leo non est. Etiam sit amet lectus quis est congue mollis.', user_id: 2,
                    group_id: 2, exp_date: Date.tomorrow)
Announcement.create!(title: 'Kupie opla', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 Proin nibh augue, suscipit a, scelerisque sed, lacinia in, mi. Cras vel lorem. Etiam pellentesque aliquet tellus.
 Phasellus pharetra nulla ac diam. Quisque semper justo at risus. Donec venenatis, turpis vel hendrerit interdum,
 dui ligula ultricies purus, sed posuere libero dui id orci. Nam congue, pede vitae dapibus aliquet,
 elit magna vulputate arcu, vel tempus metus leo non est. Etiam sit amet lectus quis est congue mollis.', user_id: 1,
                     group_id: 1, exp_date: Date.tomorrow)
Comment.create!(announcement_id: 1, user_id: 1, content: 'Za ile?')
Comment.create!(announcement_id: 2, user_id: 2, content: 'Test')

