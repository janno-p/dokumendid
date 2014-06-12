# Project:: IDU0200
# Author::  Janno Põldma (139015 FAY)
# Version:: 1.0 (11.06.2014)

Dokumendid::Application.routes.draw do
  root "documents#index"

  resources :catalogs do
    resources :documents, only: [:index, :new, :create]
  end

  resources :documents, only: [:show, :edit, :update, :destroy]

  get "documents/attributes/:id", to: "documents#attributes"

  get "clipboard/add/:id", to: "clipboard#add"
  get "clipboard/remove/:id", to: "clipboard#remove"
  get "clipboard/index/:catalog", to: "clipboard#index"
  get "clipboard/clear", to: "clipboard#clear"
  get "clipboard/paste/:catalog", to: "clipboard#paste"

  get "sign_in", to: "session#sign_in"
  post "sign_in", to: "session#sign_in"

  get "sign_out", to: "session#sign_out"

  get 'static/log'

  get "search/index", to: "search#index"
  post "search/results", to: "search#results"

  get "forms/:form_name/attributes/:doc_type", to: "forms#attributes"
end
