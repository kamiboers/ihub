require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:image_path) }
  it { is_expected.to validate_uniqueness_of(:uid) }
  it { is_expected.to validate_uniqueness_of(:username) }
end
