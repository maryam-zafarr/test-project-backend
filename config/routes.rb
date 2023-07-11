# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :csv_imports, only: [:create]
    resources :products, only: [:index]
  end
end
