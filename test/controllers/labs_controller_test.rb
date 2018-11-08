require 'test_helper'

class LabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lab = labs(:one)
  end

  test "should get index" do
    get labs_url
    assert_response :success
  end

  test "should get new" do
    get new_lab_url
    assert_response :success
  end

  test "should create lab" do
    assert_difference('Lab.count') do
      post labs_url, params: { lab: { about_us: @lab.about_us, access: @lab.access, address: @lab.address, email: @lab.email, facility: @lab.facility, fax: @lab.fax, lat: @lab.lat, lon: @lab.lon, majar: @lab.majar, message: @lab.message, name: @lab.name, purpose: @lab.purpose, tel: @lab.tel } }
    end

    assert_redirected_to lab_url(Lab.last)
  end

  test "should show lab" do
    get lab_url(@lab)
    assert_response :success
  end

  test "should get edit" do
    get edit_lab_url(@lab)
    assert_response :success
  end

  test "should update lab" do
    patch lab_url(@lab), params: { lab: { about_us: @lab.about_us, access: @lab.access, address: @lab.address, email: @lab.email, facility: @lab.facility, fax: @lab.fax, lat: @lab.lat, lon: @lab.lon, majar: @lab.majar, message: @lab.message, name: @lab.name, purpose: @lab.purpose, tel: @lab.tel } }
    assert_redirected_to lab_url(@lab)
  end

  test "should destroy lab" do
    assert_difference('Lab.count', -1) do
      delete lab_url(@lab)
    end

    assert_redirected_to labs_url
  end
end
