class EnumeratesWeeks
  def self.for(days)
    return [1] if days.zero?
    1.upto((days.to_f / 7).ceil).to_a
  end
end
