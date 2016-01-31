class CalculatesAverages
  def self.for(scorables)
    scorables.each_slice(7).map do |week|
      week.map(&:percent).inject(:+) / week.size
    end
  end
end
