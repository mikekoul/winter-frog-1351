require 'rails_helper'

RSpec.describe 'plot index page' do
  describe '#index' do
    it 'displays all the plot numbers' do
      turing_garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
      library_garden = Garden.create!(name: 'Public Library Garden', organic: true)   

      turing_plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: turing_garden_1.id)
      turing_plot_2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: turing_garden_1.id)
      library_plot = Plot.create!(number: 15, size: "Small", direction: "South", garden_id: turing_garden_1.id)
      other_plot = Plot.create!(number: 738, size: "Medium", direction: "West", garden_id: library_garden.id)

      visit '/plots'

      within '#plots0' do
        expect(page).to have_content('Plot Number: 25')
        expect(page).to_not have_content('Plot Number: 26')
      end

      within '#plots1' do
        expect(page).to have_content('Plot Number: 26')
        expect(page).to_not have_content('Plot Number: 15')
      end

      within '#plots2' do
        expect(page).to have_content('Plot Number: 15')
        expect(page).to_not have_content('Plot Number: 738')
      end

      within '#plots3' do
        expect(page).to have_content('Plot Number: 738')
        expect(page).to_not have_content('Plot Number: 25')
      end
    end
  end
end