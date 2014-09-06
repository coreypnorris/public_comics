require 'spec_helper'

describe Title do
  it { should validate_presence_of :name }

  it { should have_many :issues }
  it { should belong_to :genre }
end
