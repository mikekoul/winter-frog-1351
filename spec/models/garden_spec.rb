require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plot_plants).through(:plots) }
    it { should have_many(:plants).through(:plot_plants) }
  end

  describe '#methods' do
    it 'returns a unique array of plants with a harvest time of less than 100 days' do

      turing_garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
  
      turing_plot_1 = Plot.create!(number: 25, size: "Large", direction: "East", garden_id: turing_garden_1.id)
      turing_plot_2 = Plot.create!(number: 26, size: "Small", direction: "West", garden_id: turing_garden_1.id)

      tomato = Plant.create!(name: 'Tomato', description: 'Heirloom', days_to_harvest: 95)
      bell_pepper = Plant.create!(name: 'Bell Pepper', description: 'Red', days_to_harvest: 90)
      squash = Plant.create!(name: 'Squash', description: 'Patty Pan', days_to_harvest: 110)
      potato = Plant.create!(name: 'Potato', description: 'Russet', days_to_harvest: 99)
      garlic = Plant.create!(name: 'Garlic', description: 'Bulb', days_to_harvest: 120)

      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: tomato.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: bell_pepper.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: squash.id )
      PlotPlant.create!(plot_id: turing_plot_1.id, plant_id: potato.id )
      PlotPlant.create!(plot_id: turing_plot_2.id, plant_id: tomato.id )
      PlotPlant.create!(plot_id: turing_plot_2.id, plant_id: garlic.id )

      expect(turing_garden_1.short_harvest).to match_array([tomato, bell_pepper, potato])
    end
  end
end
