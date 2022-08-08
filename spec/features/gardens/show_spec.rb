require 'rails_helper'

RSpec.describe 'garden show page' do
  describe '#show' do
    it 'displays a unique list of plants that take less than 100 days to harvest' do

      turing_garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
      library_garden = Garden.create!(name: 'Public Library Garden', organic: true)   

      turing_plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: turing_garden_1.id)
      turing_plot_2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: turing_garden_1.id)
      other_plot = Plot.create!(number: 738, size: "Medium", direction: "West", garden_id: library_garden.id)

      tomato = Plant.create!(name: 'Tomato', description: 'Heirloom', days_to_harvest: 95)
      bell_pepper = Plant.create!(name: 'Bell Pepper', description: 'Red', days_to_harvest: 90)
      squash = Plant.create!(name: 'Squash', description: 'Patty Pan', days_to_harvest: 110)
      potato = Plant.create!(name: 'Potato', description: 'Russet', days_to_harvest: 99)
      garlic = Plant.create!(name: 'Garlic', description: 'Bulb', days_to_harvest: 120)
      cucumber = Plant.create!(name: 'Cucumber', description: 'Yellow', days_to_harvest: 101)

      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: tomato.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: bell_pepper.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: squash.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: potato.id )
      PlotPlant.create!(plot_id: turing_plot_2.id, plant_id: tomato.id )
      PlotPlant.create!(plot_id: turing_plot_2.id, plant_id: garlic.id )
      PlotPlant.create!(plot_id: other_plot.id, plant_id: cucumber.id )

      visit "gardens/#{turing_garden_1.id}"

      expect(page).to have_content("Turing Community Garden Show Page")
      expect(page).to_not have_content("Public Library Garden Show Page")

      within "#plants0" do
        expect(page).to have_content("Tomato")
        expect(page).to have_content("Days To Harvest: 95")
      end

      within "#plants1" do
        expect(page).to have_content("Bell Pepper")
        expect(page).to have_content("Days To Harvest: 90")
      end

      within "#plants2" do
        expect(page).to have_content("Potato")
        expect(page).to have_content("Days To Harvest: 99")
      end
      
      expect(page).to_not have_content("Squash")
      expect(page).to_not have_content("Days To Harvest: 110")
      expect(page).to_not have_content("Garlic")
      expect(page).to_not have_content("Days To Harvest: 120")
      expect(page).to_not have_content("Cucumber")
      expect(page).to_not have_content("Days To Harvest: 101")
    end
  end
end