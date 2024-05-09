class Movie < ApplicationRecord
  GENRES = %w[action comedy drama horror romance thriller sci-fi western].freeze

  has_many :comments, as: :commentable
  has_many :favorites, dependent: :destroy # Додано обробник залежності для автоматичного видалення пов'язаних улюблених записів

  validates :title, :year_of_creation, presence: true
  validates :title, uniqueness: { scope: [:duration] }
  validates :description, length: { minimum: 10 }
  validate :genres_validation

  private

  def genres_validation
    unless genres.is_a?(Array) && genres.any?(&:present?)
      errors.add(:genres, 'At least one must be selected')
    end
  end

  def self.search(query)
    where("title ILIKE ? OR director ILIKE ? OR ? = ANY(genres)", "%#{query}%", "%#{query}%", query)
  end
end
