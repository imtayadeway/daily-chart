class Stats
  attr_reader :scorables, :items

  def initialize(scorables, items)
    @scorables = scorables
    @items = items
  end

  def best_item
    items.max_by { |item| total_score_for(item.name) }.name
  end

  def worst_item
    items.min_by { |item| total_score_for(item) }.name
  end

  def total_score_for(item_name)
    scorables.map { |scorable| scorable.score_for(item_name) }.reduce(:+)
  end
end
