require 'spec_helper'

describe Booking do
  it { should belong_to(:user) }
  it { should belong_to(:mansion) }
end
