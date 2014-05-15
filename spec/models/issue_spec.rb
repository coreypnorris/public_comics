require 'spec_helper'

describe Issue do
  it { should validate_presence_of :number }
  it { should validate_presence_of :cover }

  it { should belong_to :title }
end
