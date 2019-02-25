require 'rails_helper'

RSpec.describe Game, type: :model do
  subject(:game) { FactoryBot.create(:game) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(game).to be_valid
    end

    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(120) }
    it { should validate_length_of(:description).is_at_most(1000) }

    it { should have_db_column(:earliest_release_date).of_type(:date) }
    it { should have_db_column(:release_dates).of_type(:jsonb) }

    # We don't test the case where it is validated because we use a
    # before_validation callback which fixes the lack of an earliest_release_date
    # before we can check that the game is valid. So shoulda-matchers can't confirm
    # that the validation ever even fails.
    it "does not validate presence of earliest release date when there are no release dates" do
      expect(game).not_to validate_presence_of(:earliest_release_date)
    end
  end

  describe "Associations" do
    it { should have_many(:game_purchases) }
    it { should have_many(:purchasers).through(:game_purchases).source(:user) }

    it { should have_many(:game_developers) }
    it { should have_many(:developers).through(:game_developers).source(:company) }

    it { should have_many(:game_publishers) }
    it { should have_many(:publishers).through(:game_publishers).source(:company) }

    it { should have_many(:game_platforms) }
    it { should have_many(:platforms).through(:game_platforms).source(:platform) }

    it { should have_many(:game_genres) }
    it { should have_many(:genres).through(:game_genres).source(:genre) }

    it { should have_many(:game_engines) }
    it { should have_many(:engines).through(:game_engines).source(:engine) }
  end
end
