require 'spec_helper'

describe Page do
  it { should validate_presence_of :number }
  it { should validate_uniqueness_of(:number).scoped_to(:issue_id) }

  it { should belong_to :issue }
end
