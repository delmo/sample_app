=begin
FactoryGirl.define do
 factory :user do
  name "Michael Hartl"
  email "michael@example.com"
  password "foobar"
  password_confirmation "foobar"
 end
end
=end

FactoryGirl.define do
 factory :user do
  sequence(:name) { |n| "Person #{n}" }
  sequence(:email) { |n| "person_#{n}@example.com" }
  password "foobar"
  password_confirmation "foobar"

  factory :admin do
   admin true
  end
 end
end

=begin
use the lines below to access factory girl
before(:all) { 30.times { FactoryGirl.create(:user) }} #to create 30 users
after(:all) { User.delete_all } # delete users that factory girl created
and this block
let(:user) { FactoryGirl.create(:user) }
before(:each) do
 sign_in user
 visit users_path
end
=end

