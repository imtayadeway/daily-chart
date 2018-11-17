class SubmissionDetail < ActiveRecord::Base
  belongs_to :chart
  belongs_to :item
end
