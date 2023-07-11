# frozen_string_literal: true

# Products Controller
class Api::ProductsController < ApplicationController
  def index
    products_by_category = Product.group(:category).order(:category).map do |product|
      {
        category: product.category,
        products: Product.where(category: product.category)
      }
    end

    total_weight_by_category = Product.group(:category).sum('weight')
    weighing_start_date = Product.minimum(:date)

    render json: {
      products_by_category: products_by_category,
      total_weight_by_category: total_weight_by_category,
      weighing_start_date: weighing_start_date
    }
  end
end
