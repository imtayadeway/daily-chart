# == Schema Information
#
# Table name: charts
#
#  id      :integer          not null, primary key
#  user_id :integer
#

class Chart < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :submissions, -> { order(:date) }

  accepts_nested_attributes_for :items

  def item_names
    items.map(&:name)
  end

  def submission_pending?
    submissions.pending?
  end

  def scores
    scorables.map(&:score)
  end

  def percentages
    scorables.map(&:percent)
  end
end
