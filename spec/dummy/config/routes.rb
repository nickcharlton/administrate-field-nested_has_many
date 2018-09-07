Rails.application.routes.draw do
  mount Deleteme::Engine::Engine => "/deleteme-engine"
end
