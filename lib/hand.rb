require_relative "deck"

class Hand

  attr_accessor :cards, :value

  def initialize(cards)
    @cards = cards
    @value = 0
  end

  def draw(deck, n)
    self.cards += deck.draw(n)
  end

  def discard(indices)
    self.cards = cards.reject { |card| indices.include?(cards.index(card)) }
  end

  def pair?
    if card_type_count.values.include?(2)
      self.value = 1
      return true
    else
      false
    end
  end

  def two_pair?
    cards_of_a_type = card_type_count.values
    num_pairs = cards_of_a_type.select { |num_cards| num_cards == 2 }
    if num_pairs.count == 2
      self.value = 2
      true
    else
      false
    end
  end

  def triplet?
    if card_type_count.values.include?(3)
      self.value = 3
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
      self.value = 4
      true
    else
      false
    end
  end

  def flush?
    if suit_count.values.include?(5)
      self.value = 5
      true
    else
      false
    end
  end

  def full_house?
    if pair? && triplet?
      self.value = 6
      true
    else
      false
    end
  end

  def quad?
    if card_type_count.values.include?(4)
      self.value = 7
      true
    else
      false
    end
  end

  def straight_flush?
    if straight? && flush?
      self.value = 8
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
      my_multiples = extract_multiples
      my_singles = cards.sort.reverse - my_multiples.flatten
      other_multiples = other_hand.extract_multiples
      other_singles = other_hand.cards.sort.reverse - other_multiples.flatten

      mults = compare_arrays(my_multiples, other_multiples)
      return mults unless mults.nil?

      compare_arrays(my_singles, other_singles)
    end
  end

  def compare_arrays(arr1, arr2)
    until arr1.empty?
      my_el = arr1.shift
      other_el = arr2.shift
      if my_el > other_el
        return true
      elsif my_el < other_el
        return false
      end
      nil
    end

  end

  def evaluate
    pair?; triplet?; straight?; flush?; full_house?; quad?; straight_flush?
  end

  def card_type_count
    res = Hash.new(0)
    cards.each { |card| res[card.value] += 1 }
    res
  end

  def suit_count
    res = Hash.new(0)
    cards.each { |card| res[card.suit] += 1 }
    res
  end

  def extract_multiples

    multiples = []
    sorted_cards = cards.sort.reverse
    until sorted_cards.empty?
      new_card = sorted_cards.shift
      if sorted_cards.include?(new_card) || multiples.include?(new_card)
        multiples << new_card
      end
    end

    if full_house?
      multiples.pop(2)
      multiples.shift(2)
      multiples *= 3
    end

    multiples
  end

end
