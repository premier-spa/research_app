require "application_system_test_case"

class LabsTest < ApplicationSystemTestCase
  setup do
    @lab = labs(:one)
  end

  test "visiting the index" do
    visit labs_url
    assert_selector "h1", text: "Labs"
  end

  test "creating a Lab" do
    visit labs_url
    click_on "New Lab"

    fill_in "About Us", with: @lab.about_us
    fill_in "Access", with: @lab.access
    fill_in "Address", with: @lab.address
    fill_in "Email", with: @lab.email
    fill_in "Facility", with: @lab.facility
    fill_in "Fax", with: @lab.fax
    fill_in "Lat", with: @lab.lat
    fill_in "Lon", with: @lab.lon
    fill_in "Majar", with: @lab.majar
    fill_in "Message", with: @lab.message
    fill_in "Name", with: @lab.name
    fill_in "Purpose", with: @lab.purpose
    fill_in "Tel", with: @lab.tel
    click_on "Create Lab"

    assert_text "Lab was successfully created"
    click_on "Back"
  end

  test "updating a Lab" do
    visit labs_url
    click_on "Edit", match: :first

    fill_in "About Us", with: @lab.about_us
    fill_in "Access", with: @lab.access
    fill_in "Address", with: @lab.address
    fill_in "Email", with: @lab.email
    fill_in "Facility", with: @lab.facility
    fill_in "Fax", with: @lab.fax
    fill_in "Lat", with: @lab.lat
    fill_in "Lon", with: @lab.lon
    fill_in "Majar", with: @lab.majar
    fill_in "Message", with: @lab.message
    fill_in "Name", with: @lab.name
    fill_in "Purpose", with: @lab.purpose
    fill_in "Tel", with: @lab.tel
    click_on "Update Lab"

    assert_text "Lab was successfully updated"
    click_on "Back"
  end

  test "destroying a Lab" do
    visit labs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lab was successfully destroyed"
  end
end
