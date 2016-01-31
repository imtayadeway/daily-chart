class EnumeratesWeeks
  def self.for(days)
    1.upto((days / 7) + 1).to_a
  end
end
