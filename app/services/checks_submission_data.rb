class ChecksSubmissionData
  def self.ok?(chart, data)
    Set.new(data.keys) == Set.new(chart.item_names) &&
      data.values.all? { |value| %w(0 1).include?(value) }
  end
end
