Dokumendid::Application.routes.draw do
  root "documents#index"

  resources :catalogs do
    resources :documents, only: [:index, :new, :create]
  end

  resources :documents, only: [:show, :edit, :update, :destroy]

  get "documents/attributes/:id", to: "documents#attributes"
  get "documents/buffer/:id/add", to: "documents#add_to_buffer"
  get "documents/buffer/:id/remove", to: "documents#remove_from_buffer"

  get "sign_in", to: "session#sign_in"
  post "sign_in", to: "session#sign_in"

  get "sign_out", to: "session#sign_out"
end
