class BackfillSubmissionDetails < ActiveRecord::Migration[6.0]
  Submission = Class.new(ActiveRecord::Base)
  SubmissionDetail = Class.new(ActiveRecord::Base)
  Item = Class.new(ActiveRecord::Base)
  Chart = Class.new(ActiveRecord::Base)

  def up
    Chart.in_batches do |charts|
      charts.each do |chart|
        items = Item.where(chart_id: chart.id).each_with_object({}) do |item, hsh|
          hsh[item.name] = item
        end
        Submission.where(chart_id: chart.id).in_batches do |submissions|
          submissions.each do |submission|
            submission.data.each do |name, checked|
              item = items.fetch(name)
              SubmissionDetail.create!(
                chart_id: chart.id,
                submission_id: submission.id,
                item_id: item.id,
                checked: checked == "1"
              )
            end
          end
        end
      end
    end
  end

  def down
    SubmissionDetail.delete_all
  end
end
