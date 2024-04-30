require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Games"
  # end
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Submitting a word that is not in the grid displays a message that the word can't be built from the grid" do
    visit new_url
    fill_in "word", with: "test"
    click_on "Check word"
    assert_text "Sorry but test can't be built out of"
  end
end
