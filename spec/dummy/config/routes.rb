Rails.application.routes.draw do
  root to: redirect("/admin/schools")
  namespace :admin do
    root to: redirect("/admin/schools")
    resources :schools
    namespace :foo do
      resources :students
    end
  end
end
