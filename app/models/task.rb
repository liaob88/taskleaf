class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate  :name_not_include_comma

  private
  def name_not_include_comma
    errors.add(:name, :name_not_include_comma) if name&.include?(',')
  end
end
