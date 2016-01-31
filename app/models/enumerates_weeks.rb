class EnumeratesWeeks
  def self.for(scorables)
    1.upto((scorables.size / 7) + 1).to_a
  end
end
