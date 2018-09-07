Rails.application.routes.draw do
  namespace :admin do
    root to: redirect("/admin/schools")
    resources :schools
    resources :students
  end
end
