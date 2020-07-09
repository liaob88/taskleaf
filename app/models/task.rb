class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate  :name_not_include_comma

  belongs_to :user
  scope :recent, -> { order(created_at: :desc)}

  def self.ransackable_attributes(auth_objecct = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
  
  private
  def name_not_include_comma
    errors.add(:name, :name_not_include_comma) if name&.include?(',')
  end
end
