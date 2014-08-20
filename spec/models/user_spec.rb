require 'spec_helper'

describe User do
  
  before(:each) do
   @user = User.create(
      email: 'blemsworth@hotmail.net',
      password: 'brambles',
      password_confirmation: 'brambles'
    )
	end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:mansions).through(:bookings) }
  it { should ensure_length_of(:password) }

  it 'has a name when given one' do
    @user.name = 'Developer'
    expect(@user.name).to eq 'Developer'
  end


end


