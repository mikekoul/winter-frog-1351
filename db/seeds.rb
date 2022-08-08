turing_garden_1 = Garden.create!(name: 'Turing Community Garden', organic: true)
library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
other_garden = Garden.create!(name: 'Main Street Garden', organic: false)

turing_plot_1 = Plot.create!(number: 25, size: "Large", direction: "East")
turing_plot_2 = Plot.create!(number: 26, size: "Small", direction: "West")
library_plot = Plot.create!(number: 2, size: "Small", direction: "South")
other_plot = Plot.create!(number: 738, size: "Medium", direction: "West")

tomato = Plant.create!(name: 'Potatoe', description: 'Russet', days_to_harvest: 95)
bell_pepper = Plant.create!(name: 'Bell Pepper', description: 'Red', days_to_harvest: 90)
squash = Plant.create!(name: 'Squash', description: 'Patty Pan', days_to_harvest: 60)
garlic = Plant.create!(name: 'Garlic', description: 'Bulb', days_to_harvest: 120)
cucumber = Plant.create!(name: 'Cucumber', description: 'Yellow', days_to_harvest: 101)

