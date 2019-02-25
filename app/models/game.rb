class Game < ApplicationRecord
  include PgSearch

  # Update the earliest release date before validating.
  before_validation :update_earliest_release_date, if: :release_dates?

  has_many :game_purchases
  has_many :purchasers, through: :game_purchases, source: :user

  has_many :game_developers
  has_many :developers, through: :game_developers, source: :company

  has_many :game_publishers
  has_many :publishers, through: :game_publishers, source: :company

  has_many :game_platforms
  has_many :platforms, through: :game_platforms, source: :platform

  has_many :game_genres
  has_many :genres, through: :game_genres, source: :genre

  has_many :game_engines
  has_many :engines, through: :game_engines, source: :engine

  has_one_attached :cover

  validate :release_dates_platforms_should_match_platforms,
    if: -> (game) { game.release_dates.present? || game.platforms.present? }

  validates :name,
    presence: true,
    length: { maximum: 120 }

  validates :description,
    length: { maximum: 1000 }

  validates :cover,
    attached: false,
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 4.megabytes }

  # Only require earliest_release_date if release_dates has data.
  validates :earliest_release_date,
    presence: { if: :release_dates? }

  pg_search_scope :search,
    against: [:name],
    using: {
      tsearch: { prefix: true }
    }

  private

  # Get the earliest release date from the release_dates attribute.
  def update_earliest_release_date
    self.earliest_release_date = release_dates.map { |x| x['release_date'] }.min
  end

  # Make sure each platform has a corresponding release date.
  def release_dates_platforms_should_match_platforms
    release_date_platform_ids = release_dates.map { |x| x['platform_id'] }.to_set
    platform_ids = platforms.map { |x| x[:id] }.to_set

    puts "release_date_platform_ids: #{release_date_platform_ids}, platform_ids: #{platform_ids}"

    errors.add(:release_dates, "must correspond to platforms") if platform_ids != release_date_platform_ids
  end
end
