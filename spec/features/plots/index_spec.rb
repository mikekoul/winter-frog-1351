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

    it 'displays plants that belong to each plot' do
      turing_garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
      library_garden = Garden.create!(name: 'Public Library Garden', organic: true)   

      turing_plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: turing_garden_1.id)
      turing_plot_2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: turing_garden_1.id)
      library_plot = Plot.create!(number: 15, size: "Small", direction: "South", garden_id: turing_garden_1.id)
      other_plot = Plot.create!(number: 738, size: "Medium", direction: "West", garden_id: library_garden.id)

      tomato = Plant.create!(name: 'Tomato', description: 'Heirloom', days_to_harvest: 95)
      bell_pepper = Plant.create!(name: 'Bell Pepper', description: 'Red', days_to_harvest: 90)
      squash = Plant.create!(name: 'Squash', description: 'Patty Pan', days_to_harvest: 60)
      garlic = Plant.create!(name: 'Garlic', description: 'Bulb', days_to_harvest: 120)
      cucumber = Plant.create!(name: 'Cucumber', description: 'Yellow', days_to_harvest: 101)

      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: tomato.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: bell_pepper.id )
      PlotPlant.create!(plot_id: turing_plot_2.id, plant_id: squash.id )
      PlotPlant.create!(plot_id: library_plot.id, plant_id: garlic.id )
      PlotPlant.create!(plot_id: other_plot.id, plant_id: cucumber.id )
      PlotPlant.create!(plot_id: other_plot.id, plant_id: tomato.id )

      visit '/plots'

      within '#plots0' do
        expect(page).to have_content('Plot Number: 25')
        expect(page).to have_content('Tomato')
        expect(page).to have_content('Bell Pepper')
        expect(page).to_not have_content('Squash')
      end

      within '#plots1' do
        expect(page).to have_content('Plot Number: 26')
        expect(page).to have_content('Squash')
        expect(page).to_not have_content('Tomato')
      end

      within '#plots2' do
        expect(page).to have_content('Plot Number: 15')
        expect(page).to have_content('Garlic')
        expect(page).to_not have_content('Squash')
      end

      within '#plots3' do
        expect(page).to have_content('Plot Number: 738')
        expect(page).to have_content('Cucumber')
        expect(page).to have_content('Tomato')
        expect(page).to_not have_content('Garlic')
      end
    end
  end

  describe '#delete plant' do
    it 'next to each plant is a button to remove that plant from the plot' do
      turing_garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
      library_garden = Garden.create!(name: 'Public Library Garden', organic: true)   

      turing_plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: turing_garden_1.id)
      turing_plot_2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: turing_garden_1.id)
      library_plot = Plot.create!(number: 15, size: "Small", direction: "South", garden_id: turing_garden_1.id)
      other_plot = Plot.create!(number: 738, size: "Medium", direction: "West", garden_id: library_garden.id)

      tomato = Plant.create!(name: 'Tomato', description: 'Heirloom', days_to_harvest: 95)
      bell_pepper = Plant.create!(name: 'Bell Pepper', description: 'Red', days_to_harvest: 90)
      squash = Plant.create!(name: 'Squash', description: 'Patty Pan', days_to_harvest: 60)
      garlic = Plant.create!(name: 'Garlic', description: 'Bulb', days_to_harvest: 120)

      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: tomato.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: bell_pepper.id )
      PlotPlant.create!(plot_id: turing_plot_2.id, plant_id: squash.id )

      visit '/plots'

      within "#plants-#{tomato.id}" do
        expect(page).to have_content('Tomato')
        expect(page).to have_button("Remove Plant")
      end

      within "#plants-#{bell_pepper.id}" do
        expect(page).to have_content('Bell Pepper')
        expect(page).to have_button("Remove Plant")
      end

      within "#plants-#{squash.id}" do
        expect(page).to have_content('Squash')
        expect(page).to have_button("Remove Plant")
      end
    end
  end
end