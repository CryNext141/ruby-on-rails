class Movie < ApplicationRecord
  GENRES = %W[action comedy drama horror romance thriller sci-fi western].freeze

  has_many :comments, as: :commentable

  validates :title,:year_of_creation, presence: true
  validates :title, uniqueness: {scope: %i[duration]}
  validates :description, length: { minimum: 10 }
  validate :genres_validation

  private

  def genres_validation
    unless
    genres.is_a?(Array) && genres.any? { |g| g.present? }
      errors.add(:genres, 'At least one must be selected')
    end
  end
end