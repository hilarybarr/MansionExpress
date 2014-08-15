# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mansion do
    name "MyString"
    description "MyText"
    address "MyString"
    continent "MyString"
    city "MyString"
    bedrooms 1
    bathrooms 1
    square_feet 1
    available_date "2014-08-15"
  end
end
