Dokumendid::Application.routes.draw do
  root "documents#index"

  resources :catalogs do
    resources :documents, only: [:index, :new, :create]
  end

  resources :documents, only: [:show, :edit, :update, :destroy]
end
