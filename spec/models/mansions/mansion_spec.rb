require 'spec_helper'

describe Mansion do
	before(:each) do
		@mansion = Mansion.new
	end

	it 'has a price' do
		@mansion.price = '20'
		expect(@mansion.price).to_not be_nil
	end

	it 'has a description' do
		@mansion.description = 'Hey'
		expect(@mansion.description).to_not be_nil
	end

	it 'has an aoddress' do
		@mansion.address = 'Hey'
		expect(@mansion.address).to_not be_nil
	end

	it 'has a continent' do
		@mansion.continent = 'North America'
		expect(@mansion.continent).to_not be_nil
	end

	it 'has a city' do
		@mansion.city = 'New York'
		expect(@mansion.city).to_not be_nil
	end

	it 'has bedrooms' do
		@mansion.bedroom = 5
		expect(@mansion.bedroom).to_not be_nil
	end

	it 'has bathrooms' do
		@mansion.bathroom = 6
		expect(@mansion.bathroom).to_not be_nil
	end

	it 'has square feet' do
		@mansion.square_foot = 500
		expect(@mansion.square_foot).to_not be_nil
	end
end