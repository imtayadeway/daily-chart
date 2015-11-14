# == Schema Information
#
# Table name: items
#
#  id       :integer          not null, primary key
#  name     :string
#  chart_id :integer
#

class Item < ActiveRecord::Base
  belongs_to :chart
end
