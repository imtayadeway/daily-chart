class DropSerializedSubmissionData < ActiveRecord::Migration[6.0]
  Submission = Class.new(ActiveRecord::Base)
  SubmissionDetail = Class.new(ActiveRecord::Base)
  Item = Class.new(ActiveRecord::Base)

  def up
    remove_column :submissions, :data
  end

  def down
    add_column :submissions, :data, :json

    Submission.in_batches do |submissions|
      submissions.each do |submission|
        details = SubmissionDetail.where(submission_id: submission.id)
        data = details.each_with_object({}) do |detail, hsh|
          item = Item.find(detail.item_id)
          hsh[item.name] = detail.checked? ? "1" : "0"
        end
        submission.update!(data: data)
      end
    end
  end
end
