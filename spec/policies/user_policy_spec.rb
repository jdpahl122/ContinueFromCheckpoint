require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject(:user_policy) { described_class.new(current_user, user) }

  describe 'A logged-in user' do
    let(:current_user) { create(:user) }
    let(:user) { create(:user) }

    it { should permit_actions([:index, :show]) }
    it { should_not permit_actions([:update_role, :update, :remove_avatar]) }
  end

  describe 'A user that is not logged in' do
    let(:current_user) { nil }
    let(:user) { create(:user) }

    it { should permit_actions([:index, :show]) }
    it { should_not permit_actions([:update_role, :update, :remove_avatar]) }
  end

  describe 'A user that is an moderator' do
    let(:current_user) { create(:moderator) }
    let(:user) { create(:user) }

    it { should permit_actions([:index, :show]) }
    it { should_not permit_actions([:update_role, :update, :remove_avatar]) }
  end

  describe 'A user that is an admin' do
    let(:current_user) { create(:admin) }
    let(:user) { create(:user) }

    it { should permit_actions([:index, :show, :update_role]) }
    it { should_not permit_actions([:update, :remove_avatar]) }
  end

  describe 'A user editing/looking at their own profile' do
    let(:current_user) { create(:user) }
    let(:user) { current_user }

    it { should permit_actions([:index, :show, :update, :remove_avatar]) }
    it { should_not permit_actions([:update_role]) }
  end
end
