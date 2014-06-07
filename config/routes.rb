Dokumendid::Application.routes.draw do
  root "documents#index"

  resources :catalogs do
    resources :documents, only: [:index, :new, :create]
  end

  resources :documents, only: [:show, :edit, :update, :destroy]

  get "documents/attributes/:id", to: "documents#attributes"

  get "sign_in", to: "session#sign_in"
  post "sign_in", to: "session#sign_in"

  get "sign_out", to: "session#sign_out"
end
