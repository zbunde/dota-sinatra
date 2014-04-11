require 'spec_helper'
require_relative '../../lib/hero_repository'
require 'sequel'


describe 'Hero Repository' do
  before do
    DB[:heroes].delete
    @database = HeroRepository.new(DB)
  end

  it 'Admin can add a hero to the database' do
    id = @database.create(name: "zoggert", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    expect(@database.index).to eq([{id: id, name: "zoggert", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png"}])
  end

  it 'can find the name of the hero by id' do
   id = @database.create(name: "zoggert", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    expect(@database.find_name(id)).to eq("zoggert")
  end

  it 'can find the names of all the heroes' do
    @database.create(name: "zoggert", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    @database.create(name: "frogger", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    expect(@database.all_names).to eq([{:name => "zoggert"}, {:name => "frogger"}])
  end
  it 'can show individual heroes' do
    id = @database.create(name: "zoggert", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    @database.create(name: "frogger", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    expect(@database.show(id)).to eq(id: id, name: "zoggert", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
  end

  it 'can update heroes in the database' do
    hero = @database.create(name: "frogger", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    @database.update(hero, name: "cool", description: "wtf  ", hero_type: "Support", image:"hello")
    expect(@database.show(hero)). to eq(id: hero, name: "cool", description: "wtf", hero_type: "Support", image: "hello")
  end
  it 'can delete heroes from database' do
    hero = @database.create(name: "frogger", description: "lives in a cave", hero_type: "Carry", image: "/Users/zbunde/dota2/hero_images/axe.png")
    @database.delete(hero)
    expect(@database.index).to eq([])
  end
end

