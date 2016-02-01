class CalculatesAverages
  def self.for(scorables)
    scorables.each_slice(7).map do |week|
      (week.map(&:percent).inject(:+).to_f / week.size).round(2)
    end
  end
end
