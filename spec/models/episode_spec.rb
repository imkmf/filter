require 'spec_helper'

describe Episode do
  it { should belong_to(:podcast) }
end
