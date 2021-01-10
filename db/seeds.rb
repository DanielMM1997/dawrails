# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

file = File.read('app\assets\backgrounds.json')

User.create!({nickname: "admin", email: "admin@gmail.com", password: "123456789", type: 1})
User.create!({nickname: "moderador", email: "moderador@gmail.com", password: "123456789", type: 2})

Category.create([
    { name: 'animales' }, 
    { name: 'paisajes' }, 
    { name: 'universo' }, 
    { name: 'ciudades' }, 
    { name: 'universo' }, 
    { name: 'coches' }, 
    { name: 'motos' }, 
    { name: 'aviones' }, 
    { name: 'futbol' }, 
    { name: 'baloncesto' }, 
    { name: 'tenis' }])

datos = JSON.parse(file)
backgrounds = datos['backgrounds']

backgrounds.each do |background|
    Background.create!({
        title: background[0]["title"],
        path: background[0]["url"],
        tags: background[0]["tags"],
        author_id: 1
    })
end