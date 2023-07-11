# frozen_string_literal: true

# Represents a product in the system.
class Product < ApplicationRecord
  validates :name, :weight, :category, :unit, :date, presence: true

  UNIT_OPTIONS = %w[kilograms pounds grams].freeze
  validates :unit, inclusion: { in: UNIT_OPTIONS }

  before_save :convert_weight_to_kilograms, if: :weight_changed?

  private

  def convert_weight_to_kilograms
    case unit.downcase
    when 'pounds'
      self.weight = weight.to_f * 0.453592
    when 'grams'
      self.weight = weight.to_f / 1000
    end
  end
end
