require_relative "deck"

class Hand

  attr_accessor :cards, :value

  def initialize(deck)
    @cards = deck.draw(5)
    @value = 0
  end

  def draw(deck, n)
    self.cards += deck.draw(n)
  end

  def discard(indices)
    self.cards = cards.reject { |card| indices.include?(cards.index(card)) }
  end

  def pair?
    if value_count.values.include?(2)
      self.value = 1
      return true
    else
      false
    end
  end

  def triplet?
    if value_count.values.include?(3)
      self.value = 2
      true
    else
      false
    end
  end

  def straight?
    values = cards.map { |card| card.value }
    value_indices = values.map { |value| Card::VALUES.keys.index(value) }
    smallest = value_indices.min
    if (smallest..smallest + 4).to_a == value_indices.sort
      self.value = 3
      true
    else
      false
    end
  end

  def flush?
    if suit_count.values.include?(5)
      self.value = 4
      true
    else
      false
    end
  end

  def full_house?
    if pair? && triplet?
      self.value = 5
      true
    else
      false
    end
  end

  def quad?
    if value_count.values.include?(4)
      self.value = 6
      true
    else
      false
    end
  end

  def straight_flush?
    if straight? && flush?
      self.value = 7
      true
    else
      false
    end
  end

  def beats?(other_hand)
    self.evaluate
    other_hand.evaluate

    if self.value > other_hand.value
      true
    elsif self.value < other_hand.value
      false
    else
      my_values = self.cards.map(&:n_value).sort
      your_values = other_hand.cards.map(&:n_value).sort

      case self.value

      when 0, 3, 4, 7
        until my_values.empty?
          me = my_values.pop
          you = your_values.pop

          if me > you
            return true
          elsif you > me
            return false
          end

          return nil
        end
      end



    end
  end

  def evaluate
    pair?; triplet?; straight?; flush?; full_house?; quad?; straight_flush?
  end

  private
  def value_count
    res = Hash.new(0)
    cards.each { |card| res[card.value] += 1 }
    res
  end

  def suit_count
    res = Hash.new(0)
    cards.each { |card| res[card.suit] += 1 }
    res
  end


end
