require "rails_helper"

feature "Has many" do
  let!(:school) do
    FactoryBot.create(:school, name: "School of Life")
  end

  let!(:student) do
    FactoryBot.create(:student, name: "John Doe", school: school)
  end

  scenario "index page" do
    visit admin_schools_path
    expect(page).to have_content("School of Life")
  end

  scenario "show page" do
    visit admin_school_path(school)
    expect(page).to have_content("John Doe")
  end
end
