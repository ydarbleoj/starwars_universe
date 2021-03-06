require 'rails_helper'

RSpec.describe Person, type: :model do

  context "validations" do
    it { is_expected.to validate_presence_of(:person_id) }
  end
end
