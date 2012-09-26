def login(user)
  visit new_user_session_path
  within(:xpath, "//div[@id='main']") do
    fill_in "user_login", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Login"
  end
end