require "rails_helper"

feature "Has many" do
  let!(:school) do
    FactoryBot.create(:school, name: "School of Life")
  end

  let!(:student) do
    FactoryBot.create(:student, name: "John Doe", school: school)
  end

  scenario "index" do
    visit admin_schools_path
    expect(page).to have_content("School of Life")
  end

  scenario "show" do
    visit admin_school_path(school)
    expect(page).to have_content("John Doe")
  end

  scenario "new" do
    visit new_admin_school_path
    expect(page).to have_content("New Schools")
  end

  scenario "create", js: true do
    visit new_admin_school_path
    expect(page).to have_content("New Schools")
    expect(page).to have_content("Add Foo/Student")
    fill_in "Name", with: "La Ferme du Bec Hellouin"
    click_link "Add Foo/Student"
    expect(page).to have_content("Remove Foo/Student")
    within(".nested-fields") do
      fill_in "Name", with: "Sébastien"
    end
    click_button "Create School"
    expect(page).to have_text("La Ferme du Bec Hellouin")
    expect(page).to have_text("Sébastien")
  end

  scenario "edit" do
    school = FactoryBot.create(:school)
    FactoryBot.create_list(:student, 2, school: school)
    visit edit_admin_school_path(school)
    expect(page).to have_content("Edit #{school.name}")
  end

  scenario "update", js: true do
    school = FactoryBot.create(:school)
    student = FactoryBot.create(:student, school: school)
    visit edit_admin_school_path(school)
    click_link "Add Foo/Student"

    within(all(".nested-fields").last) do
      fill_in "Name", with: "Sébastien"
    end

    within(all(".nested-fields").first) do
      click_link "Remove Foo/Student"
    end

    click_button "Update School"

    expect(page).to have_text("Sébastien")
    expect(page).not_to have_text(student.name)
  end
end
