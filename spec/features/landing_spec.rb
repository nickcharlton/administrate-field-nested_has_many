require "rails_helper"

feature "Landing" do
  scenario "Initial admin page" do
    visit admin_root_path
    expect(page).to have_content("Schools")
    expect(page).to have_content("Students")
  end
end
