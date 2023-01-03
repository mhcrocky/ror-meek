shared_examples 'grid list tabs'  do
  describe 'displaying of tabs' do

    it 'should show list item view by load' do
      expect(visible_page.view_switcher.grid_button).to be_visible
      expect(visible_page.view_switcher.list_button).to be_visible

      expect(visible_page.view_switcher).to have_list_button_active
      expect(visible_page.view_switcher).to have_no_grid_button_active

      expect(visible_page).to have_list_view
      expect(visible_page).to have_no_grid_view
    end

    it 'should change item view by switcher' do
      expect(visible_page.view_switcher).to have_list_button_active
      expect(visible_page.view_switcher).to have_no_grid_button_active

      expect(visible_page).to have_list_view
      expect(visible_page).to have_no_grid_view

      visible_page.view_switcher.grid_button.click

      expect(visible_page.view_switcher).to have_no_list_button_active
      expect(visible_page.view_switcher).to have_grid_button_active

      expect(visible_page).to have_no_list_view
      expect(visible_page).to have_grid_view

      visible_page.view_switcher.list_button.click

      expect(visible_page.view_switcher).to have_list_button_active
      expect(visible_page.view_switcher).to have_no_grid_button_active

      expect(visible_page).to have_list_view
      expect(visible_page).to have_no_grid_view
    end

  end
end
