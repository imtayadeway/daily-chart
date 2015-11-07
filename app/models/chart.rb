class Chart < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :submissions

  accepts_nested_attributes_for :items

  def item_names
    items.map(&:name)
  end
end
