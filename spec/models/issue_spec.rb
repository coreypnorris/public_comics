require 'spec_helper'

describe Issue do
  it { should validate_presence_of :number }
  it { should validate_presence_of :title_id }

  it { should belong_to :title }
  it { should belong_to :user }
end
